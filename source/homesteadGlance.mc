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
        var text3 = Application.Properties.getValue("AL");
        var text4 = Application.Properties.getValue("AS");
        System.println(text3);
    	dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
        dc.drawText(10, 2,     
            Graphics.FONT_GLANCE, text1,
            Graphics.TEXT_JUSTIFY_LEFT
        );
        dc.drawText(10, dc.getHeight() / 2,     
            Graphics.FONT_GLANCE, text2,
            Graphics.TEXT_JUSTIFY_LEFT
        );
        dc.drawText(dc.getWidth()/2 + 10,2,     
            Graphics.FONT_GLANCE, text3,
            Graphics.TEXT_JUSTIFY_LEFT 
        );
        dc.drawText(dc.getWidth()/2 + 10, dc.getHeight() / 2,     
            Graphics.FONT_GLANCE, text4,
            Graphics.TEXT_JUSTIFY_LEFT     
        );       
    }
}