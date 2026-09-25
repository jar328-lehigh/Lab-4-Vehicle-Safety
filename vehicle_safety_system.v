`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2026 11:21:42 AM
// Design Name: 
// Module Name: vehicle_safety_system
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


module vehicle_safety_system(
    input wire [15:2]SW,
    output reg [15:5]LED
    );
    
    wire SB = SW[15];
    wire DOOR = SW[14];
    wire KEY = SW[13];
    wire BRK = SW[12];
    wire PARK = SW[11];
    wire HOOD = SW[10];
    wire BAT_OK = SW[9];
    wire AIB_OK = SW[8];
    wire TMP_OK = SW[7];
    wire PASS_OCC = SW[6];
    wire SB_P = SW[5];
    wire TRUNK = SW[4];
    wire PBRK = SW[3];
    wire SRV = SW[2];
    
    always @ (SW, LED) begin
    
        // SEAT_WARN on if driver seatelt is not fastened or if there is a passenger and they aren't wearing a seatbelt
        LED [11] = KEY && ((!SB) || (PASS_OCC && !SB_P));
        
        // DOOR_WARN if driver door open
        LED[10] = !DOOR;
        
        // HOOD_WARN if hood open
        LED[9] = !HOOD;
        
        // TRUNK_WARN if trunk open
        LED[8] = !TRUNK;
        
        // BAT_WARN if BAT not ok
        LED[7] = !BAT_OK;
        
        // AIRBAG_WARN if AIB not ok
        LED[6] = !AIB_OK;
        
        // TEMP_WARN if TMP not ok
        LED[5] = !TMP_OK;
        
        // CHIME. on if key inserted with an open door, unfastened seatbelt, or parking brake engaged
        LED[14] = KEY && (!DOOR || LED[11] || PBRK);
        
        // WARN_PRI1 on if TMP not ok, AIB not ok, BAT not ok
        LED[12] = KEY && (LED[5] || LED[6] || LED[7]); 
        
        // WARN PRI2 on if PRI1 not on, door/hood/trunk open, or seat warning or pbrk engaged
        LED[13] = !LED[12] && (LED[8] || LED[9] || LED[10] || LED[11] || PBRK);
        
        //service mode when KEY, BRK, PARK, SRV
        if(SRV)
            begin
                LED[5] = 1'b0;
                LED[6] = 1'b0;
                LED[7] = 1'b0;
                
            end
        
        // START_PERMIT
        if(KEY && BRK && PARK && BAT_OK && TMP_OK)
            begin
                LED[15] = 1'b1;
            end
        else
            begin
                LED[15] = 1'b0;
            end
    
    end
endmodule
