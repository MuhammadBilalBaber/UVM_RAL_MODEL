class ral_dut_agent extends uvm_agent;
  `uvm_component_utils(ral_dut_agent)

  ral_dut_sequencer ral_dut_seqr;
  ral_dut_monitor   ral_dut_mon;
  ral_dut_driver    ral_dut_drv;

  function new(string name = "ral_dut_agent", uvm_component parent);
    super.new(name , parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ral_dut_seqr  = ral_dut_sequencer::type_id::create("ral_dut_seqr",this);
    ral_dut_mon   = ral_dut_monitor::type_id::create("ral_dut_mon",this);
    ral_dut_drv   = ral_dut_driver::type_id::create("ral_dut_drv",this);
  endfunction : build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ral_dut_drv.seq_item_port.connect(ral_dut_seqr.seq_item_export);
  endfunction : connect_phase




endclass: ral_dut_agent