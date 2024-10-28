`timescale 1ns / 1ps



module FA(
    input a, b, cin,
    output sum, cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
    
    

module R_CA_1(
    input [3:0] a,
    input [3:0] b,
    output [3:0] s,
    output c1
);

    wire cout1, cout2, cout3;

    HA uut1(a[0], b[0], s[0], cout1);
    FA uut2(a[1], b[1], cout1, s[1], cout2);
    FA uut3(a[2], b[2], cout2, s[2], cout3);
    FA uut4(a[3], b[3], cout3, s[3], c1);
endmodule

module R_CA_2(
    input [1:0] a,
    input [3:0] b,
    output [3:0] s
    
);

 wire cout1, cout2, cout3;


    HA uut1(a[0], b[0], s[0], cout1);
    FA uut2(a[1], b[1], cout1, s[1], cout2);
    HA uut3(cout2, b[2], s[2], cout3);
    xor g1(s[3],cout3,b[3]); 
    
    endmodule

module R_CA_3(
    input [2:0] a,
    input [3:0] b,
    output [3:0] s
   
);
 wire cout1, cout2, cout3;


    HA uut1(a[0], b[0], s[0], cout1);
    FA uut2(a[1], b[1], cout1, s[1], cout2);
    FA uut3(a[2], b[2],cout2, s[2], cout3);
    xor g2(s[3], cout3, b[3]); 

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

module modified_with_Xo_R(
    input [3:0] a,
    input [3:0] b,
    output [7:0] s
);
    wire [15:2] p;  
    wire [5:0] d;   
    wire CO1,cout2,cout3;

    bit_vedic uut1(a[0], a[1], b[0], b[1], s[0], s[1], p[2], p[3]);
    bit_vedic uut2(a[0], a[1], b[2], b[3], p[4], p[5], p[6], p[7]);
    bit_vedic uut3(a[2], a[3], b[0], b[1], p[8], p[9], p[10], p[11]);
    bit_vedic uut4(a[2], a[3], b[2], b[3], p[12], p[13], p[14], p[15]);

    R_CA_1 dut1({p[7], p[6], p[5], p[4]}, {p[11], p[10], p[9], p[8]}, {d[3], d[2], d[1], d[0]}, CO1);
    R_CA_2 dut2({cout3, cout2, p[3], p[2]}, {d[3], d[2], d[1], d[0]}, {d[5], d[4], s[3], s[2]});
    R_CA_3 dut3({cout3,CO1, d[5], d[4]}, {p[15], p[14], p[13], p[12]}, {s[7], s[6], s[5], s[4]});
endmodule
