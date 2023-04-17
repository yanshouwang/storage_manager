import 'package:flutter_test/flutter_test.dart';
import 'package:storage_manager/storage_manager.dart';
import 'package:storage_manager/storage_manager_platform_interface.dart';
import 'package:storage_manager/storage_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockStorageManagerPlatform
    with MockPlatformInterfaceMixin
    implements StorageManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final StorageManagerPlatform initialPlatform = StorageManagerPlatform.instance;

  test('$MethodChannelStorageManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelStorageManager>());
  });

  test('getPlatformVersion', () async {
    StorageManager storageManagerPlugin = StorageManager();
    MockStorageManagerPlatform fakePlatform = MockStorageManagerPlatform();
    StorageManagerPlatform.instance = fakePlatform;

    expect(await storageManagerPlugin.getPlatformVersion(), '42');
  });
}
