class data_reg2 extends uvm_reg;
  `uvm_object_utils(data_reg2)

  rand uvm_reg_field data;  // filed of the register

  function new(string name = "data_reg2");
    super.new(name,32,UVM_NO_COVERAGE);  // 32 is the size of the register
  endfunction : new

  function void build;
   // create the register field
   data = uvm_reg_field::type_id::create("data");
   //configure
   // data.configure(.parent(this),.size(32),.lsb_pos(0),
   //                .access("RW"),.volatile(0),
   //                .reset(0),.has_reset(1),.is_rand(1),
   //                .individual_accessible(0));
   data.configure(this,32,0,"RW",0,0,1,1,0);
   
  endfunction : build


endclass: data_reg2