`timescale 1ns / 1ps



module FA(
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module R_CA(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] s,
    output cout
);

    wire cout1, cout2, cout3;

    FA uut1(a[0], b[0], cin, s[0], cout1);
    FA uut2(a[1], b[1], cout1, s[1], cout2);
    FA uut3(a[2], b[2], cout2, s[2], cout3);
    FA uut4(a[3], b[3], cout3, s[3], cout);
endmodule

module HA(
    input A,
    input B,
    output sum,
    output carry
);
    assign sum = A ^ B;
    assign carry = A & B;
endmodule

module bit_vedic(
    input a0,
    input a1,
    input b0,
    input b1,
    output p0,
    output p1,
    output p2,
    output p3
);
    wire y2, y3, y4, c1;

    assign p0 = a0 & b0;
    assign y2 = a0 & b1;
    assign y3 = a1 & b0;
    assign y4 = a1 & b1;

    HA uut1(y2, y3, p1, c1);
    HA uut2(c1, y4, p2, p3);
endmodule

module VM_FA(
    input [3:0] a,
    input [3:0] b,
    input c,
    output [7:0] s
);
    wire [15:2] p;  
    wire [5:0] d;   
    wire CO1,CO2,CO3;

    bit_vedic uut1(a[0], a[1], b[0], b[1], s[0], s[1], p[2], p[3]);
    bit_vedic uut2(a[0], a[1], b[2], b[3], p[4], p[5], p[6], p[7]);
    bit_vedic uut3(a[2], a[3], b[0], b[1], p[8], p[9], p[10], p[11]);
    bit_vedic uut4(a[2], a[3], b[2], b[3], p[12], p[13], p[14], p[15]);

    R_CA dut1({p[7], p[6], p[5], p[4]}, {p[11], p[10], p[9], p[8]}, c , {d[3], d[2], d[1], d[0]}, CO1);
    R_CA dut2({c, c, p[3], p[2]}, {d[3], d[2], d[1], d[0]}, c, {d[5], d[4], s[3], s[2]}, CO2);
    R_CA dut3({c, CO1, d[5], d[4]}, {p[15], p[14], p[13], p[12]}, c , {s[7], s[6], s[5], s[4]}, CO3);
endmodule
