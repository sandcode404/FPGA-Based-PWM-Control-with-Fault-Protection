module top (
    (* iopad_external_pin, clkbuf_inhibit *)
    input clk,
    (* iopad_external_pin *)
    output clk_en,
    (* iopad_external_pin *)
    input duty_sel0,
    (* iopad_external_pin *)
    input duty_sel1,
    (* iopad_external_pin *)
    input fault_in,
    (* iopad_external_pin *)
    input reset,

    // GPIO outputs
    (* iopad_external_pin *)
    output pwm_out,
    (* iopad_external_pin *)
    output fault_led
);

    wire [1:0] duty_sel;
    wire pwm_generated;

    assign clk_en = 1'b1;

    assign duty_sel[0] = duty_sel0;
    assign duty_sel[1] = duty_sel1;

    // PWM controller
    pwm_controller pwm_unit (
        .clk      (clk),
        .reset    (reset),
        .duty_sel (duty_sel),
        .pwm      (pwm_generated)
    );

    // Fault protection
    fault_protection protection_unit (
        .pwm_in    (pwm_generated),
        .fault_in  (fault_in),
        .pwm_out   (pwm_out),
        .fault_led (fault_led)
    );

endmodule
