module exe(i_oper, i_reg0, i_reg1, i_reg2,
           i_data2, i_data, i_imm,
           i_clk, i_rsn,
           o_flag, o_data);

    input wire [2:0] i_oper;
    input wire [3:0] i_reg0;
    input wire [3:0] i_reg1;
    input wire [3:0] i_reg2;
    input wire signed [9:0] i_data2;
    input wire signed [9:0] i_data;
    input wire i_imm;
    input wire i_clk;
    input wire i_rsn;
    output wire [3:0] o_flag;
    output wire signed [9:0] o_data;

    wire signed [9:0] o_data0;
    wire signed [9:0] o_data1;

    alu ALU(.i_data(i_data), .i_arg0(o_data0), .i_arg1(o_data1),
            .i_oper(i_oper), .i_imm(i_imm),
            .o_result(o_data), .o_flag(o_flag));
    
    my_register REGS(.i_reg0(i_reg0), .i_reg1(i_reg1), .i_reg2(i_reg2),
                     .o_data0(o_data0), .o_data1(o_data1), .i_data2(i_data2),
                     .i_clk(i_clk), .i_rsn(i_rsn));

endmodule