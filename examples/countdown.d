//dmd ../bin/libtimer.a -I../src/ countdown.d -of c
import core.thread;
import std.stdio;

import timer;

void main(string[] args) {
   writeln();
   writeln("Countdown example");
   writeln("-----------------");
   writeln();
   writeln("\tms example");

   Countdown countms;
   countms.start(200);
   while (!countms.isOver) {
      Thread.sleep(dur!("msecs")(10));
      writefln("elapsed %7.3f ms remaining %7.3f ms", countms.elapsedTime, countms.remainingTime);
   }

   writeln();
   writeln("\tsec example");
   CountdownSec counts;
   counts.start(1.5); // 1.5 seconds
   while (!counts.isOver) {
      Thread.sleep(dur!("msecs")(100));
      writefln("elapsed %7.3f s remaining %7.3f s", counts.elapsedTime, counts.remainingTime);
   }

}
