import '../router/app_router.dart';

var accountMenu = [
  {
    "title": "Preferences",    // tr
    "icon": "assets/icons/settings.svg",
    "url": AppRouter.preferences,
  },
   {
    "title": "Reminder",
    "icon": "assets/icons/clock.svg",
    "url": AppRouter.reminder,
  },
  {
    "title": "Invite friends",
    "icon": "assets/icons/user_group.svg",
    "url": AppRouter.inviteFriend,
  },

   {
    "title": "Account & Security",
    "icon": "assets/icons/shield.svg",
    "url": AppRouter.security,
  },
   {
    "title": "Payment Methods",
    "icon": "assets/icons/card.svg",
    "url": AppRouter.paymentmethods,
  },
   {
    "title": "Billing & Subscriptions",
    "icon": "assets/icons/billing.svg",
    "url": AppRouter.subscription,
  },
   {
    "title": "Linked Accounts",
    "icon": "assets/icons/linked.svg",
    "url": AppRouter.linkedacounts,
  },
   {
    "title": "Data & Analytics",
    "icon": "assets/icons/data.svg",
    "url": AppRouter.analytics,
  },
   {
    "title": "App Appearance",
    "icon": "assets/icons/eye.svg",
    "url": AppRouter.appearance,
  },
   {
    "title": "Help & Support",
    "icon": "assets/icons/support.svg",
    "url":AppRouter.support,
  },
   {
    "title": "Rate us",
    "icon": "assets/icons/star.svg",
    "url": "/gallery"
  },
   {
    "title": "Logout",
    "icon": "assets/icons/logout.svg",
    "url": "/logout"
  }
];
