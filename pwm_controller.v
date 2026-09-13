module pwm_controller (
    input        clk,
    input        reset,
    input  [1:0]  duty_sel,
    output       pwm
);

    reg [7:0] counter;
    reg [7:0] duty_value;

    // Duty-cycle selection
    always @(*) begin
        case (duty_sel)
            2'b00: duty_value = 8'd64;    // 25%
            2'b01: duty_value = 8'd128;   // 50%
            2'b10: duty_value = 8'd192;   // 75%
            2'b11: duty_value = 8'd255;   // ~100%
            default: duty_value = 8'd64;
        endcase
    end

    // PWM counter
    always @(posedge clk) begin
        if (reset)
            counter <= 8'd0;
        else
            counter <= counter + 1'b1;
    end

    // PWM generation
    assign pwm = (counter < duty_value);

endmodule
