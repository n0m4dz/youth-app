package com.bitsoft.youth

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin

import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class MainActivity : FlutterFragmentActivity(), PluginRegistrantCallback  {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun registerWith(registry: PluginRegistry?) {
        GeneratedPluginRegistrant.registerWith(registry as FlutterEngine)
        FlutterLocalNotificationsPlugin.registerWith(registry!!.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    }
}
