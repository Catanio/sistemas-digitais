module det(input clk, input [10:0] Ix, input [9:0] Iy, output [22:0]Det, input [3:0] state, output write);
	reg signed[10:0] Ax, Bx, Cx; //registrador dos pontos X (resolução = 640x480, por isso 11bits pra inX)
	reg signed[9:0] Ay, By, Cy;
	reg signed[21:0] RDpri1, RDpri2, RDsec1, RDsec2; //resultado da mult. da diag principal/secundária (reg 1,2)
	reg signed[22:0] RMDp, RMDs; //resultado da soma multiplicação da diag. pri/sec
	reg signed[22:0] reg_det = 13'bz;
	assign Det = reg_det;
	reg write;
	always @(clk)
	begin 
		case (state)
			4'd1: begin Ax <= Ix; Ay <= Iy; write <= 0; end
			4'd2: begin Bx <= Ix; By <= Iy; end
			4'd3: begin Cx <= Ix; Cy <= Iy; RDpri1 <= (Ax*By); RDsec1 <= (Bx*Ay); end
			4'd4: begin RDpri2 <= (Cx*Ay); RDsec2 <= (Ax*Cy);end
			4'd5: begin RMDp <= (RDpri1+RDpri2); RMDs <=  (RDsec1+RDsec2);end
			4'd6: begin RDpri1 <= RMDp; RDpri2 <= (Bx*Cy); RDsec1 <= RMDs; RDsec2 <= (Cx*By);end
			4'd7: begin RMDp <= (RDpri1+RDpri2); RMDs <=  (RDsec1+RDsec2);end
			4'd8: 
				begin 
					if (RMDp-RMDs<0)//retorna o valor absoluto da determinante
						reg_det <= (-1)*(RMDp - RMDs);
					else
						reg_det <= (RMDp- RMDs);
					write <= 1'b1;
				end
		endcase
	end
endmodule

module MUX_6x2 (A1,A2,B1,B2,C1,C2, sel, O1, O2);
	input [10:0] A1, B1, C1;
	input [9:0] A2, B2, C2;
	input [3:0] sel;
	output [10:0] O1;
	output [9:0] O2;
	reg [10:0] O1;
	reg [9:0] O2; // por que é necessário a criaçao de um registrador?

	always @(A1 or A2 or B1 or B2 or C1 or C2 or sel)
	begin
		case (sel)
			4'd1: begin O1 <= A1; O2 <= A2; end
			4'd2: begin O1 <= B1; O2 <= B2; end
			4'd3: begin O1 <= C1; O2 <= C2; end
			default: begin O1 = 11'bz; O2 = 10'bz; end
		endcase 
	end

endmodule

module cmp (clk, Ax, Ay, Bx, By, Cx, Cy, Px, Py, return);

	input [10:0] Ax, Bx, Cx, Px;
	input [9:0] Ay, By, Cy, Py;
	input clk;
	output return;
	
	wire clk_, write;
	reg [3:0] count =4'd0; wire [3:0] state;
	assign state = count;
	wire [10:0] Ax, Bx, Cx, Px, ABCx, ABPx, ACPx, BCPx;
	wire [9:0] Ay, By, Cy, Py, ABCy, ABPy, ACPy, BCPy;
	wire [22:0] ABC_, ABP_, ACP_, BCP_;
	reg [22:0] ABC, sumABCP;
	
	reg return;
	
	
	always @(posedge clk)
	if (count!=11)
		count <= count+1;
	else count <=0;
	
	MUX_6x2 MUX_ABC (Ax, Ay, Bx, By, Cx, Cy, state, ABCx, ABCy);
	MUX_6x2 MUX_ABP (Ax, Ay, Bx, By, Px, Py, state, ABPx, ABPy);
	MUX_6x2 MUX_ACP (Ax, Ay, Cx, Cy, Px, Py, state, ACPx, ACPy);
	MUX_6x2 MUX_BCP (Bx, By, Cx, Cy, Px, Py, state, BCPx, BCPy);
	
	det DET_ABC (clk, ABCx, ABCy, ABC_, state, write);
	det DET_ABP (clk, ABPx, ABPy, ABP_, state, write);
	det DET_ACP (clk, ACPx, ACPy, ACP_, state, write);
	det DET_BCP (clk, BCPx, BCPy, BCP_, state, write);
	
	always @(write == 1 or state) begin
		case (count)
			4'd2: return <=1'bz;
			4'd9: begin ABC <= ABC_; sumABCP <= (ABP_ + ACP_ ); end
			4'd10: begin sumABCP <= BCP_ + sumABCP; end
			4'd11:
			begin 
				if (ABC == sumABCP) 
					return <=1;
				else
					return <=0;
			end
			//4'd12: return <= 1'bz;
		endcase 
	end
endmodule


module teste ;
	
	reg clk = 0; always #1 clk = ~clk;
	integer i, j;
	reg [10:0]Ax, Bx, Cx, Px;
	reg [9:0]Ay, By, Cy, Py;

	cmp A (clk, Ax, Ay, Bx, By, Cx, Cy, Px, Py, return);
 

	integer in, out, valores;

	initial begin
	 //$dumpvars(0,A, return);
		in = $fopen("data/input_points.dat", "r");
		out = $fopen("data/output_points_v.dat", "w");
		#0;
		while (!$feof(in)) begin
		
			valores = $fscanf(in ,"%d,%d %d,%d %d,%d %d,%d\n", Ax, Ay, Bx, By, Cx, Cy, Px, Py);

			
			#24;
			$fdisplay(out, "%d", return);
		end
		$finish();
	end 
endmodule
