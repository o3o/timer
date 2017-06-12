module timer.stopwatch;
import std.datetime;

/**
 *
 * StopWatch measures time.
 *
 * This class uses a MonoTime
 */
struct StopWatchTimer {
   // true if observing.
   private bool _flagStarted = false;

   // TickDuration at the time of StopWatch starting measurement.
   private MonoTime _timeStart;

   // Total time that StopWatch ran.
   private Duration _timeMeasured;

   /**
    * Starts the stop watch
    */
   void start() @nogc {
      _flagStarted = true;
      _timeStart = MonoTime.currTime;
      _timeMeasured = Duration.zero;
   }

   /**
    * Stops the stop watch.
    */
   void stop() @nogc {
      if (_flagStarted) {
         _flagStarted = false;
         _timeMeasured += MonoTime.currTime - _timeStart;
      } else {
         reset();
      }
   }

   /**
    * Stops and resets the stop watch.
    */
   void reset() @nogc {
      _flagStarted = false;
      _timeStart = MonoTime.zero;
      _timeMeasured = Duration.zero;
   }

   /**
    * Reset and start the stop watch.
    */
   void restart() @nogc {
      reset();
      start();
   }

   /**
    * Confirms whether this stopwatch is measuring time.
    */
   bool running() @property const pure nothrow @nogc  {
      return _flagStarted;
   }

   /**
    * Gets the total elapsed time
    */
   Duration elapsed() const @nogc  {
      if (_flagStarted) {
         return (MonoTime.currTime - _timeStart) + _timeMeasured;
      } else {
         return _timeMeasured;
      }
   }

   /**
    * Gets the total elapsed time in milliseconds
    */
   long elapsedMsecs() {
      return elapsed.total!("msecs");
   }

   /**
    * Gets the total elapsed time in seconds
    */
   long elapsedSeconds() {
      return elapsed.total!("seconds");
   }
}
