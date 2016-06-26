import RPi.GPIO as GPIO
import time

def start_rangefinding(distance):
	GPIO.setmode(GPIO.BCM)

	TRIG = 23
	ECHO = 24

	GPIO.setup(TRIG,GPIO.OUT)
	GPIO.setup(ECHO,GPIO.IN)

	GPIO.output(TRIG, True)
	time.sleep(2)
	GPIO.output(TRIG, False)
	time.sleep(2)

	while True:
		GPIO.output(TRIG,True)
		GPIO.output(TRIG, False)

		original_pulse = time.time()

		while GPIO.input(ECHO)==0:
			pulse_start = time.time()
		while GPIO.input(ECHO)==1:
			pulse_end = time.time()


		pulse_duration = pulse_end - pulse_start

		distance.value = pulse_duration * 17150

		distance.value = round(distance.value, 2)

		time.sleep(0.2)
	#print "Distance:",distance,"cm"

	GPIO.cleanup()
