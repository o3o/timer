module tests.countdown2;

import core.thread;

import unit_threaded;
import timer.countdown;

void testIsOver() {
   import core.thread;

   // in ms
   auto count = Countdown2();
   count.isOver.shouldBeTrue;

   count.start(50);
   count.isOver.shouldBeFalse;

   Thread.sleep(dur!("msecs")(100));
   count.isOver.shouldBeTrue;
}

void testElapsed() {
   // in ms
   auto count = Countdown2();

   count.start(100);
   Thread.sleep(dur!("msecs")(10));

   count.elapsedTime.shouldBeGreaterThan(9);
   count.remainingTime.shouldBeSmallerThan(92);
}

void testElapsedS() {
   // seconds
   auto count = Countdown2Sec();
   count.remainingTime.shouldEqual(0);

   count.start(1);
   Thread.sleep(dur!("msecs")(10));
   count.isOver.shouldBeFalse;

   count.elapsedTime.shouldBeGreaterThan(0.010);
   count.remainingTime.shouldBeSmallerThan(.990);
}

void testElapsedM() {
   auto count = Countdown2MicroSec();
   count.remainingTime.shouldEqual(0);

   count.start(100_000);
   Thread.sleep(dur!("msecs")(10));
   count.isOver.shouldBeFalse;

   count.elapsedTime.shouldBeGreaterThan(10_000);
   count.remainingTime.shouldBeSmallerThan(90_000);
}

@UnitTest
void startReset() {
   auto count = Countdown2MicroSec();

   count.start(100_000);
   count.running.shouldBeTrue;

   Thread.sleep(dur!("msecs")(10));
   count.elapsedTime.shouldBeGreaterThan(10_000);

   count.start(100_000);
   Thread.sleep(dur!("msecs")(10));
   count.running.shouldBeTrue;
   count.elapsedTime.shouldBeSmallerThan(11_000);
}
