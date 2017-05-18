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
char *map_file = NULL;


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
 
#define GOLD_POT 198
#define SILVER_POT 218
#define WALL_SILVER 83
#define WALL_GOLD1 300
#define WALL_GOLD2 301
#define WALL_DOUBLE_SILVER 177



#define Pig_Alien_Object	14

#define Coin				30
#define Chest				31
#define Chest4				32
#define Chest3				33
#define Chest2				34
#define Chest1				35
#define Chest0				36
#define Silver_Coin			37
#define Silver_Chest			38
#define SChest4				39
#define SChest3				40
#define SChest2				41
#define SChest1				42
#define SChest0				43


#define Pig_Generator			55
#define Pig_Generator2			56
#define Pig_Generator3			57
#define Pig_Generator4			58
#define Pig_Generator5			59

#define GoldMoney1			69
#define SilverMoney1			70
#define GoldMoney2			71
#define SilverMoney2			72

#define Pig_Guard			74
#define Pig_No_Shoot			78
#define Speed_Pig			80

void DisplayCashInfo()
{
unsigned short *blk_data;
unsigned char *alien_data;
unsigned int loop,blk_cash=0, alien_cash=0;
unsigned long int size;

  blk_data = (unsigned short*)map_file;
  alien_data = (unsigned char*)map_file+current_map_header.map_x_size*current_map_header.map_y_size*2;  

  size = current_map_header.map_x_size*current_map_header.map_y_size;
  for(loop=0; loop< size; loop++)
  {
    switch( *(blk_data++) )
    {
      case WALL_GOLD1:
      case WALL_GOLD2:
      case GOLD_POT:
        blk_cash+=50;
        break;
      case WALL_SILVER:
      case SILVER_POT:
        blk_cash+=30;
        break; 
      case WALL_DOUBLE_SILVER:
        blk_cash+=60;
        break;
    }
  }
  printf("\nCash from blocks %d\n", blk_cash );
 
  for(loop=0; loop< size; loop++ )
  {
     switch( *(alien_data++) )
     {
       case Speed_Pig:
       case Pig_No_Shoot:
       case Pig_Guard:
       case Pig_Alien_Object:
         alien_cash += 10;
         break;   
       case Coin:
         alien_cash +=50;
         break;
       case Silver_Coin:
         alien_cash += 20;
         break;
       case Chest:
         alien_cash += 50*5;
         break;
       case Silver_Chest:
         alien_cash += 20*5;
         break;
       case Pig_Generator:
         alien_cash += 10*5;
         break;
       case Pig_Generator2:
         alien_cash += 10*4;
         break;
       case Pig_Generator3:
         alien_cash += 10*3;
         break;
       case Pig_Generator4:
         alien_cash += 10*2;
         break;
       case Pig_Generator5:
         alien_cash += 10;
         break;   
       case GoldMoney1:
         alien_cash += 10;
         break;
       case SilverMoney1:
         alien_cash +=5;
         break;
       case GoldMoney2:
         alien_cash += 20;
         break;
       case SilverMoney2:
         alien_cash += 10;
         break;
      }
   }
   printf("Cash from aliens %d\n\n", alien_cash );
   printf("Total cash possible %d\n", alien_cash+blk_cash );
}
        
   
void main( argc, argv)
int argc;
char *argv[];
{

   printf("ABII MAP CASH UTILITY\n");  
    
   if ( argc < 1  )
   {
     printf("\nFormat - mapcompress <file> \n " );
     return;
   }
   
   strcpy( source_file, argv[1] );
     
   if ( !LoadMapFile() )
     return;
     
   DisplayCashInfo(); 
   if( map_file != NULL )
     free (map_file);    
}
         
      
        
  
