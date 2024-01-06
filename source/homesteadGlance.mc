using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application;

(:glance)
class homesteadGlance extends Ui.GlanceView {
	
    function initialize() {
      GlanceView.initialize();
    }
    
    function onUpdate(dc) {
    	 dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
       var text1 = Application.Properties.getValue("Laps");
       var text2 = Application.Properties.getValue("Miles");
       System.println(text1);
       System.println(text2);
    	 dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());

       
    }
}