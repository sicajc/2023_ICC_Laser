/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : N-2017.09-SP2
// Date      : Fri Mar 31 20:21:19 2023
/////////////////////////////////////////////////////////////


module Inside ( x, y, circle_x, circle_y, is_inside );
  input [3:0] x;
  input [3:0] y;
  input [3:0] circle_x;
  input [3:0] circle_y;
  output is_inside;
  wire   dis_y_4_, dis_y_3_, dis_y_2_, dis_y_1_, dis_y_0_, dis_x_4_, dis_x_3_,
         dis_x_2_, dis_x_1_, dis_x_0_, dis_9_, dis_8_, dis_7_, dis_6_, dis_5_,
         dis_4_, dis_3_, dis_2_, dis_1_, dis_0_, N9, N8, N7, N6, N5, N4, N3,
         N2, N19, N18, N17, N16, N15, N14, N13, N12, N10, N0, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, SYNOPSYS_UNCONNECTED_1,
         SYNOPSYS_UNCONNECTED_2;

  Inside_DW01_add_0 add_13 ( .A({N9, N8, N7, N6, N5, N4, N3, N2, 1'b0, N0}), 
        .B({N19, N18, N17, N16, N15, N14, N13, N12, 1'b0, N10}), .CI(1'b0), 
        .SUM({dis_9_, dis_8_, dis_7_, dis_6_, dis_5_, dis_4_, dis_3_, dis_2_, 
        dis_1_, dis_0_}) );
  Inside_DW_mult_tc_2 mult_pow_13 ( .a({dis_x_4_, dis_x_3_, dis_x_2_, dis_x_1_, 
        dis_x_0_}), .b({dis_x_4_, dis_x_3_, dis_x_2_, dis_x_1_, dis_x_0_}), 
        .product({N9, N8, N7, N6, N5, N4, N3, N2, SYNOPSYS_UNCONNECTED_1, N0})
         );
  Inside_DW_mult_tc_3 mult_pow_13_2 ( .a({dis_y_4_, dis_y_3_, dis_y_2_, 
        dis_y_1_, dis_y_0_}), .b({dis_y_4_, dis_y_3_, dis_y_2_, dis_y_1_, 
        dis_y_0_}), .product({N19, N18, N17, N16, N15, N14, N13, N12, 
        SYNOPSYS_UNCONNECTED_2, N10}) );
  NOR4BX1 U13 ( .AN(n11), .B(dis_9_), .C(dis_7_), .D(dis_8_), .Y(is_inside) );
  AOI211X1 U14 ( .A0(dis_4_), .A1(n12), .B0(dis_6_), .C0(dis_5_), .Y(n11) );
  OR4X1 U15 ( .A(dis_1_), .B(dis_0_), .C(dis_3_), .D(dis_2_), .Y(n12) );
  OAI21XL U16 ( .A0(circle_y[3]), .A1(n13), .B0(n14), .Y(dis_y_4_) );
  OAI2BB1X1 U17 ( .A0N(n13), .A1N(circle_y[3]), .B0(y[3]), .Y(n14) );
  XNOR2X1 U18 ( .A(n13), .B(n15), .Y(dis_y_3_) );
  XOR2X1 U19 ( .A(y[3]), .B(circle_y[3]), .Y(n15) );
  OAI2BB2XL U20 ( .B0(y[2]), .B1(n16), .A0N(n17), .A1N(circle_y[2]), .Y(n13)
         );
  NOR2X1 U21 ( .A(circle_y[2]), .B(n17), .Y(n16) );
  XNOR2X1 U22 ( .A(n17), .B(n18), .Y(dis_y_2_) );
  XOR2X1 U23 ( .A(y[2]), .B(circle_y[2]), .Y(n18) );
  OAI21XL U24 ( .A0(n19), .A1(n20), .B0(n21), .Y(n17) );
  AO21X1 U25 ( .A0(n20), .A1(n19), .B0(y[1]), .Y(n21) );
  CLKINVX1 U26 ( .A(circle_y[1]), .Y(n20) );
  XNOR2X1 U27 ( .A(n19), .B(n22), .Y(dis_y_1_) );
  XNOR2X1 U28 ( .A(circle_y[1]), .B(y[1]), .Y(n22) );
  CLKINVX1 U29 ( .A(n23), .Y(n19) );
  OAI21XL U30 ( .A0(y[0]), .A1(n24), .B0(n23), .Y(dis_y_0_) );
  NAND2X1 U31 ( .A(y[0]), .B(n24), .Y(n23) );
  CLKINVX1 U32 ( .A(circle_y[0]), .Y(n24) );
  OAI21XL U33 ( .A0(circle_x[3]), .A1(n25), .B0(n26), .Y(dis_x_4_) );
  OAI2BB1X1 U34 ( .A0N(n25), .A1N(circle_x[3]), .B0(x[3]), .Y(n26) );
  XNOR2X1 U35 ( .A(n25), .B(n27), .Y(dis_x_3_) );
  XOR2X1 U36 ( .A(x[3]), .B(circle_x[3]), .Y(n27) );
  OAI2BB2XL U37 ( .B0(x[2]), .B1(n28), .A0N(n29), .A1N(circle_x[2]), .Y(n25)
         );
  NOR2X1 U38 ( .A(circle_x[2]), .B(n29), .Y(n28) );
  XNOR2X1 U39 ( .A(n29), .B(n30), .Y(dis_x_2_) );
  XOR2X1 U40 ( .A(x[2]), .B(circle_x[2]), .Y(n30) );
  OAI21XL U41 ( .A0(n31), .A1(n32), .B0(n33), .Y(n29) );
  AO21X1 U42 ( .A0(n32), .A1(n31), .B0(x[1]), .Y(n33) );
  CLKINVX1 U43 ( .A(circle_x[1]), .Y(n32) );
  XNOR2X1 U44 ( .A(n31), .B(n34), .Y(dis_x_1_) );
  XNOR2X1 U45 ( .A(circle_x[1]), .B(x[1]), .Y(n34) );
  CLKINVX1 U46 ( .A(n35), .Y(n31) );
  OAI21XL U47 ( .A0(x[0]), .A1(n36), .B0(n35), .Y(dis_x_0_) );
  NAND2X1 U48 ( .A(x[0]), .B(n36), .Y(n35) );
  CLKINVX1 U49 ( .A(circle_x[0]), .Y(n36) );
endmodule


module Inside_DW_mult_tc_3 ( a, b, product );
  input [4:0] a;
  input [4:0] b;
  output [9:0] product;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n27, n28, n29, n30, n31;

  CLKINVX1 U1 ( .A(n1), .Y(product[9]) );
  ADDFXL U2 ( .A(n14), .B(a[4]), .CI(n2), .CO(n1), .S(product[8]) );
  ADDFXL U3 ( .A(n8), .B(n15), .CI(n3), .CO(n2), .S(product[7]) );
  ADDFXL U4 ( .A(n9), .B(n10), .CI(n4), .CO(n3), .S(product[6]) );
  ADDFXL U5 ( .A(n11), .B(n12), .CI(n5), .CO(n4), .S(product[5]) );
  ADDFXL U6 ( .A(n13), .B(n20), .CI(n6), .CO(n5), .S(product[4]) );
  ADDHXL U7 ( .A(n22), .B(n7), .CO(n6), .S(product[3]) );
  ADDHXL U8 ( .A(a[1]), .B(n23), .CO(n7), .S(product[2]) );
  ADDFXL U9 ( .A(n18), .B(a[3]), .CI(n16), .CO(n8), .S(n9) );
  XNOR2X1 U10 ( .A(n17), .B(n19), .Y(n11) );
  OR2X1 U11 ( .A(n17), .B(n19), .Y(n10) );
  ADDHXL U12 ( .A(a[2]), .B(n21), .CO(n12), .S(n13) );
  OR2X1 U13 ( .A(n29), .B(n28), .Y(n14) );
  OR2X1 U14 ( .A(n30), .B(n28), .Y(n15) );
  OR2X1 U15 ( .A(n31), .B(n28), .Y(n16) );
  OR2X1 U16 ( .A(n27), .B(n28), .Y(n17) );
  NOR2X1 U17 ( .A(n30), .B(n29), .Y(n18) );
  NOR2X1 U18 ( .A(n31), .B(n29), .Y(n19) );
  NOR2X1 U19 ( .A(n27), .B(n29), .Y(n20) );
  NOR2X1 U20 ( .A(n31), .B(n30), .Y(n21) );
  NOR2X1 U21 ( .A(n27), .B(n30), .Y(n22) );
  NOR2X1 U22 ( .A(n27), .B(n31), .Y(n23) );
  CLKINVX1 U34 ( .A(a[0]), .Y(n27) );
  CLKINVX1 U35 ( .A(a[4]), .Y(n28) );
  CLKBUFX3 U36 ( .A(a[0]), .Y(product[0]) );
  CLKINVX1 U37 ( .A(a[1]), .Y(n31) );
  CLKINVX1 U38 ( .A(a[2]), .Y(n30) );
  CLKINVX1 U39 ( .A(a[3]), .Y(n29) );
endmodule


module Inside_DW_mult_tc_2 ( a, b, product );
  input [4:0] a;
  input [4:0] b;
  output [9:0] product;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n27, n28, n29, n30, n31;

  CLKINVX1 U1 ( .A(n1), .Y(product[9]) );
  ADDFXL U2 ( .A(n14), .B(a[4]), .CI(n2), .CO(n1), .S(product[8]) );
  ADDFXL U3 ( .A(n8), .B(n15), .CI(n3), .CO(n2), .S(product[7]) );
  ADDFXL U4 ( .A(n9), .B(n10), .CI(n4), .CO(n3), .S(product[6]) );
  ADDFXL U5 ( .A(n11), .B(n12), .CI(n5), .CO(n4), .S(product[5]) );
  ADDFXL U6 ( .A(n13), .B(n20), .CI(n6), .CO(n5), .S(product[4]) );
  ADDHXL U7 ( .A(n22), .B(n7), .CO(n6), .S(product[3]) );
  ADDHXL U8 ( .A(a[1]), .B(n23), .CO(n7), .S(product[2]) );
  ADDFXL U9 ( .A(n18), .B(a[3]), .CI(n16), .CO(n8), .S(n9) );
  XNOR2X1 U10 ( .A(n17), .B(n19), .Y(n11) );
  OR2X1 U11 ( .A(n17), .B(n19), .Y(n10) );
  ADDHXL U12 ( .A(a[2]), .B(n21), .CO(n12), .S(n13) );
  OR2X1 U13 ( .A(n29), .B(n28), .Y(n14) );
  OR2X1 U14 ( .A(n30), .B(n28), .Y(n15) );
  OR2X1 U15 ( .A(n31), .B(n28), .Y(n16) );
  OR2X1 U16 ( .A(n27), .B(n28), .Y(n17) );
  NOR2X1 U17 ( .A(n30), .B(n29), .Y(n18) );
  NOR2X1 U18 ( .A(n31), .B(n29), .Y(n19) );
  NOR2X1 U19 ( .A(n27), .B(n29), .Y(n20) );
  NOR2X1 U20 ( .A(n31), .B(n30), .Y(n21) );
  NOR2X1 U21 ( .A(n27), .B(n30), .Y(n22) );
  NOR2X1 U22 ( .A(n27), .B(n31), .Y(n23) );
  CLKINVX1 U34 ( .A(a[0]), .Y(n27) );
  CLKINVX1 U35 ( .A(a[4]), .Y(n28) );
  CLKINVX1 U36 ( .A(a[1]), .Y(n31) );
  CLKINVX1 U37 ( .A(a[2]), .Y(n30) );
  CLKINVX1 U38 ( .A(a[3]), .Y(n29) );
  CLKBUFX3 U39 ( .A(a[0]), .Y(product[0]) );
endmodule


module Inside_DW01_add_0 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   carry_9_, carry_8_, carry_7_, carry_6_, carry_5_, carry_4_, carry_3_,
         n1, n2, n3, n4;

  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry_3_), .CO(carry_4_), .S(SUM[3])
         );
  ADDFXL U1_8 ( .A(A[8]), .B(B[8]), .CI(carry_8_), .CO(carry_9_), .S(SUM[8])
         );
  XOR3X1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry_9_), .Y(SUM[9]) );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry_5_), .CO(carry_6_), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry_4_), .CO(carry_5_), .S(SUM[4])
         );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry_6_), .CO(carry_7_), .S(SUM[6])
         );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry_7_), .CO(carry_8_), .S(SUM[7])
         );
  CLKINVX1 U1 ( .A(A[2]), .Y(n3) );
  NOR2X1 U2 ( .A(n1), .B(n2), .Y(SUM[1]) );
  XNOR2X1 U3 ( .A(B[0]), .B(n1), .Y(SUM[0]) );
  XNOR2X1 U4 ( .A(B[2]), .B(n3), .Y(SUM[2]) );
  NOR2X1 U5 ( .A(n3), .B(n4), .Y(carry_3_) );
  CLKINVX1 U6 ( .A(B[2]), .Y(n4) );
  CLKINVX1 U7 ( .A(B[0]), .Y(n2) );
  CLKINVX1 U8 ( .A(A[0]), .Y(n1) );
endmodule

