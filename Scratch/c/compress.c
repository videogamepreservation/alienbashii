#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#define FALSE 0
#define TRUE 1


typedef struct 
{
   char  header[4];
   short int map_blk_size;
   short int map_x_size;
   short int map_y_size;
   short int map_planes;
   short int map_data_size;
} map_header;

map_header current_map_header;

char source_file[100];
char dest_file[100];
char *map_file = NULL;
short int *compressed_mapdata = NULL;
char  *compressed_alienmapdata = NULL;
long int compressed_mapdata_size;
long int compressed_alienmapdata_size;


int LoadMapFile()
{
FILE *ptr;
int map_data_size;
    
    
   if ( ( ptr = fopen( source_file, "r" ) ) == NULL )
   {
     printf("Failed to open file %s\n",source_file );
     return 0;
   }
   
/* FILE OPEN OK */

  fread( (char*)&current_map_header, sizeof( map_header ), 1, ptr );     
  
  printf("Map details : \n\n");
  printf("%4s\n",current_map_header.header );
  printf("Map Size X : %d\n", current_map_header.map_x_size);
  printf("Map Size Y : %d\n", current_map_header.map_y_size);
  printf("Map planes : %d\n", current_map_header.map_planes);
  printf("Map data size : %d\n",current_map_header.map_data_size);

  map_data_size = current_map_header.map_x_size*
                  current_map_header.map_y_size*3;
                 
  map_file = malloc( map_data_size );                 
  if ( map_file == NULL )
  {
    printf("Error Allocating data\n");
    return 0;
  }
  else
    fread( map_file, map_data_size, 1, ptr );                   
  fclose( ptr );
  return 1;    
}

/************************************************
 ***            FIND REPEAT                   ***
 ************************************************/
int FindRepeat( string, scanlength )
char *string;
int scanlength;
{
char ch;
int pos = -1;
int rep = 0;
int count = 0;

  ch = *string;
  while( count != scanlength )
    {
    if( *string == ch && ( count == 0 || count > 4 ) )
      {
      if ( pos == -1 )
        pos = count;  
      rep++;
      if( rep > 4 )
	     return pos;
      }
    else
      {
      rep = 0;
      pos = -1;
      }
    ch = *(string++);
    count++;
    }

  return -1;
}

/************************************************
 ***   FIND REPEAT LENGTH                   *****
 ************************************************/
int FindRepeatLength( string, max )
char *string;
int max;
{
char ch;
int size=0;

  ch = *string;

  while( size != max )
    {
    if( *(string++) == ch )
	   size++;
    else
	  return size;
    }
  return max;
}

/**************************************************
 ****              COMPRESS                     ***
 **************************************************/
char *Compress( string, size_of_dat, new_size )
char *string;
long int size_of_dat;
long int *new_size;
{
long int current_pos = 0;
int rep_pos;
int rep_length;
int scan_length;
int straight_written, rep_written;
char *new_data = NULL;
int crunched;
int new_pos = 0;
int loop;

   
   new_data = malloc( size_of_dat );

   *new_size = 0;
   while( current_pos < size_of_dat && *new_size < size_of_dat  )
     {
     straight_written = 0;
     rep_written = 0;

     scan_length = 127;
     if( (current_pos+scan_length) > size_of_dat )
       scan_length = (int) (size_of_dat - current_pos);

     rep_pos = FindRepeat( &string[current_pos], scan_length );

     if( rep_pos+current_pos != current_pos )
       {
       if ( rep_pos == -1 )
	      straight_written = scan_length;
       else
         straight_written = rep_pos-1;
       new_data[new_pos++] = 128+straight_written;
       for (loop=0; loop< straight_written; loop++)
         new_data[new_pos++] = string[current_pos+loop];
         
       *new_size += straight_written+1;
       }
       
     if( rep_pos != -1 )
       {
       if ( rep_pos )
         rep_pos--;
       if ( (current_pos+rep_pos+127) > size_of_dat  )
	      rep_length = size_of_dat - (current_pos+rep_pos);
       else
	      rep_length = 127;
        
       rep_written = FindRepeatLength( &string[current_pos+rep_pos], rep_length);
       new_data[new_pos++] = rep_written;
       new_data[new_pos++] = string[current_pos+rep_pos];
       *new_size += 2;
       }
     current_pos += straight_written+rep_written;
     crunched = (int) ( ( (double)current_pos / (double)size_of_dat)*100.0);
     printf("Crunching alien map data : %d\r",crunched );
     }
   printf("\n");
   if( *new_size >= size_of_dat )
   { 
     *new_size = 0;
     return NULL;
   } 
    
   return new_data;
}   
        
/************************************************
 ***            FIND WORD REPEAT              ***
 ************************************************/
int FindWordRepeat( string, scanlength )
short int *string;
int scanlength;
{
short int ch;
int pos = -1;
int rep = 0;
int count = 0;

  ch = *string;
  while( count != scanlength )
    {
    if( *string == ch && ( count == 0 || count > 4 ) )
      {
      if ( pos == -1 )
        pos = count;  
      rep++;
      if( rep > 4 )
	     return pos;
      }
    else
      {
      rep = 0;
      pos = -1;
      }
    ch = *(string++);
    count++;
    }

  return -1;
}

/************************************************
 ***   FIND WORD REPEAT LENGTH              *****
 ************************************************/
int FindWordRepeatLength( string, max )
short int *string;
int max;
{
short int ch;
int size=0;

  ch = *string;

  while( size != max )
    {
    if( *(string++) == ch )
	   size++;
    else
	  return size;
    }
  return max;
}

/**************************************************
 ****              WORD COMPRESS                ***
 **************************************************/
short int *WordCompress( string, size_of_dat, new_size )
short int *string;
long int size_of_dat;
long int *new_size;
{
long int current_pos = 0;
int rep_pos;
int rep_length;
int scan_length;
int straight_written, rep_written;
short int *new_data = NULL;
int crunched;
int loop;
int new_pos=0;

   new_data = (short int*)malloc( size_of_dat*2 );
   *new_size = 0;
   while( current_pos < size_of_dat && *new_size < size_of_dat  )
     {
     straight_written = 0;
     rep_written = 0;

     scan_length = 16384;
     if( (current_pos+scan_length) > size_of_dat )
       scan_length = size_of_dat - current_pos;

     rep_pos = FindWordRepeat( &string[current_pos], scan_length );

     if( rep_pos+current_pos != current_pos )
       {
       if ( rep_pos == -1 )
	      straight_written = scan_length;
       else
         straight_written = rep_pos-1;
       
       new_data[new_pos++] = 32768+straight_written;
       for (loop=0; loop < straight_written; loop++)
         new_data[new_pos++] = string[current_pos+loop];  
         
       *new_size += straight_written+1;
       }
     if( rep_pos != -1 )
       {
       if ( rep_pos )
         rep_pos--;
       if ( (current_pos+rep_pos+16384) > size_of_dat  )
	      rep_length = size_of_dat - (current_pos+rep_pos);
       else
	      rep_length = 16384;
       rep_written = FindWordRepeatLength( &string[current_pos+rep_pos], rep_length);
       new_data[new_pos++] = rep_written;
       new_data[new_pos++] = string[current_pos+rep_pos];
       *new_size += 2;
       }
     current_pos += straight_written+rep_written;
     crunched = (int) ( ( (double)current_pos / (double)size_of_dat)*100.0);
     printf("Cruching map data : %d\r",crunched );
     
     }
   printf("\n");
   if( *new_size >= size_of_dat )
   {
     *new_size = 0;
     return NULL;
   }
      
   return new_data;
}   
        
        
        

/*So remember - bit 8 - control bit, 0 - repeat, 1 = straight*/
   
int CompressFile()
{
long int size;
long int new_size;
        
  compressed_mapdata = WordCompress( (short int*)map_file, 
                                 (int)(current_map_header.map_x_size*
                                 current_map_header.map_y_size),
                                 &compressed_mapdata_size );
  
  if ( compressed_mapdata == 0 )
  {
    printf("No Gain\n");
    return 0;
  }                                    

  compressed_alienmapdata = Compress( map_file +
                                     current_map_header.map_x_size*
                                     current_map_header.map_y_size*2,
                                     (int)current_map_header.map_x_size*
                                     current_map_header.map_y_size,
                                     &compressed_alienmapdata_size);    
   if ( compressed_alienmapdata == 0 )
   {
     printf("No Gain\n");
     return 0;
   }
 
   size = (int)current_map_header.map_x_size*current_map_header.map_y_size*3;
   printf("Original size %d\n",size);
   new_size = (compressed_mapdata_size*2)+compressed_alienmapdata_size;
   printf("New size %d\n",new_size);
   printf("Saving of %%%d\n",100-(int) ( ( (double)new_size/size )*100.0 ) );
}   
   
int SaveNewFile( void )
{
FILE *ptr;
long int filesize;

  if ( ( ptr = fopen( dest_file,"w" ) ) == NULL )
    return 0;
    
  sprintf(current_map_header.header,"COMP");
    
  fwrite((char*)&current_map_header, 10, 1, ptr );
  
  filesize = (compressed_mapdata_size*2+compressed_alienmapdata_size)+8;
  fwrite((char*)&filesize, sizeof( long int ), 1, ptr );
  
/*write map data + size*/  
  filesize =(compressed_mapdata_size*2);
  fwrite( (char*)&filesize, sizeof( long int ), 1, ptr);
  fwrite((char*)compressed_mapdata, compressed_mapdata_size*2, 1, ptr);

/*write alien map data + size*/  
  filesize = compressed_alienmapdata_size;
  fwrite( (char*)&filesize, sizeof( long int ), 1, ptr);
  fwrite((char*)compressed_alienmapdata, compressed_alienmapdata_size, 1, ptr); 
  
  fclose( ptr );
  
  return 1;
  
}
   
void main( argc, argv)
int argc;
char *argv[];
{

   printf("ABII MAP COMPRESSION UTILITY\n");
   printf("(C) GLEN CUMMING 1994\n");  
    
   if ( argc < 2  )
   {
     printf("\nFormat - mapcompress <file> <compessed file>\n " );
     return;
   }
   
   strcpy( source_file, argv[1] );
   if ( argc == 2 )
     sprintf( dest_file, "%s.cmp",source_file);
   else
     strcpy( dest_file, argv[2] );
     
   if ( !LoadMapFile() )
     return;
     
   if ( CompressFile() )
     SaveNewFile();  
     
   if ( compressed_mapdata != NULL )
     free( compressed_mapdata );
   if ( compressed_alienmapdata != NULL )
      free( compressed_alienmapdata );
  
}
         
      
        
  
