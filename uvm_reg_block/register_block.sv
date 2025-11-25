class register_block extends uvm_reg_block;

  `uvm_object_utils(register_block)

  rand data_reg1 reg1;
  rand data_reg2 reg2;
  rand data_reg3 reg3 ;
  rand data_reg4 reg4;

  uvm_reg_map rmap;

  // build function
  // create each register
  // configure each register

  function new(string name = "register_block");
    super.new(name);
  endfunction : new

  virtual function void build();
   // craete register
   reg1 = data_reg1::type_id::create("reg1");
   //  call the build method
   reg1.build();
   // configure register
   reg1.configure(this);

   reg2 = data_reg2::type_id::create("reg2");
   //  call the build method
   reg2.build();
   // configure register
   reg2.configure(this);

   reg3 = data_reg3::type_id::create("reg3");
   //  call the build method
   reg3.build();
   // configure register
   reg3.configure(this);

   reg4 = data_reg4::type_id::create("reg4");
   //  call the build method
   reg4.build();
   // configure register
   reg4.configure(this);


   // craete the map address
   // Base Address = 'h00
   // Increment = 4 
   rmap = create_map("rmap", 'h00,4,UVM_LITTLE_ENDIAN);
   // set the current map to the default map
   default_map = rmap;
   // add register to the address map
   // name of reg = reg1
   // adress offset = 'h0
   // accessibilty = read/write
   rmap.add_reg(reg1,'h0,"RW");
   rmap.add_reg(reg2,'h4,"RW");
   rmap.add_reg(reg3,'h8,"RW");
   rmap.add_reg(reg4,'hc,"RW");
   // lock model
   lock_model();

  endfunction

endclass: register_block

