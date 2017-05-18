/* routine to join to files properly */

#include <stdio.h>
#include <fcntl.h>

void main( argc, argv )
int argc;
char *argv[];
{
char *dat1,*dat2;
FILE *ptr1,*ptr2;
long size;

  if( *(&argv[0]) == "?" || argc !=4 )
  {
  printf("Usage append <file1> <file2> <new file>\n");
  printf("The new file will be file 1 with file 2 added to the end!\n");
  return;
  }
  
  ptr1 = fopen( argv[0], "r" );
  if( ptr1 == NULL )
  {
    printf("Could not find file : %s",argv[0] );
    return;
  }
  else
  {
    size = fsize( argv[0] );
    printf("Size of file %ld",size);
  }
  fclose( argv[0] );

}
