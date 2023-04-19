abstract class Environment {
  /// Unknown storage state, such as when a path isn't backed by known storage
  /// media.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaUnknown = "unknown";

  /// Storage state if the media is not present.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaRemoved = "removed";

  /// Storage state if the media is present but not mounted.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaUnmounted = "unmounted";

  /// Storage state if the media is present and being disk-checked.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaChecking = "checking";

  /// Storage state if the media is present but is blank or is using an
  /// unsupported filesystem.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaNofs = "nofs";

  /// Storage state if the media is present and mounted at its mount point with
  /// read/write access.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaMounted = "mounted";

  /// Storage state if the media is present and mounted at its mount point with
  /// read-only access.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaMountedReadOnly = "mounted_ro";

  /// Storage state if the media is present not mounted, and shared via USB
  /// mass storage.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaShared = "shared";

  /// Storage state if the media was removed before it was unmounted.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaBadRemoval = "bad_removal";

  /// Storage state if the media is present but cannot be mounted. Typically
  /// this happens if the file system on the media is corrupted.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaUnmountable = "unmountable";

  /// Storage state if the media is in the process of being ejected.
  ///
  /// @see #getExternalStorageState(File)
  static const mediaEjecting = "ejecting";
}
