class ral_dut_driver extends uvm_driver#(ral_dut_sequence_item);
  `uvm_component_utils(ral_dut_driver)

  ral_dut_sequence_item req;
  virtual ral_dut_if ral_dut_if;

  function new(string name="ral_dut_driver", uvm_component parent= null);
    super.new(name, parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   req = ral_dut_sequence_item::type_id::create("req");
   if(!uvm_config_db#(virtual ral_dut_if)::get(this, "*", "ral_dut_if", ral_dut_if)) begin
     `uvm_fatal(get_type_name(),"Didn't get the interface instance in driver class");
   end
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    wait(!ral_dut_if.reset);
    forever begin
      seq_item_port.get_next_item(req);
        drive_trans();
      seq_item_port.item_done();
    end
  endtask : run_phase

  task drive_trans();
    if(req.wr_en) begin
      ral_dut_if.wr_en   <= req.wr_en;
      ral_dut_if.rd_en   <= 1'b0;
      ral_dut_if.data_in <= req.data_in;
      ral_dut_if.addr    <= req.addr;
      @(posedge ral_dut_if.clk);
    end
    else if((req.rd_en))  begin
      ral_dut_if.wr_en   <= 1'b0;
      ral_dut_if.rd_en   <= req.rd_en;
      ral_dut_if.addr    <= req.addr;
      ral_dut_if.data_in <= 0;
      @(posedge ral_dut_if.clk);
      @(posedge ral_dut_if.clk);
      req.data_out       = ral_dut_if.data_out;
      // @(posedge ral_dut_if.clk);
    end


  endtask : drive_trans


endclass: ral_dut_driver