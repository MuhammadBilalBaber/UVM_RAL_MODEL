class reg2bus_adapter extends uvm_reg_adapter;
  `uvm_object_utils(reg2bus_adapter);

  function new(string name = "reg2bus_adapter");
   super.new(name);
  endfunction : new

  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
   ral_dut_sequence_item ral_item = ral_dut_sequence_item::type_id::create("ral_item");
   // ral_item.wr_en   = (rw.kind == UVM_WRITE) ? 1 : 0;
   if (rw.kind == UVM_WRITE) begin
      ral_item.wr_en = 1;
      ral_item.rd_en = 0;
   end else begin
      ral_item.wr_en = 0;
      ral_item.rd_en = 1;
   end
   ral_item.addr    = rw.addr;
   ral_item.data_in = rw.data;
   `uvm_info(get_type_name(), $sformatf("The operation is WRITE wr_en is %0d rd_en %0d , addr is %0d, data_write is %0d",ral_item.wr_en, ral_item.rd_en, ral_item.addr, rw.data), UVM_HIGH);
   return ral_item;

  endfunction

  virtual function void bus2reg(uvm_sequence_item ral_item,ref uvm_reg_bus_op rw);
    ral_dut_sequence_item item;
    if(!$cast(item,ral_item)) begin
      `uvm_fatal(get_type_name(), $sformatf("Type not same"))
    end
    // rw.kind = (item.wr_en == 0) ? UVM_READ : UVM_WRITE;
    rw.kind = (item.rd_en == 1) ? UVM_READ : UVM_WRITE;
    item.rd_en = 1;
    rw.data = item.data_out;
    item.data_out = rw.data;
    rw.status = UVM_IS_OK;
  endfunction : bus2reg


endclass: reg2bus_adapter
