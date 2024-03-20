// ============================================================================
//        __
//   \\__/ o\    (C) 2015-2019  Robert Finch, Waterloo
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@finitron.ca
//       ||
//
//
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Lesser General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or     
// (at your option) any later version.                                      
//                                                                          
// This source file is distributed in the hope that it will be useful,      
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
// GNU General Public License for more details.                             
//                                                                          
// You should have received a copy of the GNU General Public License        
// along with this program.  If not, see <http://www.gnu.org/licenses/>.    
//                                                                          
//	Verilog 1995
//
// ============================================================================
//
// Compute the graphics address
//
module gfx_CalcAddress6(clk, base_address_i, color_depth_i, bmp_width_i, x_coord_i, y_coord_i,
	address_o, mb_o, me_o, ce_o);
parameter SW = 128;		// strip width in bits
parameter BN = SW==128 ? 6 : SW==64 ? 5 : 4;
input clk;
input [31:0] base_address_i;
input [2:0] color_depth_i;
input [15:0] bmp_width_i;	// pixel per line
input [15:0] x_coord_i;
input [15:0] y_coord_i;
output [31:0] address_o;
output [BN:0] mb_o;					// mask begin
output [BN:0] me_o;					// mask end
output [BN:0] ce_o;					// color bits end

parameter BPP4 = 3'd0;
parameter BPP8 = 3'd1;
parameter BPP12 = 3'd2;
parameter BPP16 = 3'd3;
parameter BPP20 = 3'd4;
parameter BPP32 = 3'd5;

// This coefficient is a fixed point fraction representing the inverse of the
// number of pixels per strip. The inverse (reciprocal) is used for a high
// speed divide operation.
reg [15:0] coeff;
always @(color_depth_i)
case(SW)
128:
	case(color_depth_i)
	BPP4: coeff = 2048; // 1/32 * 65536
	BPP8:	coeff = 4096;	// 1/16 * 65536
	BPP12:	coeff = 6554;	// 1/10 * 65536
	BPP16:	coeff = 8192;	// 1/8 * 65536
	BPP20:	coeff = 10923;	// 1/6 * 65536
	BPP32:	coeff = 16384;	// 1/4 * 65536
	default:	coeff = 8192;
	endcase
64:
	case(color_depth_i)
	BPP4: coeff = 4096; // 1/16 * 65536
	BPP8:	coeff = 8192;	// 1/8 * 65536
	BPP12: coeff = 13107;	// 1/5 * 65536
	BPP16:	coeff = 16384;	// 1/4 * 65536
	BPP20:	coeff = 21845;	// 1/3 * 65536
	BPP32:	coeff = 32767;	// 1/2 * 65536
	default: coeff = 16384;
	endcase
32:
	case(color_depth_i)
	BPP4: coeff = 8192; // 1/8 * 65536
	BPP8:	coeff = 16384;	// 1/4 * 65536
	BPP12: coeff = 32767;	// 1/2 * 65536
	BPP16:	coeff = 32767;	// 1/2 * 65536
	BPP20:	coeff = 65535;	// 1/1 * 65536
	BPP32:	coeff = 65535;	// 1/1 * 65536
	default: coeff = 32767;
	endcase
default:	// 128
	case(color_depth_i)
	BPP4: coeff = 2048; // 1/32 * 65536
	BPP8:	coeff = 4096;	// 1/16 * 65536
	BPP12:	coeff = 6554;	// 1/10 * 65536
	BPP16:	coeff = 8192;	// 1/8 * 65536
	BPP20:	coeff = 10923;	// 1/6 * 65536
	BPP32:	coeff = 16384;	// 1/4 * 65536
	default:	coeff = 8192;
	endcase
endcase

// Bits per pixel minus one.
reg [5:0] bpp;
always @(color_depth_i)
case(color_depth_i)
BPP4: bpp = 3;
BPP8:	bpp = 7;
BPP12: bpp = 11;
BPP16:	bpp = 15;
BPP20:	bpp = 19;
BPP32:	bpp = 31;
default:	bpp = 15;
endcase

// Color bits per pixel minus one.
reg [5:0] cbpp;
always @(color_depth_i)
case(color_depth_i)
BPP4: cbpp = 2;
BPP8:	cbpp = 5;
BPP12: cbpp = 8;
BPP16:	cbpp = 11;
BPP20:	cbpp = 14;
BPP32:	cbpp = 23;
default:	cbpp = 11;
endcase

// This coefficient is the number of bits used by all pixels in the strip. 
// Used to determine pixel placement in the strip.
reg [7:0] coeff2;
always @(color_depth_i)
case(color_depth_i)
BPP4: coeff2 = SW;
BPP8:	coeff2 = SW;
BPP12: coeff2 = SW==128 ? 120 : SW==64 ? 60 : 24;
BPP16:	coeff2 = SW;
BPP20:	coeff2 = SW==128 ? 120 : SW==64 ? 60 : 20;
BPP32:	coeff2 = SW;
default:	coeff2 = SW;
endcase

// Compute the fixed point horizonal strip number value. This has 16 binary
// point places.
wire [31:0] strip_num65k = x_coord_i * coeff;
// Truncate off the binary fraction to get the strip number. The strip
// number will be used to form part of the address.
wire [17:0] strip_num = strip_num65k[31:16];
// Calculate pixel position within strip using the fractional part of the
// horizontal strip number.
wire [15:0] strip_fract = strip_num65k[15:0]+16'h7F;  // +7F to round
// Pixel beginning bit is ratio of pixel # into all bits used by pixels
wire [15:0] ndx = strip_fract[15:7] * coeff2;
assign mb_o = ndx[15:9];  // Get whole pixel position (discard fraction)
assign me_o = mb_o + bpp; // Set high order position for mask
assign ce_o = mb_o + cbpp;
// num_strips is essentially a constant value unless the screen resolution changes.
// Gain performance here by regstering the multiply so that there aren't two
// cascaded multiplies when calculating the offset.
reg [31:0] num_strips65k;
always @(posedge clk)
	num_strips65k <= bmp_width_i * coeff;
wire [15:0] num_strips = num_strips65k[31:16];

wire [31:0] offset = {(({4'b0,num_strips} * y_coord_i) + strip_num),SW==128 ? 4'h0 : SW==64 ? 3'h0 : 2'd0};

assign address_o = base_address_i + offset;

endmodule
