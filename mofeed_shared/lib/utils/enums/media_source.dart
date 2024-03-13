enum MediaSource {
  network,
  asset,
  local;

  bool get isNetWork => this == MediaSource.network;

  bool get isAsset => this == MediaSource.asset;

  bool get isLocal => this == MediaSource.local;
}

extension MediaSourceParser on String {
  MediaSource get toMediaSource {
    switch (this) {
      case "network":
        return MediaSource.network;
      case "asset":
        return MediaSource.asset;
      default :
        return MediaSource.local;
    }
  }
}
