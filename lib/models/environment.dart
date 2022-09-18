import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env';
    }
    return '.env';
  }

  static String get apiUrl {
    return dotenv.get('Api_Url');
  }

  static String get baseUrl {
    return dotenv.get('Base_Url');
  }

  static String get imageBaseUrl {
    return dotenv.get('Image_Base_Url');
  }

  static String get stripePublicKey {
    return dotenv.get('Stripe_Publishable_key');
  }

  static String get stripeSecretKey {
    return dotenv.get('Stripe_Secret_key');
  }
}
