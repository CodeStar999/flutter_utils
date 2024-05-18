enum NetworkType {
  bluetooth,
  wifi,
  ethernet,
  mobile,
  none,
  vpn,
  other;

  bool get isNone => this == NetworkType.none;

  bool get isWifi => this == NetworkType.wifi;

  bool get isMobile => this == NetworkType.mobile;
}
