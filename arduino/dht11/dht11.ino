// Importação da Biblioteca do Sensor DHT11
#include "DHT.h"
#define dht_type DHT11

// Declaração das Variáveis 
int dht_pin = A0;
DHT dht_1 = DHT(dht_pin, dht_type);

// Configuração do Dispositivo
void setup() {
  Serial.begin(9600); // Inicialização do Monitor Serial
  dht_1.begin();  // Inicialização do Sensor DHT11
}

// Algoritmo para a Captura de Dados de Temperatura e Umidade
void loop() {
  // Variáveis com Cálculo de Temperatura e Umidade Adaptadas para o Ambiente
  float umidade = dht_1.readHumidity() + 20;
  float temperatura = dht_1.readTemperature() - 7;
  
  // Verifica se a Temperatura e a Umidade não são números
  if(isnan(temperatura) or isnan(umidade)){
    Serial.println("Erro ao ler"); 
  } 
  else {
    // Exbição dos Dados
    Serial.print(umidade);
    Serial.print(" ; ");
    Serial.println(temperatura);
  }
  delay(1500); // Intervalo de Captura em Milisegundos
}
