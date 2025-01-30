module proj1 (i_arg0, i_arg1, i_oper, o_result, o_flag);

    parameter [2:0] ADD = 0;
    parameter [2:0] SUB = 1;
    parameter [2:0] SHIFT = 2;
    parameter [2:0] AND = 3;
    parameter [2:0] ORR = 4;
    parameter [2:0] XOR = 5;
    parameter [2:0] XNOR = 6;

    input wire signed [9:0] i_arg0;
    input wire signed [9:0] i_arg1;
    input wire [2:0] i_oper;
    output reg signed [9:0] o_result;
    output reg [3:0] o_flag;

    reg NEG, POS, ZERO, OVF;

always @(i_arg0 or i_arg1 or i_oper) begin
    case (i_oper)
        ADD: o_result = i_arg0 + i_arg1;
        SUB: o_result = i_arg0 - i_arg1;
        SHIFT: begin
                if (i_arg1 > 0)
                    o_result = i_arg0 << i_arg1; // Shift left if B > 0
                else if (i_arg1 < 0)
                    o_result = i_arg0 >> -i_arg1; // Shift right if B < 0
                else
                    o_result = i_arg0; // No shift if B == 0
        AND: o_result = i_arg0 & i_arg1;
        ORR: o_result = i_arg0 | i_arg1;
        XOR: o_result = i_arg0 ^ i_arg1;
        XNOR: o_result = i_arg0 ~^ i_arg1;
    endcase

    NEG = o_result < 0;
    POS = o_result > 0;
    ZERO = o_result == 0;

    case (i_oper)
        ADD: OVF = ((i_arg0 > 0) & (i_arg1 > 0) & (NEG == 1)) 
                 | ((i_arg0 < 0) & (i_arg1 < 0) & (POS == 1));
        SUB: OVF = ((i_arg0 > 0) & (i_arg1 < 0) & (NEG == 1)) 
                 | ((i_arg0 < 0) & (i_arg1 > 0) & (POS == 1));
        default: OVF = 0; 
    endcase

    o_flag = {NEG, POS, ZERO, OVF};
end

endmodule
