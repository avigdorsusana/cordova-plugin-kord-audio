package com.playkord.kordaudio;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

public class Hello extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {

        if (action.equals("greet")) {

            String name = data.getString(0);
            this.greet(name);
            return true;

        } else {
            
            return false;

        }
    }

    private void greet(String str, CallbackContext callbackContext){
        if (str != null && str.length() > 0) {
            String message = "Hello, " + name;
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}