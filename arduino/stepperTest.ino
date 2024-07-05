// Adapted from https://forum.arduino.cc/t/simple-stepper-program/268292
// Runs a stepper through the Synthetos gShield

byte directionPin = 5;
byte stepPin = 2;
int numberOfSteps = 200 * 8;
byte onPin = 8;
int pulseWidthMicros = 20;
int millisbetweenSteps = 5;


void setup() { 

  Serial.begin(9600);
  Serial.println("Starting StepperTest");
  
  delay(2000);

  pinMode(directionPin, OUTPUT);
  pinMode(stepPin, OUTPUT);
  pinMode(onPin, OUTPUT);

  digitalWrite(onPin, LOW);
  
 
  digitalWrite(directionPin, HIGH);
  for(int n = 0; n < numberOfSteps; n++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(pulseWidthMicros);
    digitalWrite(stepPin, LOW);
    
    delay(millisbetweenSteps);
  }
  
  delay(3000);
  

  digitalWrite(directionPin, LOW);
  for(int n = 0; n < numberOfSteps; n++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(pulseWidthMicros); // probably not needed
    digitalWrite(stepPin, LOW);
    
    delay(millisbetweenSteps);
  }
}

void loop() {}

