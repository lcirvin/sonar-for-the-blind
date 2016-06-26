import rangefinder
import audible_signal
from multiprocessing import Process, Value

def main():
	distance = Value('d', 0.0)

	p = Process(target=rangefinder.start_rangefinding,args=(distance,))
	m = Process(target=audible_signal.init_audio,args=(distance,))
	p.start()
	m.start()
	p.join()
	m.join()


if __name__ == '__main__':
	main()

