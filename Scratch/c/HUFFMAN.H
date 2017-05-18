// Huffman header file
//	G.Cumming 1995
//	Version 0.1

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>


#define NUM_SIZE	255
#define MIN_REPS	5
#define BUFF_SIZE	16*1024

typedef enum
{
  MIXED_BLOCK = 0,
  HUFF_BLOCK,
  NORMAL_BLOCK,
  MIXED_NORMAL_BLOCK	
} blocktype;

typedef enum
{
  MODULO_1 = 1,
  MODULO_2,
  MODULO_3,
  MODULO_4
} compresstype;

unsigned char GetBitsFromDest( int );
