module LASER (
input CLK,
input RST,
input [3:0] X,
input [3:0] Y,
output reg [3:0] C1X,
output reg [3:0] C1Y,
output reg [3:0] C2X,
output reg [3:0] C2Y,
output reg DONE);

//================================================================
//   PARAMETER
//================================================================

localparam IDLE      = 3'd0;
localparam READ      = 3'd1;
localparam IS_INSIDE = 3'd2;
localparam FIND_BEST = 3'd3;
localparam OUT       = 3'd4;

localparam OBJ_NUM  = 40;
localparam PARALLEL = 5;
localparam IS_INSIDE_NUM = 8; // OBJ_NUM / PARALLEL
localparam MAX_ITER = 6;

integer i;
genvar idx;

//================================================================
//   REG
//================================================================
reg [2:0] curr_state,next_state;
reg [5:0] global_cnt;
reg [10:0] iter_cnt;
reg [7:0] obj_mem[0:39];//obj_x [3:0];obj_y [7:4]
reg [3:0] col_ptr,row_ptr;
reg [7:0] circal_loc_C1,circal_loc_C2;
reg [5:0] opt_num;
reg [39:0] max_c1_dirty,max_c2_dirty,tmp_dirty ;

//================================================================
//   WIRE
//================================================================

reg [5:0] opt_num_w;
reg [39:0] or_result;

//state indicater
wire state_IDLE      = curr_state == IDLE;
wire state_READ      = curr_state == READ;
wire state_IS_INSIDE = curr_state == IS_INSIDE;
wire state_FIND_BEST = curr_state == FIND_BEST;
wire state_OUT       = curr_state == OUT;

//flag
wire rd_done         = global_cnt == OBJ_NUM -1 && state_READ;
wire IS_INSIDE_done  = global_cnt == OBJ_NUM - PARALLEL && state_IS_INSIDE;
wire row_boundary    = row_ptr    == 'd15;
wire col_boundary    = col_ptr    == 'd15;
wire opt_tmp_lr_max  = opt_num_w  >= opt_num; //larger than
wire one_iter_done   = state_FIND_BEST && row_boundary && col_boundary;
wire FIND_BEST_done  = iter_cnt   == MAX_ITER -1 && one_iter_done;

//wire 
wire [3:0] cur_pos_X[0:PARALLEL-1];
wire [3:0] cur_pos_Y[0:PARALLEL-1];

// I/O
wire [PARALLEL-1:0] is_inside;

//================================================================
//   assign
//================================================================

generate
	for(idx=0;idx<PARALLEL;idx=idx+1) begin
		assign cur_pos_X[idx] = state_IS_INSIDE ? obj_mem[global_cnt+idx][3:0] : 'd0;
		assign cur_pos_Y[idx] = state_IS_INSIDE ? obj_mem[global_cnt+idx][7:4] : 'd0;
	end
endgenerate

//================================================================
//   FSM
//================================================================
always @(posedge CLK) begin
	if(RST) begin
		curr_state <= READ;
	end 
	else begin
		curr_state <= next_state;
	end
end

always @(*) begin 
	case (curr_state)
		IDLE      : next_state = READ;
		READ      : next_state = rd_done ? IS_INSIDE : READ;
		IS_INSIDE : next_state = IS_INSIDE_done ? FIND_BEST : IS_INSIDE;
		FIND_BEST : next_state = FIND_BEST_done ? OUT : IS_INSIDE;
		OUT       : next_state = IDLE;
	endcase
end

//================================================================
//   I/O
//================================================================
generate 
	for(idx=0;idx<PARALLEL;idx=idx+1) begin
		Inside inst_Inside (.x(cur_pos_X[idx]), .y(cur_pos_Y[idx]), .circle_x(col_ptr), .circle_y(row_ptr), .is_inside(is_inside[idx]));
	end
endgenerate

//================================================================
//   OUT
//================================================================
always @(posedge CLK) begin 
	if(RST) begin
		C1X  <= 0;
		C1Y  <= 0;
		C2X  <= 0;
		C2Y  <= 0;
		DONE <= 0;
	end 
	else if(state_OUT)begin
		C1X  <= circal_loc_C1[3:0];
		C1Y  <= circal_loc_C1[7:4];
		C2X  <= circal_loc_C2[3:0];
		C2Y  <= circal_loc_C2[7:4];
		DONE <= 1;
	end
	else begin
		C1X  <= 0;
		C1Y  <= 0;
		C2X  <= 0;
		C2Y  <= 0;
		DONE <= 0;
	end
end

//================================================================
//   DESIGN
//================================================================

always @(posedge CLK) begin 
	if(RST) begin
		global_cnt <= 'd0;
	end 
	else if(rd_done || IS_INSIDE_done) begin
		global_cnt <= 'd0;
	end
	else if(state_IS_INSIDE) begin
		global_cnt <= global_cnt + PARALLEL;
	end
	else if(state_READ) begin
		global_cnt <= global_cnt + 'd1;
	end
	else if(state_IDLE) begin
		global_cnt <= 'd0;
	end
end

//obj_mem
always @(posedge CLK) begin
	if(RST) begin
		for (i = 0; i < 40; i=i+1) begin
		    obj_mem[i] <= 'd0;
		end
	end 
	else if(state_READ)begin
		obj_mem[global_cnt] <= {Y,X};
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		col_ptr <= 'd0;
	end 
	else if(state_FIND_BEST) begin
		col_ptr <= col_boundary ? 'd0 : col_ptr + 'd1;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		row_ptr <= 'd0;
	end 
	else if(state_FIND_BEST) begin
		row_ptr <= col_boundary ? (row_boundary ? 'd0 : row_ptr + 'd1) : row_ptr;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		iter_cnt <= 0;
	end 
	else if(one_iter_done) begin
		iter_cnt <= iter_cnt + 'd1;
	end
	else if(state_IDLE) begin
		iter_cnt <= 'd0;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		circal_loc_C1 <= 0;
	end 
	else if(one_iter_done) begin
		circal_loc_C1 <= circal_loc_C2;
	end
	else if(state_FIND_BEST) begin
		circal_loc_C1 <= opt_tmp_lr_max ? {row_ptr,col_ptr} : circal_loc_C1;
	end
	else if(state_IDLE) begin
		circal_loc_C1 <= 'd0;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		circal_loc_C2 <= 0;
	end 
	else if(one_iter_done) begin
		circal_loc_C2 <= circal_loc_C1;
	end
	else if(state_IDLE) begin
		circal_loc_C2 <= 'd0;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		tmp_dirty <= 0;
	end 
	else if(state_IS_INSIDE) begin
		tmp_dirty[PARALLEL+global_cnt-:PARALLEL] <= is_inside;
	end
end

always @(posedge CLK) begin 
	if(RST) begin
		max_c1_dirty <= 0;
	end 
	else if(one_iter_done) begin
		max_c1_dirty <= max_c2_dirty;
	end
	else if(state_FIND_BEST) begin
		max_c1_dirty <= opt_tmp_lr_max ? tmp_dirty : max_c1_dirty;
	end
	else if(state_IDLE) begin
		max_c1_dirty <= 0;
	end 
end

always @(posedge CLK) begin 
	if(RST) begin
		max_c2_dirty <= 0;
	end 
	else if(one_iter_done) begin
		max_c2_dirty <= max_c1_dirty;
	end
	else if(state_IDLE) begin
		max_c2_dirty <= 0;
	end 
end

always @(posedge CLK) begin 
	if(RST) begin
		opt_num <= 0;
	end 
	else if(state_FIND_BEST) begin
		opt_num <= opt_tmp_lr_max ? opt_num_w : opt_num;
	end
	else if(state_IDLE) begin
		opt_num <= 0;
	end 
end

always@(*)
begin
	or_result = max_c2_dirty | tmp_dirty ; 
    opt_num_w = 0;  //initialize count variable
    for(i=0;i<40;i=i+1)   //check for all the bits
        if(or_result[i] == 1'b1)    //check if the bit is '1'
            opt_num_w = opt_num_w + 1;    //if its one, increment the count
end

endmodule

module Inside (
input [3:0] x,
input [3:0] y,
input [3:0] circle_x,
input [3:0] circle_y,
output reg is_inside // 1: is inside, 0: is outside
);

wire signed [4:0]  dis_x = circle_x - x;
wire signed [4:0]  dis_y = circle_y - y;

wire [4:0] abs_dis_x = dis_x[4] ? ~dis_x + 1 : dis_x;
wire [4:0] abs_dis_y = dis_y[4] ? ~dis_y + 1 : dis_y;

wire [5:0] dis =  abs_dis_x + abs_dis_y;

always @(*) begin 
	if (dis <= 4) begin
		is_inside = 1;
	end 
	else if(abs_dis_x == 2 && abs_dis_y == 3) begin
		is_inside = 1;
	end
	else if(abs_dis_y == 2 && abs_dis_x == 3) begin
		is_inside = 1;
	end
	else begin
		is_inside = 0;
	end
end

endmodule