import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.System;
import Toybox.Math;

const URL = "https://raw.githubusercontent.com/PeterChu3/jsonHosting/main/12.json";

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

    function getGlanceView() {
        return [ new homesteadGlance() ];
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        var typedArray = ["", "", "", "Loading data", "","", ""] as Array<String>;
        return [ new homesteadView(typedArray) ] as Array<Views or InputDelegates>;
    }


    // set up the response callback function    
    function Receive1(responseCode as Number, data as Null or Dictionary or String) as Void  {
        if (responseCode == 200 && (data.get("data") as Array).size() > 0) {
            var temp = (data.get("data") as Array);
            var String1 = "";
            var String2 = "";
            var String3 = "";
            var String4 = "";
            var String5 = "";
            var String6 = "";
            var String7 = "";

            var lap = temp[temp.size() - 1][1];
            String1 = "Lap: " + lap;
            var miles = (temp[temp.size() - 1][1].toFloat() * 1.38).format("%.2f");
            String2 = "Miles: " + miles;


            String3 = "Total Average speed: " + getAverageSpeed(temp[temp.size() - 1]);

            String4 = "Ave Lap Time (HH:MM:SS): " + convertSecondsToMinutes(temp);

            String5 = getString5(temp);
            
            String6 = getString6(temp);

            String7 = "Homestead 2022";
            var typedArray = [String1, String2, String3, String4, String5, String6, String7] as Array<String>;

            var lapsStore = "L: " + lap;
            var milesStore = "M: " + miles;
            var aveSpeedStore = "AS: " + getAverageSpeed(temp[temp.size() - 1]);;
            var aveLapStore = "AL: " + convertSecondsToMinutes(temp);
            Application.Properties.setValue("Laps", lapsStore);
            Application.Properties.setValue("Miles", milesStore);
            Application.Properties.setValue("AS", aveSpeedStore);
            Application.Properties.setValue("AL", aveLapStore);           
            System.println("Writing values");
            //Get only the JSON data we are interested in and call the view class
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);

        }
        else if (data == null) { 
            
        }
        else {
            var typedArray = ["", "No DATA YET", "or NO response", "HOW DO YOU DO THIS???", "","BROKEN", ""] as Array<String>;
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);
        }
    }
    function getString6(input) {
        var remainingSeconds = 86400 - timeStringToSeconds(input[input.size() - 1][2]).toLong();

        var hours = Math.floor(remainingSeconds / 3600);
        var minutes = Math.floor(((remainingSeconds) % 3600) / 60);
        var seconds = Math.floor((remainingSeconds) % 60);

        return "Time Left (HH:MM:SS) :"+"("+ hours + ":" + minutes + ":" + seconds + ")";
    }
    function getString5(input) {
        var lapTotal = input[input.size() - 1][1].toLong();
        var goalLaps = 254;
        var remain = goalLaps - lapTotal;
        return "Laps to 350 mi: "+ goalLaps + "/Laps Left " + remain;
    }
    function convertSecondsToMinutes(input) {
        var divisor = input[input.size() - 1][1].toLong();
        var totalSeconds = timeStringToSeconds(input[input.size() - 1][2]).toLong();

        // Calculate minutes and seconds
        var hours = Math.floor(totalSeconds / divisor / 3600);
        var minutes = Math.floor(((totalSeconds / divisor) % 3600) / 60);
        var seconds = Math.floor((totalSeconds / divisor) % 60);
        return "("+ hours + ":" + minutes + ":" + seconds + ")";
    }
    function getAverageSpeed(input) {
        var miles = (input[1].toFloat() * 1.38).format("%.2f");        
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
        // var responseCallback = method(:onReceive);
 
        Communications.makeWebRequest(url, params, options, method(:Receive1));
    }

}

function getApp() as homesteadApp {
    return Application.getApp() as homesteadApp;
}