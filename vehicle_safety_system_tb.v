`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2026 10:48:43 AM
// Design Name: 
// Module Name: vehicle_safety_system_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vehicle_safety_system_tb;

    reg  [15:2] SW;
    wire [15:5] LED;

    vehicle_safety_system uut (
        .SW(SW),
        .LED(LED)
    );
        
    initial begin
    
        SW = 14'b01001111100110;
        #20;
 
        SW[13] = 1'b1; // KEY = 1
        #20;
      
        SW[15] = 1'b1; // SB = 1
        SW[3]  = 1'b0; // PBRK = 0
        SW[12] = 1'b1; // BRK = 1
        #20;
     
        SW[10] = 1'b0; // HOOD = 0
        #20;
    
        SW[9] = 1'b0; // BAT_OK = 0
        #20;
    
        SW[9]  = 1'b1; // BAT_OK = 1
        SW[10] = 1'b1; // HOOD = 1
        SW[6]  = 1'b1; // PASS_OCC = 1
        SW[5]  = 1'b0; // SB_P = 0
        #20;
      
        #50;
        $finish;
    end

endmodule
