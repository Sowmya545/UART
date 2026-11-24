
module uart_tb;
    reg clk, rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;

    wire [7:0] rx_data;
    wire rx_done;

    uart_tx tx_unit(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    uart_rx rx_unit(
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Waveform dump commands
    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_tb);
    end

    initial begin
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;
        #100;
        rst = 0;

        #100;
        tx_data = 8'hA5;
        tx_start = 1;
        #20;
        tx_start = 0;

        #10000;
        $finish;
    end

endmodule
