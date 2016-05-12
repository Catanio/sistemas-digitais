#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv)
{
	int C, V, linha=1, *erro=NULL, count=0, i;
	FILE *output_c = fopen("data/output_points_c.dat", "r");
	FILE *output_v = fopen("data/output_points_v.dat", "r");
	FILE *anal = fopen("data/analise.dat", "w");
	
	do {
	fscanf(output_c, "%d\n", &C);
	fscanf(output_v, "%d\n", &V);
	if (C!=V) {
		erro=(int*)realloc(erro, ++count*sizeof(int));
		erro[count-1]=linha;
	}
	linha++;
	} while ((!feof(output_c)) && (!feof(output_v)));
	fprintf(anal, "analisadas %d linhas\n", linha-1);
	
	if (count>0){
		fprintf(anal, "%d erro(s)\n", count);
		
		for (i=0;i<count; i++)
			fprintf(anal, "linha %d\n", erro[i]);
		fprintf(anal, "os arquivos contém diferenças");
	}
	else fprintf(anal, "os arquivos são identicos.\n");
	
	free(erro);
	fclose(anal);
	fclose(output_c);
	fclose(output_v);

	return 0;
}
