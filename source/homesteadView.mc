import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class homesteadView extends WatchUi.View {

    	var _tempArray;

    function initialize(tempArray) {
        View.initialize();
        _tempArray = tempArray;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        (View.findDrawableById("l1") as Toybox.WatchUi.Text).setText(_tempArray[0]);
        (View.findDrawableById("l2") as Toybox.WatchUi.Text).setText(_tempArray[1]);
        (View.findDrawableById("l3") as Toybox.WatchUi.Text).setText(_tempArray[2]);
        (View.findDrawableById("l4") as Toybox.WatchUi.Text).setText(_tempArray[3]);
        (View.findDrawableById("l5") as Toybox.WatchUi.Text).setText(_tempArray[4]);
        (View.findDrawableById("l6") as Toybox.WatchUi.Text).setText(_tempArray[5]);
        (View.findDrawableById("l7") as Toybox.WatchUi.Text).setText(_tempArray[6]);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
