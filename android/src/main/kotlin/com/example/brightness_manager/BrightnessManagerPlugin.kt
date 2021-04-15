package com.example.brightness_manager

import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** BrightnessManagerPlugin */
class BrightnessManagerPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var binding: ActivityPluginBinding
  private lateinit var contentResolver: ContentResolver

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "brightness_manager")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "set_brightness") {
      setBrightness(call.arguments as Double)
      channel.invokeMethod("get_brightness", getBrightness())
    } else {
      result.notImplemented()
    }
  }

  fun setBrightness(brightness: Double) {
  if (!isWriteSettingsPermissionGranted())  {
      var intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
      intent.data = Uri.parse("package" + binding.activity.packageName)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      binding.activity.startActivity(intent)
    }

    Settings.System.putInt(contentResolver, Settings.System.SCREEN_BRIGHTNESS, (brightness * 255).toInt())
    binding.activity.window.attributes.screenBrightness = brightness.toFloat()
  }

  fun getBrightness(): Float{
    return binding.activity.window.attributes.screenBrightness
  }

  private fun isWriteSettingsPermissionGranted(): Boolean{
    return true;
//    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
//      if(Settings.System.canWrite(binding.activity.applicationContext))
//      {
//        return true;
//      }
//    }
//    return false;
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.binding = binding
    this.contentResolver = binding.activity.contentResolver
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }
}
