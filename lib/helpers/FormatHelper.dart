import 'package:intl/intl.dart';

class FormatHelper {
  static String formatPrice(double price) {
    // Input: 1000.00
    // Output: ฿1,000.00
    // NOTE: (locale: 'th_TH') defines the currency (฿)
    return NumberFormat.simpleCurrency(locale: 'th_TH').format(price);
  }
}
