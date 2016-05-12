/*
 * O programa PITc.c (point inside a triangle em C)
 *Primeiro, criou-se uma estrutura chamada PONTO que contém dois inteiros, X e Y.
 *o programa é composto por duas funções. a primeira função, chamada de DET, recebe os pontos de um triangulo ABC calcula qual o valor absoluto
 *da determinante de uma matriz deste triangulo, a segunda função, chamada de PITF (Point Inside Triangle Function) recebe quatro
 *pontos (ABCP) e verifica se as determinantes dos triangulos ABC são iguais a soma das determinantes ABP, ACP e BCP, retornando um
 *valor verdadeiro
 *Dentro da main:
 *Abre o arquivo input_points.dat e entra num laço onde o ele armazena os pontos ABCP em suas respectivas variáveis, e retornando um
 *valor booleano para o arquivo "output_points_c.dat" até o final do arquivo "input points".
*/
#include <stdio.h>
#include <math.h>

typedef struct ponto {
	int x, y;
}ponto;

int det (ponto A, ponto B, ponto C);
int pitf (ponto A,ponto B,ponto C,ponto P);

int main()
{
	ponto A, B, C, P;
	FILE *output_c = fopen("data/output_points_c.dat", "w");
	FILE *points = fopen("data/input_points.dat", "r");
	
	do 
	{
	fscanf(points,"%d,%d %d,%d %d,%d %d,%d\n", &A.x, &A.y, &B.x, &B.y, &C.x, &C.y, &P.x, &P.y);
	fprintf(output_c, "%d\n", pitf(A,B,C,P));
	}while (!feof(points));
	
	fclose(output_c);
	fclose(points);
	return 0;
}

//calcula o valor da determinante de um ponto
int det (ponto A, ponto B, ponto C)
{
	int diag_pri, diag_sec, det;
	diag_pri=((A.x*B.y)+(A.y*C.x)+(B.x*C.y));
	diag_sec=((C.x*B.y)+(C.y*A.x)+(B.x*A.y));
	det=diag_pri-diag_sec;
	
	//retorna o valor absoluto da determinante
	if(det<0) return -1*(det);
	
	return det;
	
}

//função que verifica se o ponto P está dentro do triangulo ABC - point inside triangle function
int pitf (ponto A,ponto B,ponto C,ponto P)
{
	int ABC, ABP, ACP, BCP;
	ABC=det(A, B, C);
	ABP=det(A, B, P);
	ACP=det(A, C, P);
	BCP=det(B, C, P);
	//retorna verdadeiro ou falso
	if ((ABC)==(ABP+ACP+BCP))
		return 1;
	else 
		return 0;
}
