//dmd ../bin/libtimer.a -I../src/ stopwatch.d -of sw
import core.thread;
import std.stdio;

import timer;


void main(string[] args) {
   writeln();
   writeln("StopWatch example");
   writeln("-----------------");
   writeln();



   StopWatchTimer sw;
   sw.start();
   Thread.sleep(dur!("msecs")(200));
   writefln("elapsed %d ms", sw.elapsedMsecs);

   Thread.sleep(dur!("msecs")(150));
   sw.stop();
   writefln("elapsed %s", sw.elapsed);
   sw.reset();
   writefln("after reset elapsed %d ms", sw.elapsedMsecs);

   writeln();
   writeln("restart...");
   sw.restart();
   Thread.sleep(dur!("msecs")(150));
   writefln("After restart elapsed %d ms", sw.elapsedMsecs);
}
