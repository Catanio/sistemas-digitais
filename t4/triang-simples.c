#include <stdio.h>

typedef struct ponto {
	int x, y;
}ponto;

//função que calcula o valor absoluto de uma determinante de ordem 3
int det (ponto A, ponto B, ponto C)
{
	int diag_principal, diagonal_secundaria, determinante;
	diagonal_principal=((A.x*B.y)+(A.y*C.x)+(B.x*C.y));
	diag_secundaria=((C.x*B.y)+(C.y*A.x)+(B.x*A.y));
	determinante=diagonal_principal-diag_secundaria;
	//condicional para retornar o valor absoluto da determinante
	if(det<0)
		return -1*(det);
	else 
		return det;
}


int main()
{
	ponto A, B, C, P;
	int ABC, ABP, ACP, BCP;
	
	printf("pontos do triangulo: 'x,y'\n");
	scanf("%d,%d", &A.x, &A.y);
	scanf("%d,%d", &B.x, &B.y);
	scanf("%d,%d", &C.x, &C.y);
	
	printf("ponto\n");
	scanf("%d,%d", &P.x, &P.y);
	ABC=det(A, B, C);
	ABP=det(A, B, P);
	ACP=det(A, C, P);
	BCP=det(B, C, P);
	
	//verifica se a soma das áreas dos triangulos formados por uma permutação de ABC(P) é a mesma do triangulo ABC
	(ABC)==(ABP+ACP+BCP)?printf("ponto está dentro do triangulo!\n"):
	printf("ponto não está no triangulo!\n");
	
	return 0;
}
