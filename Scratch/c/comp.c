#include <stdio.h>
#include <string.h>

/************************************************
 ***            FIND REPEAT                   ***
 ************************************************/
int FindRepeat( char *string, int scanlength )
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
 ****         FIND REPEAT LENGTH             ****
 ************************************************/
int FindRepeatLength( char *string, int max )
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
void Compress( char *string, int size_of_dat )
{
int current_pos = 0;
int rep_pos;
int rep_length;
int scan_length;
int straight_written, rep_written;
int loop, new_size=0;
char ch;


   while( current_pos != size_of_dat && new_size < size_of_dat  )
     {
     straight_written = 0;
     rep_written = 0;

     scan_length = 127;
     if( (current_pos+scan_length) > size_of_dat )
       scan_length = size_of_dat - current_pos;

     rep_pos = FindRepeat( &string[current_pos], scan_length );

     if( rep_pos+current_pos != current_pos )
       {
       if ( rep_pos == -1 )
	 straight_written = scan_length;
       else
         straight_written = rep_pos-1;
       /*for (loop = 0; loop < straight_written; loop++)
	 printf("%c", string[current_pos+loop] );*/
       /*Command data = 128+size */
       new_size += straight_written+1;
       }
     if( rep_pos != -1 )
       {
       if ( (current_pos+rep_pos+127) > size_of_dat  )
	 rep_length = size_of_dat - current_pos+rep_pos;
       else
	 rep_length = 127;
       if ( rep_pos )
         rep_pos--; 
       rep_written = FindRepeatLength( &string[current_pos+rep_pos], rep_length);
       /*Write out repeat command, followed by value*/
       /*Command data = 0 + size */
       new_size += 1;
       }
     current_pos += straight_written+rep_written;
     printf("Crunched %d\r",(int) ( ( (double)current_pos/size_of_dat )*100.0 ) );
     }
   if( new_size >= size_of_dat )
     printf("Crunch aborted - could not make any gain\n");
   else
   { 
     printf("Original Size %d\n",size_of_dat);
     printf("New size %d\n",new_size);
     printf("Saving of %%%d",100-(int) ( ( (double)new_size/size_of_dat )*100.0 ) );
   }
}   
        

/*So remember - bit 8 - control bit, 0 - repeat, 1 = straight*/

void main( void )
{
char *string = "dasdkkkasdjdjjdjdnnndndnooqiwoqnbxzbxcbn";
   Compress(string, strlen( string ) );

}