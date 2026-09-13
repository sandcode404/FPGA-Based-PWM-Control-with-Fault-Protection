module fault_protection (
    input  pwm_in,
    input  fault_in,

    output pwm_out,
    output fault_led
);
    // Disable PWM whenever fault is active
    assign pwm_out = pwm_in & ~fault_in;
    assign fault_led = fault_in;

endmodule
