
import '../../models/user_model.dart';

class ShareData {
  static final List<RecentUsers> users = [
    RecentUsers(
      id: '1',
      name: 'Charlotte Hanlin',
      imageUrl: 'assets/images/charlotte.png',
      platform: 'whatsapp',
    ),
    RecentUsers(
      id: '2',
      name: 'Kristin Watson',
      imageUrl: 'assets/images/kristin.png',
      platform: 'facebook',
    ),
    RecentUsers(
      id: '3',
      name: 'Clinton Mcclure',
      imageUrl: 'assets/images/klinton.png',
      platform: 'instagram',
    ),
    RecentUsers(
      id: '4',
      name: 'Maryland Winkles',
      imageUrl: 'assets/images/maryland.png',
      platform: 'instagram',
    ),
    RecentUsers(
      id: '5',
      name: 'Alex Herson',
      imageUrl: 'assets/images/alex.jpg',
      platform: 'instagram',
    ),
  ];

  static final List<SocialPlatform> platforms = [
    SocialPlatform(
      name: 'WhatsApp',
      icon: 'assets/images/whatsapp.png',
    ),
    SocialPlatform(
      name: 'Facebook',
      icon: 'assets/images/face.png',
    ),
    SocialPlatform(
      name: 'Instagram',
      icon: 'assets/images/instagram.png',
    ),
    SocialPlatform(
      name: 'Telegram',
      icon: 'assets/images/telegram.png',
    ),
    SocialPlatform(
      name: 'Twitter',
      icon: 'assets/images/twitter.png',
    ),
    SocialPlatform(
      name: 'Instagram',
      icon: 'assets/images/instagram.png',
    ),
    SocialPlatform(
      name: 'Facebook',
      icon: 'assets/images/face.png',
    ),
  ];
}