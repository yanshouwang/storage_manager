import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'storage_manager_pigeon.dart' as pigeon;

export 'environment.dart';

abstract class StorageManager extends PlatformInterface {
  /// Constructs a StorageManager.
  StorageManager() : super(token: _token);

  static final Object _token = Object();

  static StorageManager _instance = _StorageManager();

  /// The default instance of [StorageManager] to use.
  ///
  /// Defaults to [MethodChannelStorageManager].
  static StorageManager get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StorageManager] when
  /// they register themselves.
  static set instance(StorageManager instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<StorageVolume> get stateChanged;

  Future<List<StorageVolume>> getStorageVolumes();
}

abstract class StorageVolume {
  String get description;
  String? get mediaStoreVolumeName;
  String get state;
  bool get isEmulated;
  bool get isPrimary;
  bool get isRemovable;
}

class _StorageVolume extends StorageVolume {
  @override
  final String description;
  @override
  final String? mediaStoreVolumeName;
  @override
  final String state;
  @override
  final bool isEmulated;
  @override
  final bool isPrimary;
  @override
  final bool isRemovable;

  _StorageVolume({
    required this.description,
    required this.mediaStoreVolumeName,
    required this.state,
    required this.isEmulated,
    required this.isPrimary,
    required this.isRemovable,
  });
}

class _StorageManager extends StorageManager
    implements pigeon.StorageManagerFlutterApi {
  final pigeon.StorageManagerHostApi hostApi;
  late final StreamController<StorageVolume> stateChangedController;

  _StorageManager() : hostApi = pigeon.StorageManagerHostApi() {
    stateChangedController = StreamController<StorageVolume>.broadcast(
      onListen: registerStorageVolumeCallback,
      onCancel: unregisterStorageVolumeCallback,
    );
    pigeon.StorageManagerFlutterApi.setup(this);
  }

  @override
  Stream<StorageVolume> get stateChanged => stateChangedController.stream;

  @override
  Future<List<StorageVolume>> getStorageVolumes() {
    return hostApi.getStorageVolumes().then((volumes) {
      return volumes.map((volume) => volume!.toNative()).toList();
    });
  }

  void registerStorageVolumeCallback() {
    hostApi.registerStorageVolumeCallback();
  }

  void unregisterStorageVolumeCallback() {
    hostApi.unregisterStorageVolumeCallback();
  }

  @override
  void onStateChanged(pigeon.StorageVolume volume) {
    stateChangedController.add(volume.toNative());
  }
}

extension on pigeon.StorageVolume {
  StorageVolume toNative() {
    return _StorageVolume(
      description: description,
      mediaStoreVolumeName: mediaStoreVolumeName,
      state: state,
      isEmulated: isEmulated,
      isPrimary: isPrimary,
      isRemovable: isRemovable,
    );
  }
}
