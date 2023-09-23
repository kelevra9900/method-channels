package com.example.challenge

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val PLATFORM_VERSION_CHANNEL = "com.example/platform_version"
    private val DATA_CHANNEL = "com.example/data_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Canal para obtener la versión de la plataforma
        val platformVersionChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PLATFORM_VERSION_CHANNEL)

        platformVersionChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "getPlatformVersion") {
                val platformVersion = "Android ${Build.VERSION.RELEASE}"
                result.success(platformVersion)
            } else {
                result.notImplemented()
            }
        }
        // Canal para la comunicación de datos ("dataChannel")
        val dataChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DATA_CHANNEL)

        dataChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
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
