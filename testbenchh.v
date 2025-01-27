module testbench;

    parameter [2:0] ADD = 0;
    parameter [2:0] SUB = 1;
    parameter [2:0] MAX = 2;
    parameter [2:0] MIN = 3;
    parameter [2:0] AND = 4;
    parameter [2:0] ORR = 5;
    parameter [2:0] XOR = 6;
    parameter [2:0] XNOR = 7;

    reg signed [9:0] a;
    reg signed [9:0] b;
    reg [2:0] oper;
    wire signed [9:0] y;
    wire [3:0] flags;

    proj1 u1 (.i_arg0(a), .i_arg1(b), .i_oper(oper), .o_result(y), .o_flag(flags));

    // Dodanie generacji pliku .vcd dla GTKWave
    initial begin
        $dumpfile("proj1.vcd"); // Plik wynikowy
        $dumpvars(0, testbench); // Rejestracja sygnałów w module testbench
    end

    initial 
    begin
        
        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = ADD;
        
        #1 ; 

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = SUB;

        #1;
        
        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = MAX;

        #1;

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = MIN;

        #1;

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = AND;

        #1;

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = ORR;

        #1;

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = XOR;

        #1;

        a = 10'b0001000000;
        b = 10'b0000010000;
        oper = XNOR;

        #1;


        // flag overflow

        a = 10'b0111111111;
        b = 10'b0111111111;
        oper = ADD;

        #1;

        a = -511;
        b = -511;
        oper = ADD;

        #1;

        a = 511;
        b = -511;
        oper = SUB;

        #1;

        a = -511;
        b = 511;
        oper = SUB;

        #1;

        a = 200;
        b = -100;
        oper = SUB;

        #1;

        a = -200;
        b = 100;
        oper = SUB;

        #1;
        a = 200;
        b = 300;
        oper = SUB;

        #1;

        a = -200;
        b = -300;
        oper = SUB;

        #1;

        $finish;
        
    end

endmodule

