#include <stdio.h>
#include <math.h>

typedef struct ponto {
	int x, y;
}ponto;

int det (ponto A, ponto B, ponto C);
int pitf (ponto A,ponto B,ponto C,ponto P);
void print_triangle(ponto A, ponto B, ponto C, ponto P);



int main()
{
	ponto A, B, C, P;

	puts("pontos do triangulo: 'x,y'");
	scanf("%d,%d", &A.x, &A.y);
	scanf("%d,%d", &B.x, &B.y);
	scanf("%d,%d", &C.x, &C.y);
	print_triangle(A,B,C,P);
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
	if(det<0)
		return -1*(det);
	else 
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

//função que desenha o triangulo - print Triangle
void print_triangle(ponto A, ponto B, ponto C, ponto P)
{
	int x=0, y=0;
	
	for (y=25;y>(-25);y--)
	{
		P.y=y;
		for (x=(-40);x<40; x++)
		{
			P.x=x;
			if (pitf(A,B,C,P)==1)
				printf("*");
			else if (x==0)
				printf("|");
			else if (y==0)
				printf("-");
			else if (y==0 && x==0)
				printf("+");
			else printf(" ");			
		}
		printf("\n");
	}
}
