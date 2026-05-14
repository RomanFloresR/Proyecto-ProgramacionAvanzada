module Carrito (
  input [2:0] Sensores;          //Input para 3 sensores digitales
  input SS;                      //Input para señal de encendido
  input clk;
  input rst;
  output wire LEDSS;                   //LED para comprobar logica de SS
  output wire LEDrst;                  //LED para comprobar logica de rst
  output reg [1:0] Mot1;
  output reg [1:0] Mot2;         //Outputs para shiled LD27
);
  
reg Bandera;           // Flag para señal de inicio
reg [24:0] contador;   // Contador para 1 segundo (27,000,000 cabe en 25 bits)
reg en_reversa;        // Flag par ver si esta en acción de reversa 
assign LEDrst = !rst;
assign LEDSS = Bandera;

// --- LÓGICA DE CONTROL Y TIEMPO ---
    always_comb(posedge clk or negedge rst) begin
        if (!rst) begin
            Bandera <= 1'b0;
            en_reversa <= 1'b0;
            contador <= 0;
        end else begin
            // 1. Control de Encendido
            if (!SS) Bandera <= 1'b1;                   //Cambiar logica al usar sensor en vez de boton
            // 2. Lógica de Reversa de 1 segundo
            if (Bandera) begin
                if (!en_reversa) begin
                    // Si los sensores detectan (000), activar reversa
                    if (Sensores == 3'b000) begin
                        en_reversa <= 1'b1;
                        contador <= 0;
                    end
                end else begin
                    // Si ya estamos en reversa, contar hasta 1 segundo (27,000,000 ciclos)
                    if (contador < 27_000_000) begin
                        contador <= contador + 1;
                    end else begin
                        en_reversa <= 1'b0; // Termina el segundo, vuelve a normal
                    end
                end
            end
        end
    end

//---Logica de Motores----  
always_comb(*) begin
        if (!Bandera) begin               //Si Bandera=0 poner los motores en apagado
            Mot1 = 2'b00; Mot2 = 2'b00;
        end else if (en_reversa) begin
            // Acción de reversa
            Mot1 = 2'b01; 
            Mot2 = 2'b01;
        end else begin
            // Lógica de los sensores
            case (Sensores)
                3'b001: begin Mot1 = 2'b10; Mot2 = 2'b01; end // Derecha
                3'b010: begin Mot1 = 2'b10; Mot2 = 2'b10; end // Adelante
                3'b100: begin Mot1 = 2'b01; Mot2 = 2'b10; end // Izquierda
                default: begin Mot1 = 2'b10; Mot2 = 2'b10; end // Por defecto adelante
            endcase
        end
    end

endmodule
