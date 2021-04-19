import 'dart:io';

class AdsHelper {
  static String get appId {
    if (Platform.isAndroid) {
      // This is the app id, gotten from: https://apps.admob.com/v2/apps/2537348407/settings
      return "ca-app-pub-1583793484936118~2537348407";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_ADMOB_APP_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {    
      // When deploying, use the right one: https://apps.admob.com/v2/apps/2537348407/adunits/list?pli=1
      return "ca-app-pub-1583793484936118/6285021720";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1583793484936118/3355606054";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get testBannerAdUnitId {
    if (Platform.isAndroid) {
      // Use "ca-app-pub-1583793484936118~2537348407" for testing: https://developers.google.com/admob/android/test-ads#sample%5C_ad%5C_units
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_BANNER_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
    // When deploying, use the right one: https://apps.admob.com/v2/apps/2537348407/adunits/list?pli=1
      return "ca-app-pub-1583793484936118/2252856498";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1583793484936118/3794412140";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get testInterstitialAdUnitId {
    if (Platform.isAndroid) {
      // Use "ca-app-pub-3940256099942544/8691691433" for testing: https://developers.google.com/admob/android/test-ads#sample%5C_ad%5C_units
      return "ca-app-pub-3940256099942544/8691691433";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
