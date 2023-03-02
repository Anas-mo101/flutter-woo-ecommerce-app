
import 'package:flutter_ecommerce_app/src/modules/payment/models/payment_strategy.dart';

class PaymentStripe implements PaymentStrategy {

  @override
  void collectPaymentDetail() {
    // TODO: implement collectPaymentDetail
  }

  @override
  void pay(double amount) {
    // TODO: implement pay
  }

  @override
  bool validatePaymentDetails() {
    // TODO: implement validatePaymentDetails
    throw UnimplementedError();
  }

}