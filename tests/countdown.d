module tests.countdown;

import core.thread;

import unit_threaded;
import timer.countdown;

void testIsOver() {
   import core.thread;

   // e' in ms
   auto count = Countdown();

   count.start(50);
   count.isOver.shouldBeFalse;

   Thread.sleep(dur!("msecs")(100));
   count.isOver.shouldBeTrue;
}

void testElapsed() {

   // e' in ms
   auto count = Countdown();

   count.start(100);
   Thread.sleep(dur!("msecs")(10));

   import std.stdio;
   writeln(count.elapsedTime);

   count.elapsedTime.shouldBeGreaterThan(9);
   count.remainingTime.shouldBeSmallerThan(92);
}

void testElapsedS() {
   // e' in sec
   auto count = CountdownSec();
   count.remainingTime.shouldEqual(0);

   count.start(1);
   Thread.sleep(dur!("msecs")(10));
   count.isOver.shouldBeFalse;

   count.elapsedTime.shouldBeGreaterThan(0.010);
   count.remainingTime.shouldBeSmallerThan(.990);
}

void testElapsedM() {
   // e' in sec
   auto count = CountdownMicroSec();
   count.remainingTime.shouldEqual(0);

   count.start(100_000);
   Thread.sleep(dur!("msecs")(10));
   count.isOver.shouldBeFalse;

   count.elapsedTime.shouldBeGreaterThan(10_000);
   count.remainingTime.shouldBeSmallerThan(90_000);
}
