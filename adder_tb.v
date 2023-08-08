`timescale 1ns / 1ps

module adder_tb( );
reg a;
reg b;
wire s;
wire c;
adder1 uut(.a(a),.b(b),.s(s),.c(c));
initial begin
#10
a=0;
b=0;
#10
a=0;
b=1;
#10
a=1;
b=0;
#10
a=1;
b=1;
#10
$stop;
end
always @(a or b) begin
    $display("%b + %b = %b with carry %b at timeperiod %t", a, b, s, c, $time);
end
endmodule
