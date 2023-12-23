import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.System;

const URL = "https://my4.raceresult.com/192607/RRPublish/data/list?key=9d484a9a9259ff0ae1a4a8570861bc3b&listname=Online%7CLap%20Details&page=live&contest=0&r=bib2&bib=12";

class homesteadApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        makeRequest();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var typedArray = ["", "", "", "Loading data", "","", ""] as Array<String>;
        return [ new homesteadView(typedArray) ] as Array<Views or InputDelegates>;
    }

        // set up the response callback function
        
    function onReceive(responseCode as Number, data as Null or Dictionary or String) as Void  {
        if (responseCode == 200) {
            var temp = (data.get("data") as Array);
            var String1 = "";
            var String2 = "";
            var String3 = "";
            var String4 = "";
            var String5 = "";
            var String6 = "";
            var String7 = "";


            String1 = "Lap: " + temp[temp.size() - 1][1];
            var miles = (temp[temp.size() - 1][1].toFloat() * 1.38).format("%.2f");
            String2 = "Miles: " + miles;


            String3 = "Total Average speed: " + getAverageSpeed(temp[temp.size() - 1]);

            String4 = "";

            String5 = "";
            
            String6 = "";

            String7 = "Homestead 2022";
            var typedArray = [String1, String2, String3, String4, String5, String6, String7] as Array<String>;

            //Get only the JSON data we are interested in and call the view class
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);

        }
        else {
            var typedArray = ["", "FUCK THIS", "", "HOW DO YOU DO THIS???", "","BROKEN", ""] as Array<String>;
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);
        }
    }
    function getAverageSpeed(input) {
        var miles = (input[1].toFloat() * 1.38).format("%.2f");
        
        timeStringToSeconds(input[2]);
        // Convert time from seconds to hours
        var timeInHours = timeStringToSeconds(input[2]) / 3600;

        // Calculate miles per hour
        var mph = (miles.toFloat() / timeInHours).format("%.2f");
        return mph;

    }
    function timeStringToSeconds(timeString as String) {
        var hours = 0, minutes = 0, seconds = 0, fractions = 0;
        var len = timeString.length();
        var charArray = timeString.toCharArray();
        // Find the positions of colons and dots in the time string
        var colon1 = -1, colon2 = -1, dot = -1;

        for (var i = 0; i < len; i++) {
            if (charArray[i] == ':') {
                if (colon1 == -1) {
                    colon1 = i;
                } else {
                    colon2 = i;
                }
            } else if (charArray[i] == '.') {
                dot = i;
            }
        }
        // Parse hours, minutes, and seconds based on the positions of colons and dots
        if (colon2 >= 0) { 

            hours = timeString.substring(0, colon1).toLong();
            minutes = timeString.substring(colon1 + 1, colon2).toLong();
            seconds = timeString.substring(colon2 + 1, dot).toLong();

        } else {
            minutes = timeString.substring(0, colon1).toLong();
            seconds = timeString.substring(colon1 + 1, dot).toLong();
        }

        // Parse fractions
        if (dot >= 0) {
            fractions = timeString.substring(dot + 1, len).toLong();
        }

        // // Calculate total seconds
        var totalSeconds = hours * 3600 + minutes * 60 + seconds + fractions / 100.0;
        return totalSeconds;
    }
    function makeRequest() {
        var url = URL;
        var params = null;
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
        var responseCallback = method(:onReceive);
 
        Communications.makeWebRequest(url, params, options, method(:onReceive));
    }

}

function getApp() as homesteadApp {
    return Application.getApp() as homesteadApp;
}