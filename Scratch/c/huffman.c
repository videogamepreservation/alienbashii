// Huffman encoding algorithm with run length encoding
//	G.Cumming 1995
//	Version 0.1

#include "huffman.h"

int Best[8];
int Occur[256];
unsigned char *sourcebuff;
unsigned char *destbuff;
unsigned char *modulobuff;
unsigned char *destptr;
unsigned char *sourceptr;
unsigned long bitpos=0, blocksize=0;
long int fsize=0,newsize=0;
int bit=0x80;
FILE *file1, *file2;
compresstype CurrentType;

long int AddPos = 0, AddIndex=0, AddSize;
int LastAddIndex=0, PosOffset=0;

/////////////////////////////////////////////////////////
// Read header
/////////////////////////////////////////////////////////
void ReadHeader()
{
int loop;

  AddSize = GetBitsFromDest(8)<<8;		// Read block size
  AddSize += GetBitsFromDest(8);
  CurrentType = ((compresstype)GetBitsFromDest(2))+1;		// Get compression modulo
  for( loop=0; loop<8; loop++)      		// Get huffman table
    Best[loop] = GetBitsFromDest(8);
}

/////////////////////////////////////////////////////////
// Routine to add 8 or less bits to the dest data
/////////////////////////////////////////////////////////
void AddBitsToDest( unsigned char data, int numbits )
{
int sourcepos = 1 << (numbits-1);
int loop;

  for( loop=0; loop < numbits; loop++ )
    {
    if ( data & sourcepos )
      *destptr |= bit;
    bit >>=1;
    sourcepos >>=1;
    if( !bit )
      {
      destptr++;
      bit = 0x80;
      }
    bitpos++;
    if( bitpos == (long)BUFF_SIZE*8 )			// End of buffer reached??
      {
      fwrite( destbuff, 1, BUFF_SIZE, file2 );
      memset( (void*)destbuff, 0, BUFF_SIZE );		// Zero data again
      destptr = destbuff;                       	// Reset buff ptr
      bitpos=0;
      bit = 0x80;
      newsize += BUFF_SIZE;
      }
    }
}

/////////////////////////////////////////////////////////
// Routine to get data
/////////////////////////////////////////////////////////
unsigned char GetBitsFromDest( int numbits )
{
int loop;
unsigned char dat=0;

  for( loop=0; loop < numbits; loop++ )
    {
    dat <<=1;
    if( *sourceptr & bit )
      dat +=1;
    bit >>=1;
    if( !bit )
      {
      sourceptr++;
      bit = 0x80;
      }
    bitpos++;
    if( bitpos == (long)BUFF_SIZE*8 )		// End of buffer reached??
      {
      fread( (void*)sourcebuff, 1, BUFF_SIZE, file1 );
      sourceptr = sourcebuff;			// Reset buff pointer
      bitpos=0;
      bit = 0x80;
      }
    }
  return dat;
}

////////////////////////////////////////////////////
// Routine to store 8 most frequently observed bytes
////////////////////////////////////////////////////
void StoreBest( int pos )
{
int loop,loop2;

  for( loop=0; loop < 8; loop++ )
    {
    if( Occur[Best[loop]] < Occur[pos] )
      {
      for( loop2 = 7; loop2 > loop; loop2-- )		// shift list down
	     Best[loop2] = Best[loop2-1];
      Best[loop] = pos;
      return;
      }
    }
}


////////////////////////////////////////////////////
// Routine to check data to see if huff type
////////////////////////////////////////////////////
blocktype CheckType( unsigned char dat )
{
int loop;

  for(loop=0; loop< 8; loop++ )
    if( Best[loop] == dat && Best[loop] != -1 )
      return HUFF_BLOCK;
  return NORMAL_BLOCK;
}

////////////////////////////////////////////////////
// Routine to get huff code
////////////////////////////////////////////////////
unsigned char GetType( unsigned char dat )
{
unsigned char loop;

  for(loop=0; loop< 8; loop++ )
    if( Best[loop] == dat )
      return loop;
  return 0;
}

////////////////////////////////////////////////////
// Scan data for huff codes
////////////////////////////////////////////////////
int ScanData( unsigned char *data, int size )
{
  while( size-- )
    if( CheckType(*(data++)) == HUFF_BLOCK )
      return 1;
  return 0;
}


/////////////////////////////////////////////////////
// Routine to add data to dest
/////////////////////////////////////////////////////
void AddBlock( unsigned char *data, int size, blocktype type )
{

 switch( type )
  {
    case MIXED_BLOCK:
      if( ScanData( data, size ) )		// Line contain huff's??
	{
	AddBitsToDest( MIXED_BLOCK, 2 );
	AddBitsToDest( size, 8 );
	while( size-- )
          {
	  if( CheckType( *data ) == HUFF_BLOCK )
	    {
	    AddBitsToDest( 1, 1 );
	    AddBitsToDest( GetType( *(data++) ), 3 );
	    }
	  else
	    {
	    AddBitsToDest( 0, 1 );
	    AddBitsToDest( *(data++), 8 );
	    }
	  }
	}
      else
	{
	AddBitsToDest( MIXED_NORMAL_BLOCK, 2 );
	AddBitsToDest( size, 8 );
        while( size-- )
	  AddBitsToDest( *(data++), 8 );
	}
      break;
    case HUFF_BLOCK:
      AddBitsToDest( HUFF_BLOCK, 2 );
      AddBitsToDest( size, 8 );
      AddBitsToDest( GetType( *data ), 3 );		// Repeated value
      break;
    case NORMAL_BLOCK:
      AddBitsToDest( NORMAL_BLOCK, 2 );
      AddBitsToDest( size, 8 );
      AddBitsToDest( *data, 8 );		// Repeated value
      break;
    default:
      break;
  }
}

////////////////////////////////////////////////////
// Routine to add huffman header info
////////////////////////////////////////////////////
void AddHeaderInfo( compresstype type, long int size )
{
int loop;

  AddBitsToDest( (size>>8), 8 );
  AddBitsToDest( size & 0xFF, 8 );
  AddBitsToDest( type-1, 2 );
  for(loop=0; loop< 8; loop++)
    AddBitsToDest( Best[loop], 8 );
}


////////////////////////////////////////////////////
// Routine to store de-crunched data into buffer
////////////////////////////////////////////////////
void AddToDestBuff( unsigned char dat, int rep )
{
  while( rep-- )
    {
    destbuff[AddPos+AddIndex] = dat;
    AddIndex+=CurrentType;
    if( AddIndex >= AddSize )
      {
      PosOffset++;     
      AddIndex = AddPos+PosOffset;		// Reset index
      }
    blocksize++;			// Inc number of bytes de-compressed
    if( blocksize == (long)BUFF_SIZE )
      {
      fwrite( (void*)destbuff, 1, BUFF_SIZE, file2 );            
      blocksize=0;
      AddPos=0;
      AddIndex=0;
      PosOffset=0;
      }
    }
}

////////////////////////////////////////////////////
// Routine to find block occurancies
////////////////////////////////////////////////////
void FindBlockOccurancies( long amntread )
{
unsigned char *block;
int loop;

    memset( (void*)Best, -1, sizeof(int)*8 );
    memset( (void*)Occur, 0, sizeof(int)*256 );				// Clear mem
    block = sourcebuff;
    while( amntread-- )
      Occur[*(block++)]++;
    for( loop=0; loop< 256; loop++ )					// Find best 8
      StoreBest( loop );
}

////////////////////////////////////////////////////
// Get compression on block
////////////////////////////////////////////////////
long int GetBlockCompression( unsigned char *data, long size )
{
unsigned char byte;
long reps, current, pos=0;
long reppos;
int ProcessRep;
long int blocksize=0;

  while( pos < size )
    {
    reps=0;
    reppos = pos;
    byte = data[pos];
    ProcessRep = 0;
    current=1;
    while( current < NUM_SIZE && pos+current < size )
      {
      if( byte == data[pos+current] )				// Matching char??
	{
	if( reps > MIN_REPS && !ProcessRep ) 			// Have we found a good rep
	  {
	  ProcessRep = 1;
	  if( reppos != pos )					// Did this rep start immediately
            blocksize+=(reppos-pos)+1;
	  current = reps;					// Continue at repeat
	  pos = reppos;
	  }
	reps++;
	}
      else
	{
	if( reps > MIN_REPS && ProcessRep )			// Was a rep started
	  {
	  blocksize +=2;
	  pos += reps;						// Move past rep block
	  current = 0;						// Restart pos
	  ProcessRep = 0;
	  }
	reps=0;
	byte = data[pos+current];				// set new search goal
	reppos = pos+current;
	}
      current++;
      }
    if( ProcessRep )						// Were we processing rep?
      blocksize +=2;
    else
      blocksize += (current+1);
    pos += current;
    }
  return blocksize;
}


////////////////////////////////////////////////////
// Re-order source buffer
////////////////////////////////////////////////////
void ReorderSource( long int size, compresstype type )
{
int index = 0, lastindex=0, loop;

  for( loop=0; loop < size; loop++ )
    {
    modulobuff[loop] = sourcebuff[index];
    index+=type;
    if( index >= size )
      index = ++lastindex;
    }
}


////////////////////////////////////////////////////
// Find best compress type
////////////////////////////////////////////////////
compresstype FindCompressType( long int size )
{
long int csize=0, temp;
int loop;
compresstype best=MODULO_1;

  csize = GetBlockCompression( sourcebuff, size );
  for( loop=MODULO_2; loop <= MODULO_4; loop++ )
    {
    ReorderSource( size, (compresstype)loop );
    if( (temp = GetBlockCompression( modulobuff, size )) < csize )
      {
      csize = temp;
      best = (compresstype)loop;
      }
    }
  printf( "Using modulo%1d\n", best );
  return best;
}

////////////////////////////////////////////////////
// Routine to compress a block of data
////////////////////////////////////////////////////
void CompressBlock( unsigned char *data, long size )
{
unsigned char byte;
long reps, current, pos=0;
long reppos;
int ProcessRep;

  while( pos < size )
    {
    reps=0;
    reppos = pos;
    byte = data[pos];
    ProcessRep = 0;
    current=1;
    while( current < NUM_SIZE && pos+current < size )
      {
      if( byte == data[pos+current] )				// Matching char??
	{
	if( reps > MIN_REPS && !ProcessRep ) 			// Have we found a good rep
	  {
	  ProcessRep = 1;
	  if( reppos != pos )					// Did this rep start immediately
	    AddBlock( &data[pos], reppos-pos, MIXED_BLOCK ); 	// No so throw away start
	  current = reps;					// Continue at repeat
	  pos = reppos;
	  }
	reps++;
	}
      else
	{
	if( reps > MIN_REPS && ProcessRep )			// Was a rep started
	  {
	  AddBlock( &data[pos], reps, CheckType( byte ) );	// Add rep string
	  pos += reps;						// Move past rep block
	  current = 0;						// Restart pos
	  ProcessRep = 0;
	  }
	reps=0;
	byte = data[pos+current];				// set new search goal
	reppos = pos+current;
	}
      current++;
      }
    // Write end data
    if( ProcessRep )						// Were we processing rep?
      AddBlock(  &data[reppos], reps, CheckType( byte ) );
    else
      AddBlock( &data[pos], current , MIXED_BLOCK ); 		// Store non rep string
    pos += current;
    }
}


////////////////////////////////////////////////////
// Routine to compress a file
////////////////////////////////////////////////////
void CompressFile()
{
long amntread;
int BlockWritten=0;
compresstype type;

  memset( (void*)destbuff, 0, BUFF_SIZE );			// Clear dest initially

  while( ( amntread = fread( sourcebuff, 1, BUFF_SIZE, file1 ) ) > 0 )	// Read block
    {
    if( BlockWritten )
      {
      AddBitsToDest( 1, 2 );					// Add block termination code
      AddBitsToDest( 0, 8 );
      }
    fsize += amntread;
    FindBlockOccurancies( amntread );
    type = FindCompressType( amntread );			// Regular compression best??
    AddHeaderInfo( type, amntread );
    CompressBlock( (type==MODULO_1)?sourcebuff:modulobuff, amntread );
    BlockWritten = 1;
    }
  AddBitsToDest( 0, 2 );					// Add file termination code
  AddBitsToDest( 0, 8 );
  if( bitpos )							// Remaining data??
    {
    fwrite( destbuff, 1, ((bitpos+7)>>3), file2 );
    newsize += (bitpos+7)>>3;
    }
}

///////////////////////////////////////////////////////
// Routine to decompress a file
///////////////////////////////////////////////////////
void DecompressFile()
{
unsigned char dat;
int size;
int finished=0;

  fread( (void*)sourcebuff, 1, BUFF_SIZE, file1 );	// Read initial block		
  bitpos=0;
  ReadHeader();						// Get table
  while( !finished )
    {
    dat = GetBitsFromDest(2);				// Get info
    size = GetBitsFromDest(8);				// Get size    
    switch( dat )
      {
      case HUFF_BLOCK:                          	// Run length huff code
	if( size )
	  AddToDestBuff( Best[ GetBitsFromDest(3)], size );
	else
	  ReadHeader();
	break;
      case MIXED_BLOCK: 				// Mixture of huff and regular
	if( !size )	
	  finished = 1;
	else
	  while( size-- )
	    {
	    if( !GetBitsFromDest(1) )
	      AddToDestBuff( GetBitsFromDest(8), 1 );
	    else
	      AddToDestBuff( Best[GetBitsFromDest(3)], 1 );
	    }
	break;
      case MIXED_NORMAL_BLOCK:				// Just bytes stored
	while (size--)
	  AddToDestBuff( GetBitsFromDest(8), 1 );
	break;
      case NORMAL_BLOCK:				// Run length bytes
	AddToDestBuff( GetBitsFromDest(8), size );
	break;      
      }
    }
  if( blocksize )
    fwrite( (void*)destbuff, 1, blocksize, file2 );	// Write remaining buffer
}

///////////////////////////////////////////////////////
// Routine to display help information
///////////////////////////////////////////////////////
void DisplayHelpInformation()
{
   printf("Huffman Encoding algorithm\n");
   printf("(c) 1995 Glen Cumming\n\n");   
   printf("Usage : Huffman <ZIP|UNZIP> <SOURCE> <DEST>\n");
}


///////////////////////////////////////////////////////
// Main program loop
///////////////////////////////////////////////////////
void main( int argc, char **argv )
{

  if( argc < 3 )
    {
    DisplayHelpInformation();
    return;
    }
  if( (file1 = fopen( argv[2], "rb" ) ) == NULL )
    {
      printf( "Error opening %s\n", argv[2] );
      return;
    }
  else
    {
    if( (file2 = fopen( argv[3], "wb" ) ) == NULL )
      {
	printf( "Error creating %s\n", argv[3] );
	fclose( file1 );
	return;
      }
    else
      {
      sourcebuff = malloc( BUFF_SIZE );
      sourceptr  = sourcebuff;
      destbuff   = malloc( BUFF_SIZE );
      destptr    = destbuff;  
      modulobuff = malloc( BUFF_SIZE );   
      if( !stricmp( argv[1], "ZIP" ) )
	     {
	     CompressFile();
	     printf( "File compressed...saved %d%%\n", 100-(int)(((double)newsize/(double)fsize)*100) );
	     }
      else
	     if( !stricmp( argv[1], "UNZIP" ) )
          {
	       DecompressFile();
	       printf("File decompressed...");
          }
	  else
	    DisplayHelpInformation();
      }
      free( sourcebuff );
      free( destbuff );
      free( modulobuff );
      fclose( file1 );
      fclose( file2 );
    }
}