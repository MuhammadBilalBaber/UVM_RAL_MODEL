class ral_dut_sequencer extends uvm_sequencer#(ral_dut_sequence_item);
  `uvm_component_utils(ral_dut_sequencer)

  function new(string name = "ral_dut_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction : new

endclass : ral_dut_sequencer