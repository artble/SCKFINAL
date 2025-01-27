module testbench;

    parameter [2:0] ADD = 0;
    parameter [2:0] SUB = 1;
    parameter [2:0] MAX = 2;
    parameter [2:0] MIN = 3;
    parameter [2:0] AND = 4;
    parameter [2:0] ORR = 5;
    parameter [2:0] XOR = 6;
    parameter [2:0] XNOR = 7;

    reg [2:0] i_oper;
    reg [3:0] i_reg0;
    reg [3:0] i_reg1;
    reg [3:0] i_reg2;
    reg signed [9:0] i_data2;
    reg signed [9:0] i_data;
    reg imm;
    reg clk;
    reg rsn;
    wire [3:0] o_flag;
    wire signed [9:0] o_data;

    exe EXE(
        .i_oper(i_oper), 
        .i_reg0(i_reg0), 
        .i_reg1(i_reg1), 
        .i_reg2(i_reg2),
        .i_data2(i_data2), 
        .i_data(i_data), 
        .i_imm(imm),
        .i_clk(clk), 
        .i_rsn(rsn), 
        .o_flag(o_flag), 
        .o_data(o_data)
    );

    // Generacja sygnału zegarowego
    initial clk = 0;
    always #5 clk = ~clk;

    // Sekcja inicjalizacji generowania pliku .vcd
    initial begin
        $dumpfile("dump.vcd"); // Plik wynikowy
        $dumpvars(0, testbench); // Rejestracja sygnałów z testbench
    end

    integer i;

    initial 
    begin
        // Inicjowanie jednostki
        i_oper = ADD;
        i_reg0 = 0;
        i_reg1 = 0;
        i_reg2 = 0;
        i_data2 = 0;
        i_data = 0;
        imm = 0;
        rsn = 1;

        #10;

        rsn = 0;

        #10;

        rsn = 1;

        // Test zapisu do rejestrów
        for(i = 1; i <= 9; i = i + 1) begin
            i_reg2 = i;
            i_data2 = i * 24;
            #10;
        end

        i_reg2 = 0;

        // Kolejne polecenia ALU dla kolejnych rejestrów
        for(i = 1; i <= 8; i = i + 1) begin
            i_oper = i - 1;
            i_reg0 = i;
            i_reg1 = i + 1;
            #10;
        end

        // Test przekierowania wyniku do rejestru
        i_reg0 = 7;
        i_reg1 = 8;
        i_oper = ADD;

        #10;

        i_reg2 = 9;
        i_data2 = o_data;

        #10;

        // Test edytowania pojedynczego rejestru
        i_reg2 = 0;

        i_reg0 = 4;
        i_reg1 = 1;
        i_oper = SUB;

        #1;

        i_data2 = o_data;
        i_reg2 = 4;

        #9;

        i_data = o_data;
        imm = 1;
        i_reg2 = 0;

        #10;

        i_reg0 = 0;
        i_reg1 = 0;
        i_reg2 = 0;
        i_data2 = 0;

        // Test zewnętrznego wprowadzania danych
        i_oper = ADD;
        imm = 1;
        i_reg1 = 9;
        i_data = 27;

        #10;

        imm = 0;
        i_reg1 = 0;

        #10;

        $finish; // Zakończenie symulacji
    end

endmodule

