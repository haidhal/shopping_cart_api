import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_cart_api/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api/view/cart_screen/widget/cart_item.dart';
//import 'package:shopping_cart_api_sample1/view/widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<CartScreenController>().getProduct();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderObj = context.read<CartScreenController>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Total price  \$ ${cartProviderObj.totalCartValue}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key': 'rzp_live_ILgsfZCZoFIKMb',
                        'amount': cartProviderObj.totalCartValue * 100,
                        'name': 'Acme Corp.',
                        'description': 'Fine T-Shirt',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };
                      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                          handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("My Cart"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return CartItemWidget(
                    title: cartProviderObj.cart[index].name.toString(),
                    desc: cartProviderObj.cart[index].desc.toString(),
                    price: cartProviderObj.cart[index].price!,
                    qty: cartProviderObj.cart[index].qty.toString(),
                    image: cartProviderObj.cart[index].image.toString(),

                    //"https://i.pinimg.com/564x/07/ec/bd/07ecbddc27b046883cc6c48cbade7e8a.jpg",

                    onIncrement: () {
                      context.read<CartScreenController>().incrementQty(index);
                    },
                    onDecrement: () {
                      context.read<CartScreenController>().decrementQty(index);
                    },
                    onRemove: () {
                      context.read<CartScreenController>().removeProduct(index);
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: cartProviderObj.cart.length)),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}