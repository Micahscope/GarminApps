import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.Time.Gregorian as Date;

class Project1View extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        setClockDisplay();
        setDateDisplay();
        setBatteryDisplay();
        setStepDisplay();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function setClockDisplay() {
        var clockTime = System.getClockTime();
        var hour as Number = (clockTime.hour > 12) ? clockTime.hour - 12 : clockTime.hour;
        var ampm as String = (clockTime.hour > 12) ? "PM" : "AM";
        //var clockString = Lang.format("$1$:$2$ $3$", [hour, clockTime.min.format("%02d"), ampm]);
        var clockString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);

        var timeDisplay = View.findDrawableById("TimeLabel");
        timeDisplay.setText(clockString);
        var ampmDisplay = View.findDrawableById("AMPMLabel");
        ampmDisplay.setText(ampm);
    }

    private function setDateDisplay() {
        var now = Time.now();
        var date = Date.info(now, Time.FORMAT_LONG);
        var dateString = Lang.format("$1$, $2$ $3$", [date.day_of_week, date.month, date.day]);
        var dateDisplay = View.findDrawableById("DateLabel");
        dateDisplay.setText(dateString);
    }

    private function setBatteryDisplay() {
        var battery = System.getSystemStats().battery;
        var batteryDisplay = View.findDrawableById("BatteryLabel");
        batteryDisplay.setText("🔋"+battery.format("%d")+"%");
    }

    private function setStepDisplay() {
        var stepCount = Toybox.ActivityMonitor.getInfo().steps.toString();
        var stepCountDisplay = View.findDrawableById("StepLabel");
        stepCountDisplay.setText(stepCount);
    }

}
