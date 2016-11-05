//dmd ../bin/libtimer.a -I../src/ countdown.d -of c
import core.thread;
import std.stdio;

import timer;


void main(string[] args) {
   writeln();
   writeln("Countdown example");
   writeln("-----------------");
   writeln();

   Countdown countms;
   countms.start(200);
   while (!countms.isOver) {
      Thread.sleep(dur!("msecs")(10));
      writefln("elapsed %7.3f ms remaining %7.3f ms", countms.elapsedTime, countms.remainingTime);
   }
}
