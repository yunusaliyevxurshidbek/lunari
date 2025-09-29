
import '../../models/accounts_model.dart';

class AccountData {
  static final List<AccountInfo> accounts = [

    AccountInfo(
        name: "Google",
        imageUrl: "assets/images/google.png",
        condition: true
    ),
    AccountInfo(
        name: "Apple",
        imageUrl: "assets/images/apple.png",
        condition: true
    ),
    AccountInfo(
        name: "Facebook",
        imageUrl: "assets/images/facebook.png",
        condition: false
    ),
    AccountInfo(
        name: "Twitter",
        imageUrl: "assets/images/x.png",
        condition: false
    ),
  ];
}