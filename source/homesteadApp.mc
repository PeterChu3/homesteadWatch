import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Communications;

const URL = "https://jsonplaceholder.typicode.com/todos/2";

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
        return [ new homesteadView("Loading data","","") ] as Array<Views or InputDelegates>;
    }

        // set up the response callback function
        
    function onReceive(responseCode as Number, data as Null or Dictionary or String) as Void  {
        //Ui.switchToView(new GarminJSONWebRequestWidgetView("onReceive: " + URL + "\n" + responseCode + " " + data), null, Ui.SLIDE_IMMEDIATE);
       
        //Get only the JSON data we are interested in and call the view class
        WatchUi.switchToView(new homesteadView(data.get("userId"),data.get("id"),data.get("title")), null, WatchUi.SLIDE_IMMEDIATE);
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