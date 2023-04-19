package dev.yanshouwang.storage_manager

import android.os.Build
import android.os.storage.StorageManager
import androidx.annotation.RequiresApi
import java.util.concurrent.Executors

object StorageManagerApi : StorageManagerHostApi {
    private val executor = Executors.newSingleThreadExecutor()
    private val storageVolumeCallback by lazy {
        @RequiresApi(Build.VERSION_CODES.R)
        object : StorageManager.StorageVolumeCallback() {
            override fun onStateChanged(volume: android.os.storage.StorageVolume) {
                mainExecutor.execute {
                    flutterApi.onStateChanged(volume.toNative()) {}
                }
            }
        }
    }

    override fun getStorageVolumes(): List<StorageVolume> {
        return storageManager.storageVolumes.map { volume -> volume.toNative() }
    }

    override fun registerStorageVolumeCallback() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
            throw UnsupportedOperationException()
        } else {
            storageManager.registerStorageVolumeCallback(executor, storageVolumeCallback)
        }
    }

    override fun unregisterStorageVolumeCallback() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
            throw UnsupportedOperationException()
        } else {
            storageManager.unregisterStorageVolumeCallback(storageVolumeCallback)
        }
    }
}

fun android.os.storage.StorageVolume.toNative(): StorageVolume {
    val description = this.getDescription(context)
    val mediaStoreVolumeName = if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
        null
    } else {
        this.mediaStoreVolumeName
    }
    return StorageVolume(
        description,
        mediaStoreVolumeName,
        state,
        isEmulated,
        isPrimary,
        isRemovable
    )
}