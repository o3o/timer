[![Dub version](https://img.shields.io/dub/v/timer.svg)](https://code.dlang.org/packages/timer)
[![Build Status](https://travis-ci.org/o3o/timer.svg?branch=master)](https://travis-ci.org/o3o/timer)
[![Dub download Status](https://img.shields.io/dub/dt/timer.svg)](https://code.dlang.org/packages/timer)


# timer
A simple D implementation of countdown and stopwatch timer


## Usage

### StopWatch
```
import core.thread;
import std.stdio;

import timer;

void main(string[] args) {
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
```

### CountdownTimer

```
import core.thread;
import std.stdio;

import timer;

void main(string[] args) {
   Countdown countms;
   countms.start(200);
   while (!countms.isOver) {
      Thread.sleep(dur!("msecs")(10));
      writefln("elapsed %7.3f ms remaining %7.3f ms", countms.elapsedTime, countms.remainingTime);
   }
}
```

see also [examples]()xamples/) directory.

## Libraries
* [unit-threaded](https://github.com/atilaneves/unit-threaded.git)

## License
Distributed under the Boost Software License, Version 1.0.
See copy at http://www.boost.org/LICENSE_1_0.txt.
