module det(input clk, input enable, input [9:0] Ix, input [8:0] Iy, output [11:0] Op,output [11:0] Os, output [11:0]Det);
	reg [9:0] Ax, Bx, Cx; //registrador dos pontos X (resolução = 640x480, por isso 10bits pra inX)
	reg [8:0] Ay, By, Cy;
	reg [10:0] RDpri1, RDpri2, RDsec1, RDsec2; //resultado da mult. da diag principal/secundária (reg 1,2)
	reg [11:0] RMDp, RMDs; //resultado da soma multiplicação da diag. pri/sec
	reg [2:0] count; initial count <= 3'b000;
	reg [11:0] reg_det, reg_Op, reg_Os;
		always @(posedge clk)
		begin 
		
			case (count)
				3'b000:	begin Ax <= Ix; Ay <= Iy; end
				3'b001: begin Bx <= Ix; By <= Iy;end
				3'b010: begin Cx <= Ix; Cy <= Iy; RDpri1 <= (Ax*By); RDsec1 <= (Cx*Ay); end
				3'b011: begin RDpri2 <= (Cx*Ay); RDsec2 <= (Ax*Cy);end
				3'b100: begin RMDp <= (RDpri1+RDpri2); RMDs <=  (RDsec1+RDsec2);end
				3'b101: begin RDpri1 <= RMDp; RDpri2 <= (Bx*Cy); RDsec1 <= RMDs; RDsec2 <= (Cx*By);end
				3'b110: begin RMDp <= (RDpri1+RDpri2); RMDs <=  (RDsec1+RDsec2);end
				3'b111: begin reg_det <= (RMDp - RMDs); reg_Op <= RMDp; reg_Os <= RMDs; end
				// caso a determinante RMDs dê um valor maior que o RMDp, como retornar um valor abs? 
			endcase
			count <= count+1;
		end

endmodule
