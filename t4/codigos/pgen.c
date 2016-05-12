#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char **argv)
{
	int signed i, max_pontos;
	FILE *points = fopen( "data/input_points.dat" , "w");
	srand( (unsigned)time(NULL) );
	printf("digite quantos pontos deseja gerar: ");
	scanf("%d", &max_pontos);
	
	for(i=0; i<max_pontos; i++)
	{
	fprintf(points, "%d,%d %d,%d %d,%d %d,%d\n", (rand()%641), (rand()%481),(rand()%641), (rand()%481),(rand()%641), (rand()%481),(rand()%641), (rand()%481));
	}
	fclose(points);
	return 0;
}
