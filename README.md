[![Dub version](https://img.shields.io/dub/v/timer.svg)](https://code.dlang.org/packages/timer)
[![Build Status](https://travis-ci.org/o3o/timer.svg?branch=master)](https://travis-ci.org/o3o/timer)
[![Dub download Status](https://img.shields.io/dub/dt/timer.svg)](https://code.dlang.org/packages/timer)


# timer
A simple D implementation of countdown and stopwatch timer


## Usage

### StopWatchTimer
```
import core.thread;
import std.stdio;

import timer;

void main(string[] args) {
   StopWatchTimer sw;
   sw.start();
   Thread.sleep(dur!("msecs")(200));
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

Examples can be found in the  [examples](./examples/) directory, and ran with `dub run timer:stopwatch` or `dub run timer:countdown` or finally with make:

```
$ cd examples
$ make
```

## Libraries
* [unit-threaded](https://github.com/atilaneves/unit-threaded.git)

## License
Distributed under the [Boost Software License, Version 1.0](http://www.boost.org/LICENSE_1_0.txt)
