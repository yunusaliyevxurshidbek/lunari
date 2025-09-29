class RecentUsers {
  final String id;
  final String name;
  final String imageUrl;
  final String platform;

  RecentUsers({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.platform,
  });
}

class SocialPlatform {
  final String name;
  final String icon;

  SocialPlatform({
    required this.name,
    required this.icon,
  });
}