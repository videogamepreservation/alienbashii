
// Quick proggy to set up map data

#include <stdio.h>


#define BLKS_MEM 320*4*2
char StandingStrings[16][12];
char ShootingStrings[16][12];
char AttributeStrings[8][12];
unsigned char MapBlkMem[BLKS_MEM];


void PadString( char* Str1, char *Str2 )
{
int loop;
int Pad=0;

  for( loop=0; loop< 11; loop++ )
    {
    if( Str1[loop] == '\0' || Str1[loop] == '\n' )
      Pad = 1;
    if( Pad )
      Str2[loop] = ' ';
    else
      Str2[loop] = Str1[loop];
    }
  Str2[11] = '\0';

}


void LoadInAmigaData()
{
char Filename[100];
FILE *fptr;
unsigned long int hunksize;

  printf("\nPlease Enter Filename >");
  scanf( "%s", Filename );
  fflush(stdin);
  fptr = fopen( Filename, "r" );
  if( fptr == NULL )
    printf( "Cannot open file!\n");
  else
    {
    fread( MapBlkMem, 4, 8, fptr );
    hunksize = MapBlkMem[7*4]<<24;
    hunksize += MapBlkMem[7*4+1]<<16;
    hunksize += MapBlkMem[7*4+2]<<8;
    hunksize += MapBlkMem[7*4+3];
    printf( "Hunk data size is %X (%ld blocks)\n", hunksize, hunksize*2 );
    fread( MapBlkMem, 4, hunksize, fptr );
    fclose( fptr );
    printf( "Load successful\n" );
    }

}

void LoadInMapData()
{
FILE *fptr;
char Filename[100];
int loop;

  printf( "\nEnter filename >");
  scanf( "%s", Filename );
  fflush(stdin);
  fptr = fopen( Filename, "r" );
  if( fptr == NULL )
    printf( "\nCould not open file!\n" );
  else
    {
    for( loop=0; loop< 16; loop++ )
      {
      fread( StandingStrings[loop], 11, 1, fptr );
      StandingStrings[loop][11] = '\0';
      }
    for( loop=0; loop< 16; loop++ )
      {
      fread( ShootingStrings[loop], 11, 1, fptr );
      ShootingStrings[loop][11] = '\0';
      }
    for( loop=0; loop< 8; loop++ )
      {
      fread( AttributeStrings[loop], 11, 1, fptr );
      AttributeStrings[loop][11] = '\0';
      }
    fread( MapBlkMem, BLKS_MEM, 1, fptr );
    fclose( fptr );
    }
}

void EditStrings()
{
int Choice=0, StringChoice;
int loop;
char String[100];

  while( Choice != 4 )
    {
    printf( "\n\n1. Edit Standing strings\n" );
    printf( "2. Edit Shooting strings\n" );
    printf( "3. Edit Attribute strings\n" );
    printf( "4. Exit back to main\n" );
    printf( "\nSelect >");
    scanf( "%d", &Choice );
    fflush(stdin);
    printf( "\n" );
    switch( Choice )
      {
      case 1:
	for( loop=0; loop<16; loop++ )
	  printf( "%d %s\n", loop+1,StandingStrings[loop] );
	printf( "\n\nSelect >");
	scanf( "%d", &StringChoice );
	if( StringChoice >=1 && StringChoice <= 16 )
	  {
      scanf("");
	  gets( String );
	  PadString( String,StandingStrings[StringChoice-1] );
	  }
	break;
      case 2:
	for( loop=0; loop<16; loop++ )
	  printf( "%d %s\n", loop+1,ShootingStrings[loop] );
	printf( "\n\nSelect >");
	scanf( "%d", &StringChoice );
   fflush(stdin);
	if( StringChoice >=1 && StringChoice <= 16 )
	  {
	  gets( String );
	  PadString( String,ShootingStrings[StringChoice-1] );
	  }
	break;
      case 3:
	for( loop=0; loop<8; loop++ )
	  printf( "%d %s\n", loop+1,AttributeStrings[loop] );
	printf( "\n\nSelect >");
	scanf( "%d", &StringChoice );
   fflush(stdin);
	if( StringChoice >= 1 && StringChoice <= 8 )
	  {
	  gets( String );
	  PadString( String,AttributeStrings[StringChoice-1] );
	  }
	break;
      default:
	break;
      }
    }

}

void SaveMapData(int saveflag)
{
int loop;
char Filename[100];
FILE *fptr;

  printf( "\nEnter save filename >" );
  scanf( "%s", Filename );
  fflush(stdin);
  fptr = fopen( Filename, "w" );
  if( fptr == NULL )
    printf( "Could not open dest file!\n" );
  else
    {
    if( saveflag )
      {
      for( loop=0; loop<16; loop++ )
	fwrite( StandingStrings[loop], 11, 1, fptr );
      for( loop=0; loop<16; loop++ )
	fwrite( ShootingStrings[loop], 11, 1, fptr );
      for( loop=0; loop<8; loop++ )
	fwrite( AttributeStrings[loop], 11, 1, fptr );
      }
    fwrite( MapBlkMem, BLKS_MEM, 1, fptr );
    fclose( fptr );
    }

}


void QuizMapData()
{
int Block, loop;
char Mask = 1;

  printf( "Enter blk number to display >" );
  scanf( "%d", &Block );
  fflush(stdin);
  printf( "Shoot : %s\n",ShootingStrings[(MapBlkMem[(Block<<1)+1])>>4] );
  printf( "Stand : %s\n",StandingStrings[(MapBlkMem[(Block<<1)+1]) & 0xf] );
  for( loop=0; loop<8; loop++)
    {
    printf( "%s : %s\n",AttributeStrings[loop], (MapBlkMem[Block<<1] & Mask)?"On":"Off" );
    Mask <<=1;
    }
}



void main()
{
int Choice=0;

  while( Choice != 7 )
    {
    printf( "\n\n1. Load Amiga Executable Data\n" );
    printf( "2. Load Regular Map Data\n" );
    printf( "3. Edit Strings\n" );
    printf( "4. Save Map Data with strings\n" );
    printf( "5. Save Map Data without strings\n" );
    printf( "6. Quiz Map Data\n" );
    printf( "7. Quit\n");
    printf( "\nSelect >");
    scanf( "%d", &Choice );
    fflush(stdin);
    switch (Choice)
      {
      case 1:
	LoadInAmigaData();
	break;
      case 2:
	LoadInMapData();
	break;
      case 3:
	EditStrings();
	break;
      case 4:
	SaveMapData(1);
	break;
      case 5:
	SaveMapData(0);
	break;
      case 6:
	QuizMapData();
	break;
      default:
	break;
      }
    }
}

