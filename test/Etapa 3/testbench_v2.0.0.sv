module tb;
  logic [2:0] Sensores;
  logic [1:0] Mot1,Mot2;
  logic SS;
  logic clk;
  logic rst;
  logic LEDSS;
  logic LEDrst;
  
  Carrito uut(Sensores,Mot1,Mot2,SS,clk,rst,LEDSS,LEDrst);
  
  initial begin
    $monitor("t=%0d Sensores=%b Mot1=%b Mot2=%b SS=%b clk=%b rst=%b LEDSS=%b LEDrst=%b", $time,Sensores,Mot1,Mot2,SS,clk,rst,LEDSS,LEDrst);
    
    Sensores=3'b000;  SS=1'b0;      //Pruebas con Señal de salida apagada
    #10 Sensores=3'b001;
    #10 Sensores=3'b010;
    #10 Sensores=3'b100;
    #10 Sensores=3'b111;
    
    #10 SS=1'b1;                     //Pruebas con señal de salida prendida
    #10 Sensores=3'b001;
    #10 Sensores=3'b010;
    #10 SS=1'b0;                     //Prueba de señal de salida
    #10 Sensores=3'b100;
    #10 Sensores=3'b111;
    
    #10 $finish;
  end
  
  initial begin
    $dumpfile("wave,vcd");
    $dumpvars(0,tb);
  end
endmodule
