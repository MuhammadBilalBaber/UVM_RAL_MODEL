module ral_dut(
  input               clk,     // clock 
  input               reset,   // reset active high 
  input               rd_en,   // when high read will be perform
  input               wr_en,   // when high write will be done
  input [32-1:0]       addr,    // address to write
  input [32-1:0]      data_in, // data to be write 
  output reg [32-1:0] data_out // data to be out
  );

  reg [31:0] data_reg1;
  reg [31:0] data_reg2;
  reg [31:0] data_reg3;
  reg [31:0] data_reg4;

  always @(posedge clk) begin
    if(reset) begin
      data_reg1 <= 32'h0;
      data_reg2 <= 32'h0;
      data_reg3 <= 32'h0;
      data_reg4 <= 32'h0;
      data_out  <= 32'h0;
    end
  end

  always @(posedge clk) begin
    if(!reset) begin
      if(wr_en && !rd_en) begin
        case(addr)
          32'h00: data_reg1 <= data_in;
          32'h04: data_reg2 <= data_in;
          32'h08: data_reg3 <= data_in;
          32'h0c: data_reg4 <= data_in;
        endcase // addr
      end
    end
  end

  always @(posedge clk) begin
    if(!reset) begin
      if(!wr_en && rd_en) begin
        case(addr)
          32'h00: data_out <= data_reg1;
          32'h04: data_out <= data_reg2;
          32'h08: data_out <= data_reg3;
          32'h0c: data_out <= data_reg4;
        endcase // addr
      end
    end
  end


endmodule: ral_dut