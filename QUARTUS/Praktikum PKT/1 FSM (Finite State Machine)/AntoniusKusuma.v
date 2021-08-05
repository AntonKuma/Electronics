// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// Generated by Quartus Prime Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition
// Created on Thu May 14 18:12:43 2020

// synthesis message_off 10175

`timescale 1ns/1ns

module AntoniusKusuma (
    reset,clock,push,
    led);

    input reset;
    input clock;
    input push;
    tri0 reset;
    tri0 push;
    output led;
    reg led;
    reg [3:0] fstate;
    reg [3:0] reg_fstate;
    parameter state1=0,state2=1,state3=2,state4=3;

    always @(posedge clock)
    begin
        if (clock) begin
            fstate <= reg_fstate;
        end
    end

    always @(fstate or reset or push)
    begin
        if (reset) begin
            reg_fstate <= state1;
            led <= 1'b0;
        end
        else begin
            led <= 1'b0;
            case (fstate)
                state1: begin
                    if (~(push))
                        reg_fstate <= state1;
                    else if (push)
                        reg_fstate <= state4;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= state1;

                    led <= 1'b0;
                end
                state2: begin
                    if (push)
                        reg_fstate <= state2;
                    else if (~(push))
                        reg_fstate <= state1;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= state2;

                    led <= 1'b0;
                end
                state3: begin
                    if (~(push))
                        reg_fstate <= state3;
                    else if (push)
                        reg_fstate <= state2;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= state3;

                    led <= 1'b1;
                end
                state4: begin
                    if (push)
                        reg_fstate <= state4;
                    else if (~(push))
                        reg_fstate <= state3;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= state4;

                    led <= 1'b1;
                end
                default: begin
                    led <= 1'bx;
                    $display ("Reach undefined state");
                end
            endcase
        end
    end
endmodule // AntoniusKusuma