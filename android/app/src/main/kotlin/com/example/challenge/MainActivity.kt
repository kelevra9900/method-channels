package com.example.challenge

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/data_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "concatenateString") {
                if (call.arguments is String) {
                    val messageFromFlutter = call.arguments as String
                    val response = messageFromFlutter + " - Native"
                    result.success(response)
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid argument", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
