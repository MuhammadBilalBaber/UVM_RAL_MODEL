`include "uvm_macros.svh"
import uvm_pkg::*;
module ral_dut_tb_top;

  bit clk;
  bit reset;

  // Initialize clock
  initial clk = 0;
  always #5 clk = ~clk;

  ral_dut_if ral_dut_if();

  ral_dut  ral_dut(
    .clk     (ral_dut_if.clk),
    .reset   (ral_dut_if.reset),
    .addr    (ral_dut_if.addr),
    .rd_en   (ral_dut_if.rd_en),
    .wr_en   (ral_dut_if.wr_en),
    .data_in (ral_dut_if.data_in),
    .data_out(ral_dut_if.data_out)
    );

    assign ral_dut_if.clk   = clk;
    assign ral_dut_if.reset = reset;


  initial begin
    reset = 1'b1;
    repeat(2) begin
      @(posedge clk);
    end
    reset = 1'b0;
  end

  initial begin
    uvm_config_db#(virtual ral_dut_if)::set(null,"uvm_test_top.*","ral_dut_if",ral_dut_if);
    run_test("ral_dut_test");
  end

  initial begin
    #10000;
  end





endmodule : ral_dut_tb_top