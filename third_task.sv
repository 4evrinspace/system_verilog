module RotateRightShiftTest;

  logic clk, reset, shift, load;
  logic [7:0] data_in;
  logic [7:0] data_out;
  
  //Подключим модуль, который нужно протестировать
  //Пусть он называется leftShift
  RotateRightShift to_test(.clk(clk), .reset(reset), .shift(shift), .load(load), .data_in(data_in), .data_out(data_out))

 
  
  // Такты
  always begin
    #5 clk = ~clk;
  end

  initial begin
    

    clk = 0;
    shift = 0;
    load = 0;
    data_in = 8'b00000000;
    
    reset = 1;
    #10 reset = 0;
    //Сбросили значения

    
    data_in = 8'b10101010; 
    load = 1;
    #10 load = 0; 
    //Давайте проверим значение без сдвига
    
    assert(data_out == 8'b10101010) else $error("Load failed!");
    
    // Активация режима сдвига вправо
    shift = 1;
    
    //Проверяем в цикле
    for (int i = 0; i < 8; i++) begin
        #10
        assert(data_in[7 - i] == data_out[7]) else $error("Error in i = %d", i);
        //data_in[7 - i] - бит ,который на данном такте был самым правым
        //data_out[7] - бит ,который пришел после циклического сдвига вправо
    
    assert(data_out == 8'b10101010) else $error("Error in the end number");
    
    
    $display("Everything is ok!");
    $stop;
  end
  
endmodule