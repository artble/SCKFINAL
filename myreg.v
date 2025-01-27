module my_register(i_reg0, i_reg1, i_reg2, 
                   o_data0, o_data1, i_data2, 
                   i_clk, i_rsn);
    input wire [3:0] i_reg0;
    input wire [3:0] i_reg1;
    input wire [3:0] i_reg2;
    output reg signed [9:0] o_data0;
    output reg signed [9:0] o_data1;
    input wire signed [9:0] i_data2;
    input wire i_clk;
    input wire i_rsn;

    reg [9:0] RRR [1:12]; // Zmiana rozmiaru tablicy na 12 rejestrów

    integer iter;

    always @(*) begin
        o_data0 <= ((i_reg0 > 0) & (i_reg0 <= 12)) ? RRR[i_reg0] : 0; // Obsługa 12 rejestrów
        o_data1 <= ((i_reg1 > 0) & (i_reg1 <= 12)) ? RRR[i_reg1] : 0;
    end

    always @(posedge i_clk, negedge i_rsn) begin
        if (!i_rsn) begin
            for ( iter = 1; iter <= 12; iter = iter + 1) // Pętla dla 12 rejestrów
                RRR[iter] = 0;
        end else if((i_reg2 > 0) & (i_reg2 <= 12)) begin
            RRR[i_reg2] = i_data2;
        end
    end

endmodule

