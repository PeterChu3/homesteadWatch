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
            System.println("Request Successful");                   // print success
            var temp = (data.get("data") as Array);

            System.println(temp[temp.size() - 1]); // obtains the last lap

            var String1 = "Lap: " + temp[temp.size() - 1][1];
            var miles = (temp[temp.size() - 1][1].toFloat() * 1.38).format("%.2f");
            var String2 = "Miles: " + miles;
            var typedArray = [String1, String2, "", "Homestead 2022", "","NICE", ""] as Array<String>;

            //Get only the JSON data we are interested in and call the view class
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);

        }
        else {
            System.println("Response: " + responseCode);            // print response code
            var typedArray = ["", "FUCK THIS", "", "HOW DO YOU DO THIS???", "","BROKEN", ""] as Array<String>;
            WatchUi.switchToView(new homesteadView(typedArray), null, WatchUi.SLIDE_IMMEDIATE);
        }
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