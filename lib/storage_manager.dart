
import 'storage_manager_platform_interface.dart';

class StorageManager {
  Future<String?> getPlatformVersion() {
    return StorageManagerPlatform.instance.getPlatformVersion();
  }
}
