#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#define FALSE 0
#define TRUE 1


typedef struct 
{
  long int  header_size;
  short int width;
  short int height;
  short int xpos;
  short int ypos;
  char	num_planes;
  char  pmask;
  char  typecom;
  char  pad;
} bmhd_header;

typedef struct
{
  long int filesize;
  short int width;
  short int height;
  char  num_planes;
  char  comp_type;
  short int  num_cols;
  long int pic_size;
} glen_header;  

bmhd_header header;
glen_header new_header;
int number_of_colours;
short int colour_table[32];



char source_file[100];
char dest_file[100];
long int data_size,pic_data_size;
char *data = NULL;
char *pic_data;

char *FindData( string, mem)
char *string;
char *mem;
{
int loop=0;
char *pos = mem;

  while ( mem < pos+2000)
  {
    if ( *(mem++) == string[loop++] )
    {
      if ( loop == 4 )
        return mem;
    }
    else
       loop = 0;
  }   
  return NULL;
}
        


int LoadIffFile()
{
FILE *ptr;
char buff[4];
long int data_size;
char *head_pos;
long int *num_cols;    
short int *cols = colour_table;
    
   if ( ( ptr = fopen( source_file, "r" ) ) == NULL )
   {
     printf("Failed to open file %s\n",source_file );
     return 0;
   }
   
/* FILE OPEN OK */

  fread( buff, 4,1,ptr);
  if ( strcmp(buff,"FORM") )
  {
    printf("Not an iff file\n");
    return 0;
  }
 
  fread( (char*)&data_size, 4, 1, ptr);
  printf("Data size %ld\n",data_size);
  data = malloc( data_size );
  if ( data == NULL )
  {
    fclose( ptr );
    printf("Cannot malloc\n");
    return (0);
  }
  
  
  fread( data, data_size, 1, ptr );     
  fclose( ptr );

  head_pos = FindData( "BMHD",data+4 );
  if ( head_pos == NULL )
    return 0;
  
    
  memcpy( (char*)&header, head_pos, sizeof( bmhd_header ) ); 
  
  printf("Pic details : \n\n");
  printf("Width %d\n",(int)header.width);
  printf("Height %d\n",(int)header.height);
  printf("No. of planes %d\n",(int)header.num_planes);
  if ( header.typecom == 0 )
    printf("Pic is not compressed\n");
  else
    printf("Pic is compressed\n");

  head_pos = FindData( "CMAP", data );
  num_cols = (long int*)head_pos;
  *num_cols /=3;
  new_header.num_cols = *num_cols;
  head_pos +=4;
  while ( (*num_cols)-- )
  {
      *(cols++) = (short int)( ( *head_pos) & 0xf0 ) <<4  |
                (short int)( *( head_pos+1 ) & 0xf0) |
                (short int)( *( head_pos+2 ) & 0xf0)>>4;
                          
    head_pos +=3;                                 
  }

  
  head_pos = FindData( "BODY", data );
  if ( head_pos == NULL )
    return 0;
  num_cols = ( long int*)head_pos;
  new_header.pic_size = *num_cols; 
  printf("pic size %ld\n",new_header.pic_size);
  pic_data = head_pos+4;
  return 1;    
}

   
int SaveNewFile( void )
{
FILE *ptr;

  if ( ( ptr = fopen( dest_file,"w" ) ) == NULL )
    return 0;

  new_header.filesize = (sizeof( glen_header )-4) + (new_header.num_cols*2) + new_header.pic_size;  
  printf("Number of cols %d\n",new_header.num_cols);
  new_header.width = header.width;
  new_header.height = header.height;
  new_header.num_planes = header.num_planes;
  new_header.comp_type = header.typecom;
    
  fwrite( (char*)&new_header, sizeof( glen_header ), 1, ptr );
  fwrite( (char*)colour_table, new_header.num_cols*2, 1, ptr);
  fwrite( pic_data, new_header.pic_size, 1, ptr);
  
  fclose( ptr );
  
  return 1;
  
}
   
void main( argc, argv)
int argc;
char *argv[];
{

   printf("ABII IFF STRIP UTILITY\n");
   printf("(C) GLEN CUMMING 1994\n");  
    
   if ( argc < 2  )
   {
     printf("\nFormat - iffstrip <file> <stripped file>\n " );
     return;
   }
   
   strcpy( source_file, argv[1] );
   if ( argc == 2 )
     sprintf( dest_file, "%s.pic",source_file);
   else
     strcpy( dest_file, argv[2] );
     
   if ( !LoadIffFile() )
     return;
     
   SaveNewFile();  
 
   if ( data != NULL )
     free( data );
 }
         
      
        
  
