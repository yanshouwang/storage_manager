import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/storage_manager_pigeon.dart',
    dartTestOut: 'test/test_storage_manager_pigeon.dart',
    kotlinOut:
        'android/src/main/kotlin/dev/yanshouwang/storage_manager/StorageManagerPigeon.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.yanshouwang.storage_manager',
    ),
  ),
)
class StorageVolume {
  final String description;
  final String? mediaStoreVolumeName;
  final String state;
  final bool isEmulated;
  final bool isPrimary;
  final bool isRemovable;

  StorageVolume({
    required this.description,
    required this.mediaStoreVolumeName,
    required this.state,
    required this.isEmulated,
    required this.isPrimary,
    required this.isRemovable,
  });
}

@HostApi(dartHostTestHandler: 'TestStorageManagerHostApi')
abstract class StorageManagerHostApi {
  /// Return the list of shared/external storage volumes currently available to the calling user.
  ///
  /// These storage volumes are actively attached to the device, but may be in any mount state, as returned by
  /// StorageVolume#getState(). Returns both the primary shared storage device and any attached external volumes,
  /// including SD cards and USB drives.
  List<StorageVolume> getStorageVolumes();

  /// Registers the given callback to listen for StorageVolume changes.
  ///
  /// For example, this can be used to detect when a volume changes to the Environment#MEDIA_MOUNTED or
  /// Environment#MEDIA_UNMOUNTED states.
  void registerStorageVolumeCallback();

  /// Unregisters the given callback from listening for StorageVolume changes.
  void unregisterStorageVolumeCallback();
}

@FlutterApi()
abstract class StorageManagerFlutterApi {
  /// Called when StorageVolume#getState() changes, such as changing to the Environment#MEDIA_MOUNTED or
  /// Environment#MEDIA_UNMOUNTED states.
  ///
  /// The given argument is a snapshot in time and can be used to process events in the order they occurred, or you can
  /// call StorageManager#getStorageVolumes() to observe the latest value.
  void onStateChanged(StorageVolume volume);
}
