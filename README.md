# SCKFINAL
NEG:
Ustawiane, gdy wynik (o_result) jest mniejszy niż 0.
POS:
Ustawiane, gdy wynik (o_result) jest większy niż 0.
ZERO:
Ustawiane, gdy wynik (o_result) jest równy 0.
OVF (przepełnienie):
Sprawdzane tylko w operacjach ADD i SUB, gdy liczby są dodawane/odejmowane i przekraczają zakres 10-bitowy.
Dla ADD przepełnienie występuje, gdy:
Dwie liczby dodatnie są dodawane, ale wynik staje się ujemny.
Dwie liczby ujemne są dodawane, ale wynik staje się dodatni.
Dla SUB przepełnienie występuje, gdy:
Liczba dodatnia jest odejmowana od liczby ujemnej, ale wynik staje się dodatni.
Liczba ujemna jest odejmowana od liczby dodatniej, ale wynik staje się ujemny.



initial begin
    $dumpfile("dump.vcd"); // Plik wynikowy, do wizualizacji
    $dumpvars(0, testbench); // Rejestracja wszystkich sygnałów w module testbench
end

iverilog -o simulation testbench.v alu.v exe.v myreg.v

vvp simulation

gtkwave dump.vcd
