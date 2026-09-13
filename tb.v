`timescale 1ns/1ps

module tb;

    reg        clk;
    reg        reset;
    reg [1:0]  duty_sel;
    reg        fault_in;

    wire       pwm_out;
    wire       fault_led;

    top dut (
        .clk       (clk),
        .duty_sel0 (duty_sel[0]),
        .duty_sel1 (duty_sel[1]),
        .fault_in  (fault_in),
        .reset     (reset),
        .pwm_out   (pwm_out),
        .fault_led (fault_led)
    );

    always #5 clk = ~clk;

    initial begin
        clk      = 0;
        reset    = 1;
        duty_sel = 2'b00;
        fault_in = 0;

        #20;
        reset = 0;

        duty_sel = 2'b00;
        #2560;

        duty_sel = 2'b01;
        #2560;

        duty_sel = 2'b10;
        #2560;

        duty_sel = 2'b11;
        #2560;

        fault_in = 1;
        #100;

        fault_in = 0;
        #100;

        reset = 1;
        #50;

        reset = 0;
        #100;

        $finish;
    end

endmodule
