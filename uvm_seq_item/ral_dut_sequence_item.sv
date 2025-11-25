class ral_dut_sequence_item extends uvm_sequence_item;


  rand logic                rd_en;    // when high read will be perform
  rand logic                wr_en;    // when high write will be done
  rand logic  [32-1:0]      addr;     // address to write
  rand logic  [32-1:0]      data_in;  // data to be write 
  logic [32-1:0]            data_out; // data to be out

   `uvm_object_utils_begin(ral_dut_sequence_item)
     `uvm_field_int(rd_en,UVM_ALL_ON)
     `uvm_field_int(wr_en,UVM_ALL_ON)
     `uvm_field_int(addr,UVM_ALL_ON)
     `uvm_field_int(data_in,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name="ral_dut_sequence_item");
     super.new(name);
   endfunction : new


endclass:ral_dut_sequence_item

