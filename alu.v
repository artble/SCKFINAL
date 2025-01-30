module alu (i_data, i_arg0, i_arg1,
            i_oper, i_imm,
            o_result, o_flag);

    parameter [2:0] ADD = 0;
    parameter [2:0] SUB = 1;
    parameter [2:0] SHIFT = 2;
    parameter [2:0] AND = 3;
    parameter [2:0] ORR = 4;
    parameter [2:0] XOR = 5;
    parameter [2:0] XNOR = 6;
 
    input wire signed [9:0] i_data;
    input wire signed [9:0] i_arg0;
    input wire signed [9:0] i_arg1;
    input wire [2:0] i_oper;
    input wire i_imm;
    output reg signed [9:0] o_result;
    output reg [3:0] o_flag;
    
    wire signed [9:0] i_arg0_inside;
    reg NEG, POS, ZERO, OVF;

    assign i_arg0_inside = i_imm ? i_data : i_arg0;

    always @(i_arg0_inside or i_arg1 or i_oper) begin
        case (i_oper)
            ADD: o_result = i_arg0_inside + i_arg1;
            SUB: o_result = i_arg0_inside - i_arg1;
            SHIFT: begin
                if (i_arg1 > 0)  // Przesunięcie w lewo (jeśli B > 0)
                    o_result = i_arg0_inside << i_arg1;
                else if (i_arg1 < 0) // Przesunięcie w prawo (jeśli B < 0)
                    o_result = i_arg0_inside >> -i_arg1; // Przemiana na dodatnią liczbę
                else  // Jeśli B == 0, brak przesunięcia
                    o_result = i_arg0_inside;
            AND: o_result = i_arg0_inside & i_arg1;
            ORR: o_result = i_arg0_inside | i_arg1;
            XOR: o_result = i_arg0_inside ^ i_arg1;
            XNOR: o_result = i_arg0_inside ~^ i_arg1;
        endcase

        NEG = o_result < 0;
        POS = o_result > 0;
        ZERO = o_result == 0;

        case (i_oper)
            ADD: OVF = ((i_arg0_inside > 0) & (i_arg1 > 0) & (NEG == 1))
                     | ((i_arg0_inside < 0) & (i_arg1 < 0) & (POS == 1));
            SUB: OVF = ((i_arg0_inside > 0) & (i_arg1 < 0) & (NEG == 1))
                     | ((i_arg0_inside < 0) & (i_arg1 > 0) & (POS == 1));
            default: OVF = 0; 
        endcase

        o_flag = {NEG, POS, ZERO, OVF};
    end

endmodule
