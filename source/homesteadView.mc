import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class homesteadView extends WatchUi.View {

    	var _userId;
    	var _Id;
    	var _title;

    function initialize(userId, Id, title) {
        View.initialize();
        _userId = userId.toString();   
        _Id = Id.toString();
        _title = title;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        (View.findDrawableById("high") as Toybox.WatchUi.Text).setText(_Id);
        (View.findDrawableById("low") as Toybox.WatchUi.Text).setText(_userId);
        (View.findDrawableById("center") as Toybox.WatchUi.Text).setText(_title);

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
