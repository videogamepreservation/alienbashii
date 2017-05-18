#include <stdio.h>
#include <devices/trackdisk.h>
#include <exec/memory.h>

struct Port *diskport;
struct IOStdReq *diskreq;
char *buffer;

main(argc,argv)
int argc;
char *argv[];
{
	FILE *in;
	int unit,i,c;
	printf("\x9b;33mBBInstall \x9b;0m© Copyright 1989 by Jonathan Potter\n\n");
	if (argc<3) {
		printf("Usage : %s in-file out-unit\n\n",argv[0]);
		exit(0);
	}
	if ((in=fopen(argv[1],"r"))==NULL) {
		printf("Error! Can't open file %s\n",argv[1]);
		exit(0);
	}
	diskport=CreatePort(0,0);
	diskreq=CreateStdIO(diskport);
	unit=atoi(argv[2]);
	if ((OpenDevice("trackdisk.device",unit,diskreq,0))!=NULL) {
		printf("Error! Can't open unit %s\n",argv[2]);
		fclose(in);
		DeleteStdIO(diskreq);
		DeletePort(diskport);
		exit(0);
	}
	if ((buffer=AllocMem(1024,MEMF_CHIP))==NULL) {
		printf("Error! Can't allocate memory!\n");
		fclose(in);
		CloseDevice(diskreq);
		DeleteStdIO(diskreq);
		DeletePort(diskport);
		exit(0);
	}
	for (i=0;i<40;i++) getc(in);
	for (i=0;i<1024;i++) buffer[i]=0;
	for (i=0;(i<1024 && (c=getc(in))!=EOF);i++) buffer[i]=c;
	printf("Checksum = $%x\n",dofixsum());
	diskreq->io_Length=1024;
	diskreq->io_Data=buffer;
	diskreq->io_Command=CMD_WRITE;
	diskreq->io_Offset=0;
	DoIO(diskreq);
	diskreq->io_Command=CMD_UPDATE;
	DoIO(diskreq);
	diskreq->io_Command=TD_MOTOR;
	diskreq->io_Length=0;
	DoIO(diskreq);
	fclose(in);
	CloseDevice(diskreq);
	DeleteStdIO(diskreq);
	DeletePort(diskport);
	FreeMem(buffer,1024);
	exit(0);
}

dofixsum()
{
	register int sum;
	if (calcsum(0)==0) return(0);
	sum=calcsum(1);
	sum=-sum;
	buffer[4]=getbits(sum,31,8);
	buffer[5]=getbits(sum,23,8);
	buffer[6]=getbits(sum,15,8);
	buffer[7]=0;
	while (calcsum(0)!=0 && buffer[7]<256)
		++buffer[7];
	return ((buffer[4]<<24)+(buffer[5]<<16)+(buffer[6]<<8)+buffer[7]);
}

calcsum(state)
register int state;
{
	register int *point2,sum,lastsum,a;
	point2=buffer;
	if (state) {
		sum=point2[0]; lastsum=0; if (sum<0) sum++;
		for (a=2;a<256;a++) {
			lastsum=sum;
			sum=sum+point2[a];
			if (lastsum>sum) sum++;
		}
	}
	else {
		sum=0;
		for (a=0;a<256;a++) {
			lastsum=sum;
			sum=sum+point2[a];
			if (lastsum>sum) sum++;
		}
	}
	return(sum);
}

getbits(x,p,n)
register x,p,n;
{
	return (x>>(p+1-n))&~(~0<<n);
}
