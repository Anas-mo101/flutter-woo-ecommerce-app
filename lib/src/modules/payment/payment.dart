import '../checkout/models/order_totals.dart';
import '../checkout/models/woo_order.dart';
import 'methods/payment_stripe.dart';


class Payment{
  WooOrder currentOrder;
  OrderTotals totals;

  Payment(this.currentOrder,this.totals);

  Future<void> pay(String paymentMethod) async {
    try{
      switch(paymentMethod){
        case 'cod':
          break;
        case 'stripe':
          PaymentStripe().pay(totals.total);
          break;
        case 'paypal':
          break;

        default: throw Exception('Payment Failed: invalid payment method');
      }
    }catch(e){
     throw Exception('Payment Failed: $e');
    }
  }


}