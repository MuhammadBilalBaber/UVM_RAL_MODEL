class ral_dut_environment extends uvm_env;
  `uvm_component_utils(ral_dut_environment)

  ral_dut_agent   ral_dut_agnt;
  reg2bus_adapter reg2bus_adaptr;
  register_block  regmodel;

  function new(string name= "ral_dut_environment", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ral_dut_agnt   = ral_dut_agent::type_id::create("ral_dut_agnt",this);
    regmodel = new("regmodel");
    regmodel.build();
    reg2bus_adaptr = reg2bus_adapter::type_id::create("reg2bus_adaptr",this);

    uvm_config_db #(register_block)::set(null, "*", "regmodel", regmodel);



  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
   regmodel.default_map.set_sequencer(ral_dut_agnt.ral_dut_seqr,.adapter(reg2bus_adaptr));
   regmodel.default_map.set_auto_predict(1);
   // base address

  endfunction : connect_phase


endclass: ral_dut_environment