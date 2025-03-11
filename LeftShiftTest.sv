module LeftShiftTest;

  logic clk, reset, shift, load;
  logic [7:0] data_in;
  logic [7:0] data_out;
  
  //Подключим модуль, который нужно протестировать
  //Пусть он называется LeftShift
  LeftShift to_test(.clk(clk), .reset(reset), .shift(shift), .load(load), .data_in(data_in), .data_out(data_out))

 
  
  // Такты
  always begin
    #5 clk = ~clk;
  end

  initial begin
    

    clk = 0;
    shift = 0;
    load = 0;
    data_in = 8'b11111111;
    
    reset = 1;
    #10 reset = 0;
    //Сбросили значения

    
    data_in = 8'b01100101; 
    load = 1;
    #10 load = 0; 
    //Давайте проверим значение без сдвига
    
    assert(data_out == 8'b01100101) else $error("Load failed!");
    
    // Активация режима сдвига влево
    shift = 1;
    
    // Сделаем такт
    #10; 
    assert(data_out == 8'b11001010) else $error("Shift failed!");
    
    $display("Everything is ok!");
    $stop;
  end
  
endmodule