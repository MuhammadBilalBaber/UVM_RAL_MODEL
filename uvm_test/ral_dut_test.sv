class ral_dut_test extends uvm_test;
  `uvm_component_utils(ral_dut_test)

  ral_dut_sequence    ral_seq;
  ral_dut_environment ral_env;

  function new(string name="ral_dut_test",uvm_component parent);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   ral_env = ral_dut_environment::type_id::create("ral_env",this);
   ral_seq = ral_dut_sequence::type_id::create("ral_seq",this);
   // ral_seq.regmodel = ral_env.regmodel;
  endfunction : build_phase

   virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
     `uvm_info(get_type_name(),$sformatf("Run phase Started"),UVM_HIGH);
     ral_seq.start(ral_env.ral_dut_agnt.ral_dut_seqr);
     `uvm_info(get_type_name(),$sformatf("Run phase Ended"),UVM_HIGH);
    phase.drop_objection(this);
   endtask : run_phase

endclass: ral_dut_test