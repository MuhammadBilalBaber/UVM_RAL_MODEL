class ral_dut_monitor extends uvm_monitor;
  `uvm_component_utils(ral_dut_monitor)

  virtual ral_dut_if ral_dut_if;
  ral_dut_sequence_item req;


  function new(string name = "ral_dut_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   req = ral_dut_sequence_item::type_id::create("req");
   if(!uvm_config_db#(virtual ral_dut_if)::get(this,"*","ral_dut_if",ral_dut_if)) begin
     `uvm_fatal(get_type_name(),"didn't get the interface instance in the monitor class");
   end
  endfunction : build_phase 

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    wait(!ral_dut_if.reset);
    forever begin
      monitor_trans();
    end
  endtask : run_phase 

  task monitor_trans();
    @(posedge ral_dut_if.clk); 
    req.addr     = ral_dut_if.addr    ;
    req.wr_en    = ral_dut_if.wr_en   ;
    req.rd_en    = ral_dut_if.rd_en   ;
    req.data_in  = ral_dut_if.data_in ;
    req.data_out = ral_dut_if.data_out;
    if(ral_dut_if.rd_en) begin
      @(posedge ral_dut_if.clk); 
    end 
     `uvm_info(get_type_name(),$sformatf("The  is addr     %0h",ral_dut_if.addr    ),UVM_LOW);
     `uvm_info(get_type_name(),$sformatf("The  is wr_en    %0h",ral_dut_if.wr_en   ),UVM_LOW);
     `uvm_info(get_type_name(),$sformatf("The  is rd_en    %0h",ral_dut_if.rd_en   ),UVM_LOW);
     `uvm_info(get_type_name(),$sformatf("The  is data_in  %0h",ral_dut_if.data_in ),UVM_LOW);
     `uvm_info(get_type_name(),$sformatf("The  is data_out %0h",ral_dut_if.data_out),UVM_LOW);


  endtask : monitor_trans


endclass: ral_dut_monitor