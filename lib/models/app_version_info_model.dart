class AppVersionInfo {
  final String minimumVersion;
  final String? playStoreUrl;
  final String? appStoreUrl;

  AppVersionInfo({
    required this.minimumVersion,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  factory AppVersionInfo.fromJson(Map<String, dynamic> json) {
    return AppVersionInfo(
      minimumVersion: json['minimumVersion'],
      playStoreUrl: json['playStoreUrl'],
      appStoreUrl: json['appStoreUrl'],
    );
  }

  bool isAfter(AppVersionInfo referenceVersion) {
    if (minimumVersion.split(".").length != 3 || referenceVersion.minimumVersion.split(".").length != 3) {
      return false;
    }
    final installedMajorVersion = int.parse(minimumVersion.split(".")[0]);
    final installedMinorVersion = int.parse(minimumVersion.split(".")[1]);
    final installedPatchVersion = int.parse(minimumVersion.split(".")[2]);

    final referenceMajorVersion = int.parse(referenceVersion.minimumVersion.split(".")[0]);
    final referenceMinorVersion = int.parse(referenceVersion.minimumVersion.split(".")[1]);
    final referencePatchVersion = int.parse(referenceVersion.minimumVersion.split(".")[2]);

    // Compare major versions
    if (installedMajorVersion < referenceMajorVersion) {
      return false;
    } else if (installedMajorVersion > referenceMajorVersion) {
      return true;
    }

    // Major versions are equal, compare minor versions
    if (installedMinorVersion < referenceMinorVersion) {
      return false;
    } else if (installedMinorVersion > referenceMinorVersion) {
      return true;
    }

    // Minor versions are equal, compare patch versions
    return installedPatchVersion >= referencePatchVersion;
  }
}
