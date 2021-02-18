package com.example.flutter_qiniu

import android.util.Log
import androidx.annotation.NonNull;
import com.example.flutter_qiniu.QiNiuSdkManager.UploadInterface
import com.qiniu.android.http.ResponseInfo

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.json.JSONObject

/** FlutterQiniuPlugin */
public class FlutterQiniuPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "plugins.xiaoenai.com/flutter_qiniu")
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        var qiniuChannel: MethodChannel? = null

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "plugins.xiaoenai.com/flutter_qiniu")
            channel.setMethodCallHandler(FlutterQiniuPlugin())
            qiniuChannel = channel
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "upload") {
            QiNiuSdkManager.getInstance().initConfig()
            var data: String = call.arguments.toString()
            var jsData = JSONObject(data)
            var filePath = jsData.getString("filePath")
            var token = jsData.getString("token")
            var key = jsData.getString("key")
            QiNiuSdkManager.getInstance().upLoadImage(filePath, key, token, object : UploadInterface {
                override fun uploadComplete(key: String?, info: ResponseInfo?, response: JSONObject?) {
                    var successData = JSONObject()
                    successData.put("success", true)
                    successData.put("base_url", response!!.get("base_url"))
                    successData.put("key", response!!.getString("key"))
                    result.success(successData.toString())
                }

                override fun uploadFail(key: String?, info: ResponseInfo?, response: JSONObject?) {
                    var successData = JSONObject()
                    successData.put("success", false)
                    successData.put("info", info)
                    successData.put("error", response)
                    result.success(successData.toString())
                }

                override fun uploadProgress(key: String?, percent: Double) {
                    invokeMethod(key, percent)
                }
            })
        } else {
            result.notImplemented()
        }
    }

    fun invokeMethod(key: String?, percent: Double) {
        var result = JSONObject()
        result.put("key", key)
        result.put("percent", percent)
        channel.invokeMethod("progress", result.toString())
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
