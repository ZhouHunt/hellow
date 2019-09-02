module centroid_ctrl(
	input        clk160M  ,
	input        rst0     ,
	input        hsync    ,
	input        vsync    ,
	input  [9:0] cnt_r    ,
	input        ap_done0 ,
	input        ap_done1 ,
	output       ap_rst_n0,
	output reg   ap_start0,
	output       ap_rst_n1,
	output reg   ap_start1,
	
	input             en0     ,
	input      [19:0] p_sum0  ,
	input      [31:0] x_sum0  ,
	input      [31:0] y_sum0  ,
	input      [9 :0] xmin_in0,
	input      [9 :0] ymin_in0,
	input      [9 :0] xmax_in0,
	input      [9 :0] ymax_in0,
	input             en1     ,
	input      [19:0] p_sum1  ,
	input      [31:0] x_sum1  ,
	input      [31:0] y_sum1  ,
	input      [9 :0] xmin_in1,
	input      [9 :0] ymin_in1,
	input      [9 :0] xmax_in1,
	input      [9 :0] ymax_in1,
	output reg        en      ,
	output reg [19:0] p_sum   ,
	output reg [31:0] x_sum   ,
	output reg [31:0] y_sum   ,
	output reg [9 :0] xmin_in ,
	output reg [9 :0] ymin_in ,
	output reg [9 :0] xmax_in ,
	output reg [9 :0] ymax_in 
);
// ----------------------- process image 0
//wire        ap_done0;
assign ap_rst_n0    = ~rst0 && ~ap_done0;
wire start_flag0;
//assign start_flag0 = ((cnt_r>=20 && cnt_r<=197) || (cnt_r>=360 && cnt_r<=537) || (cnt_r>=700 && cnt_r<=877)) ? 1 :0;
assign start_flag0 = ((cnt_r>=50 && cnt_r<=227) || (cnt_r>=338 && cnt_r<=515) || (cnt_r>=626 && cnt_r<=803)) ? 1 :0;
always @(posedge clk160M) begin
    if(rst0 || vsync==0) begin
        ap_start0 <= 0;
    end
    else if(start_flag0 == 1)begin
        ap_start0 <= 1;
    end
    else begin
        ap_start0 <= 0;
    end
end
// ----------------------- process image 1
assign ap_rst_n1    = ~rst0 && ~ap_done1;
wire start_flag1;
//assign start_flag1 = ((cnt_r>=190 && cnt_r<=367) || (cnt_r>=530 && cnt_r<=707)) ? 1 :0;
assign start_flag1 = ((cnt_r>=194 && cnt_r<=371) || (cnt_r>=482 && cnt_r<=659)) ? 1 :0;
always @(posedge clk160M) begin
    if(rst0 || vsync==0) begin
        ap_start1 <= 0;
    end
    else if(start_flag1 == 1)begin
        ap_start1 <= 1;
    end
    else begin
        ap_start1 <= 0;
    end
end

always @(posedge clk160M) begin
	if(en0 || en1) begin
		en <= 1'b1;
	end else begin
		en <= 1'b0;
	end
	
	if(en0) begin
		p_sum   <= p_sum0   ;
		x_sum   <= x_sum0   ;
		y_sum   <= y_sum0   ;
		xmin_in <= xmin_in0 ;
		ymin_in <= ymin_in0 ;
		xmax_in <= xmax_in0 ;
		ymax_in <= ymax_in0 ;
	end else if(en1) begin
		p_sum   <= p_sum1   ;
		x_sum   <= x_sum1   ;
		y_sum   <= y_sum1   ;
		xmin_in <= xmin_in1 ;
		ymin_in <= ymin_in1 ;
		xmax_in <= xmax_in1 ;
		ymax_in <= ymax_in1 ;
	end else begin
		p_sum   <= 0 ;
		x_sum   <= 0 ;
		y_sum   <= 0 ;
		xmin_in <= 0 ;
		ymin_in <= 0 ;
		xmax_in <= 0 ;
		ymax_in <= 0 ;
	end
end

endmodule