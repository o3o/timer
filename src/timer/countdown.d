module timer.countdown;
import std.datetime;

enum TimeUnit {
   microsec,
   millisec,
   sec
}

alias Countdown = CountdownTimer!(TimeUnit.millisec);
alias CountdownSec = CountdownTimer!(TimeUnit.sec);
alias CountdownMicroSec = CountdownTimer!(TimeUnit.microsec);

struct CountdownTimer(TimeUnit unit) {
   static if (unit == TimeUnit.sec) {
      private enum double HNS_TO_UNIT = 1E-7;
      private enum double UNIT_TOHNS = 1E7;
   } else static if (unit == TimeUnit.millisec) {
      private enum double HNS_TO_UNIT = 1E-4;
      private enum double UNIT_TOHNS = 1E4;
   } else static if (unit == TimeUnit.microsec) {
      private enum double HNS_TO_UNIT = .1;
      private enum double UNIT_TOHNS = 10.;
   }

   private long endTime;
   private long startTime;
   void start(double duration) {
      // ogni tick sono 100ns
      startTime = Clock.currStdTime;
      endTime = startTime + cast(long)(duration * UNIT_TOHNS);
   }

   @property double elapsedTime() {
      double e = cast(double)(Clock.currStdTime - startTime) * HNS_TO_UNIT;
      return e > 0 ? e : 0.;
   }

   @property double remainingTime() {
      double e = cast(double)(endTime - Clock.currStdTime) * HNS_TO_UNIT;
      return e > 0 ? e : 0.;
   }

   @property bool isOver() {
      return Clock.currStdTime > endTime;
   }
}
