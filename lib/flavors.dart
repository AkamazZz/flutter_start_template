enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Project Dev';
      case Flavor.staging:
        return 'Project Staging';
      case Flavor.prod:
        return 'Project';
      default:
        return 'title';
    }
  }

}
