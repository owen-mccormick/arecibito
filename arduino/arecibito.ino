// Stepper code based on https://forum.arduino.cc/t/simple-stepper-program/268292

byte directionPinA = 5;
byte stepPinA = 2;
byte directionPinB = 7;
byte stepPinB = 4;
int xNumSteps = 400;
int yNumSteps = 600;
byte onPin = 8;
int pulseWidthMicros = 20;
int millisbetweenSteps = 5;
int analogSignalPin = A1;
double xCoord = 0.5;
double yCoord = 0.5;
bool leftToRight = true;
int numToAverage = 100;
int measuredPositions = 0;

enum StepType {
  LEFT,
  RIGHT,
  // Unused
  //UP,
  DOWN
};

void setup() {
  Serial.begin(9600);
  pinMode(onPin, OUTPUT);
  pinMode(stepPinA, OUTPUT);
  pinMode(stepPinB, OUTPUT);
  pinMode(directionPinA, OUTPUT);
  pinMode(directionPinB, OUTPUT);
  pinMode(analogSignalPin, INPUT);
  // enable steppers
  digitalWrite(onPin, LOW);
}

void step(StepType type) {
  switch (type) {
    case LEFT:
      digitalWrite(directionPinA, LOW);
      for (int n = 0; n < xNumSteps; n++) {
        digitalWrite(stepPinA, HIGH);
        delayMicroseconds(pulseWidthMicros);
        digitalWrite(stepPinA, LOW);
        delay(millisbetweenSteps);
      }
      break;
    case RIGHT:
      digitalWrite(directionPinA, HIGH);
      for (int n = 0; n < xNumSteps; n++) {
        digitalWrite(stepPinA, HIGH);
        delayMicroseconds(pulseWidthMicros);
        digitalWrite(stepPinA, LOW);
        delay(millisbetweenSteps);
      }
      break;
    case DOWN:
      digitalWrite(directionPinB, HIGH);
      for (int n = 0; n < yNumSteps; n++) {
        digitalWrite(stepPinB, HIGH);
        delayMicroseconds(pulseWidthMicros);
        digitalWrite(stepPinB, LOW);
        delay(millisbetweenSteps);
      }
      break;
  }
}

void loop() {
  if (measuredPositions < 100) {
    int valsToAverage[numToAverage] = {};
    for (int i = 0; i < numToAverage; i++) {
      valsToAverage[i] = analogRead(analogSignalPin);
      delay(50);
    }
    int data = valsToAverage[0];
    for (int i = 1; i < numToAverage; i++) {
      data += valsToAverage[i];
    }
    data /= numToAverage;
    Serial.write(byte(data * 255 / 1024));
    if (leftToRight) {
      if (xCoord > 9) {
        leftToRight = false;
        yCoord++;
        step(StepType::DOWN);
      } else {
        xCoord++;
        step(StepType::RIGHT);
      }
    } else {
      if (xCoord < 1) {
        leftToRight = true;
        yCoord++;
        step(StepType::DOWN);
      } else {
        xCoord--;
        step(StepType::LEFT);
      }
    }
    measuredPositions++;
  }
}
