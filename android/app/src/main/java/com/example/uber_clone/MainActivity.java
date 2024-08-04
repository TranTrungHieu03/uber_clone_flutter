package com.example.uber_clone;

////import io.flutter.embedding.android.FlutterActivity;
//
//import io.flutter.app.FlutterActivity;
//
//public class MainActivity extends FlutterActivity {
//}

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}