class ral_dut_sequence extends uvm_sequence;
  `uvm_object_utils(ral_dut_sequence)

  register_block regmodel;
    reg [31:0] data;
    uvm_status_e status;

  function new(string name = "ral_dut_sequence");
    super.new(name);
  endfunction : new

  task body();

     if(!uvm_config_db#(register_block)::get(get_sequencer(), "", "regmodel", regmodel))
        `uvm_info(get_type_name(), "did not get regmodel reg model", UVM_LOW)
    `uvm_info(get_type_name(),"Initializing regmodel master",UVM_LOW);


    regmodel.reg1.write(status,32'h0000_1234);
    regmodel.reg2.write(status,32'h0000_5678);
    regmodel.reg3.write(status,32'h0000_9abc);
    regmodel.reg4.write(status,32'h0000_def6);

    regmodel.reg1.read(status,data);
        `uvm_info(get_type_name(), $sformatf("The value of the reg1 is %0h",data), UVM_LOW)
    regmodel.reg2.read(status,data);
        `uvm_info(get_type_name(), $sformatf("The value of the reg2 is %0h",data), UVM_LOW)
    regmodel.reg3.read(status,data);
        `uvm_info(get_type_name(), $sformatf("The value of the reg3 is %0h",data), UVM_LOW)
    regmodel.reg4.read(status,data);
        `uvm_info(get_type_name(), $sformatf("The value of the reg4 is %0h",data), UVM_LOW)



  endtask : body



endclass: ral_dut_sequence