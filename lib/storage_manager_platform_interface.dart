import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'storage_manager_method_channel.dart';

abstract class StorageManagerPlatform extends PlatformInterface {
  /// Constructs a StorageManagerPlatform.
  StorageManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static StorageManagerPlatform _instance = MethodChannelStorageManager();

  /// The default instance of [StorageManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelStorageManager].
  static StorageManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [StorageManagerPlatform] when
  /// they register themselves.
  static set instance(StorageManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
