module tests.stopwatch;

import core.thread;

import unit_threaded;
import timer.stopwatch;

void testRunning() {

   auto sw = StopWatchTimer();
   sw.running.shouldBeFalse;

   sw.start();
   sw.running.shouldBeTrue;

   sw.stop();
   sw.running.shouldBeFalse;

   sw.start();
   sw.running.shouldBeTrue;

   sw.reset();
   sw.running.shouldBeFalse;
}

void testElaps() {

   StopWatchTimer sw;
   sw.start();
   auto t0 = sw.elapsed();
   sw.stop();

   auto t1 = sw.elapsed();
   auto t2 = sw.elapsed();
   assert(t0 <= t1);
   assert(t1 == t2);
}

void testDoubleStop() {
   auto sw = StopWatchTimer();
   sw.running.shouldBeFalse;

   sw.start();
   sw.stop();
   Duration t1 = sw.elapsed();
   sw.stop();
   Thread.sleep(dur!("msecs")(100));
   (t1 - sw.elapsed).total!"msecs".shouldEqual(0);
}

void testElapsIncrease() {
   auto sw = StopWatchTimer();
   sw.start();
   Thread.sleep(dur!("msecs")(100));
   sw.elapsedMsecs.shouldBeGreaterThan(99);

   Thread.sleep(dur!("msecs")(100));
   sw.elapsedMsecs.shouldBeGreaterThan(199);

   sw.stop();
   Duration t1 = sw.elapsed();
   Thread.sleep(dur!("msecs")(200));
   (t1 - sw.elapsed).total!"msecs".shouldEqual(0);
}

void testMs() {
   StopWatchTimer sw;
   sw.start();
   Thread.sleep(dur!("msecs")(100));
   sw.stop();
   sw.elapsed.total!"msecs".shouldEqual(sw.elapsedMsecs);
   sw.reset();
   sw.elapsed.total!"msecs".shouldEqual(0);
   sw.elapsedMsecs.shouldEqual(0);
}

void testIdle() {
   StopWatchTimer sw;
   sw.running.shouldBeFalse;

   sw.stop();
   sw.running.shouldBeFalse;

   sw.reset();
   sw.running.shouldBeFalse;
}

void testReset() {
   StopWatchTimer sw;
   sw.running.shouldBeFalse;
   sw.start();
   Thread.sleep(dur!("msecs")(100));

   sw.stop();
   sw.running.shouldBeFalse;
   sw.elapsedMsecs.shouldBeGreaterThan(99);

   sw.reset();
   sw.elapsedMsecs.shouldEqual(0);
}

void testRestart() {
   StopWatchTimer sw;
   sw.running.shouldBeFalse;
   sw.start();

   sw.running.shouldBeTrue;
   Thread.sleep(dur!("msecs")(200));
   sw.stop();
   sw.elapsedMsecs.shouldBeGreaterThan(199);
   sw.running.shouldBeFalse;

   Thread.sleep(dur!("msecs")(50));
   sw.restart();
   sw.running.shouldBeTrue;
   sw.elapsedMsecs.shouldBeSmallerThan(100);
}