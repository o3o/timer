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
   Thread.sleep(dur!("msecs")(100));
   Duration t0 = sw.elapsed();
   sw.stop();

   Duration t1 = sw.elapsed();
   Duration t2 = sw.elapsed();

   assert(t0 <= t1);
   t1.shouldEqual(t2);
   assert(t1 > dur!"msecs"(0));
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

void testDoubleStart() {
   auto sw = StopWatchTimer();
   sw.running.shouldBeFalse;

   sw.start();
   sw.running.shouldBeTrue;

   Thread.sleep(dur!("msecs")(100));
   Duration t1 = sw.elapsed();

   sw.start();
   sw.running.shouldBeTrue;
   Thread.sleep(dur!("msecs")(200));
   sw.elapsed.shouldBeGreaterThan(t1);
}

void testDoubleStartResetTimer() {
   auto sw = StopWatchTimer();
   sw.running.shouldBeFalse;

   sw.start();
   sw.running.shouldBeTrue;

   Thread.sleep(dur!("msecs")(100));
   Duration t1 = sw.elapsed();

   sw.start(); // should reset initial time
   t1.shouldBeGreaterThan(sw.elapsed);
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

void testSecs() {
   StopWatchTimer sw;
   sw.start();
   Thread.sleep(dur!("msecs")(100));
   sw.stop();

   sw.elapsed.total!"seconds".shouldEqual(sw.elapsedSeconds);
   sw.reset();
   sw.elapsed.total!"seconds".shouldEqual(0);
   sw.elapsedSeconds.shouldEqual(0);
}

void testIdle() {
   StopWatchTimer sw;
   sw.running.shouldBeFalse;

   sw.stop();
   sw.running.shouldBeFalse;

   sw.reset();
   sw.running.shouldBeFalse;
}

@UnitTest
void resetInIdleStatus() {
   StopWatchTimer sw;
   sw.running.shouldBeFalse;

   sw.start();
   sw.running.shouldBeTrue;
   Thread.sleep(dur!("msecs")(100));

   sw.stop();
   sw.running.shouldBeFalse;
   sw.elapsedMsecs.shouldBeGreaterThan(99);

   sw.reset();
   sw.elapsedMsecs.shouldEqual(0);
}

@UnitTest
void resetInRunningStatus() {
   StopWatchTimer sw;

   sw.running.shouldBeFalse;
   sw.start();
   sw.running.shouldBeTrue;

   Thread.sleep(dur!("msecs")(100));
   sw.elapsedMsecs.shouldBeGreaterThan(99);

   sw.reset();
   sw.running.shouldBeFalse;
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
