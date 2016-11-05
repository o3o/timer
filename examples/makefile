all: c s
	./c
	./s

c: countdown.d
	dmd ../bin/libtimer.a -I../src/ countdown.d -ofc

s: stopwatch.d
	dmd ../bin/libtimer.a -I../src/ stopwatch.d -ofs

clean:
	-rm -f *.o
	-rm -f s
	-rm -f c
