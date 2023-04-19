package dev.yanshouwang.storage_manager

import android.content.Context
import android.os.Build
import android.os.storage.StorageManager
import android.os.storage.StorageManager.StorageVolumeCallback
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.util.concurrent.Executors

const val KEY_CONTEXT = "KEY_CONTEXT"
const val KEY_STORAGE_MANAGER_FLUTTER_API = "KEY_STORAGE_MANAGER_FLUTTER_API"

val instances = mutableMapOf<String, Any>()

val context get() = instances[KEY_CONTEXT] as Context
val mainExecutor get() = ContextCompat.getMainExecutor(context)
val storageManager get() = context.getSystemService(Context.STORAGE_SERVICE) as StorageManager
val flutterApi get() = instances[KEY_STORAGE_MANAGER_FLUTTER_API] as StorageManagerFlutterApi

/** StorageManagerPlugin */
class StorageManagerPlugin : FlutterPlugin {
    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = binding.binaryMessenger

        instances[KEY_CONTEXT] = binding.applicationContext
        instances[KEY_STORAGE_MANAGER_FLUTTER_API] = StorageManagerFlutterApi(binaryMessenger)

        StorageManagerHostApi.setUp(binaryMessenger, StorageManagerApi)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = binding.binaryMessenger

        StorageManagerHostApi.setUp(binaryMessenger, null)

        instances.remove(KEY_CONTEXT)
        instances.remove(KEY_STORAGE_MANAGER_FLUTTER_API)
    }
}
