import math
import pyaudio
import time

PyAudio = pyaudio.PyAudio

def init_audio(distance):
	BITRATE = 16000

	#FREQUENCY = 261.63
	FREQUENCY = 580 
	LENGTH = 0.250

	MULTIPLIER = 50

	NUMBEROFFRAMES = int(BITRATE * LENGTH)
	RESTFRAMES = NUMBEROFFRAMES % BITRATE
	WAVEDATA = ''

	for x in xrange(NUMBEROFFRAMES):
		WAVEDATA = WAVEDATA + chr(int(math.sin(x/((BITRATE/FREQUENCY)/math.pi))*127+128))

	for x in xrange(RESTFRAMES):
		WAVEDATA = WAVEDATA+chr(128)

	p = PyAudio()

	stream = p.open(format = p.get_format_from_width(1), channels = 1, rate = BITRATE, output = True)
	last_pulse = time.time()	
	while True:
		
		current_time = time.time() 
		if (current_time - last_pulse) > (distance.value/200)+0.5 and distance.value != 0.0:	
			stream.write(WAVEDATA)
			last_pulse = current_time
		
	stream.stop_stream()
	stream.close()
	p.terminate()


