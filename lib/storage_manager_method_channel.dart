import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'storage_manager_platform_interface.dart';

/// An implementation of [StorageManagerPlatform] that uses method channels.
class MethodChannelStorageManager extends StorageManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('storage_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
