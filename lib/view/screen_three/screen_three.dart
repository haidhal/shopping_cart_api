

//import 'package:fakestore_shopping_application/controller/cart_screen_controller.dart';
//import 'package:fakestore_shopping_application/controller/product_details_screen_controller.dart';
//import 'package:fakestore_shopping_application/view/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api/controller/screen_three_controller.dart';
import 'package:shopping_cart_api/view/cart_screen/cart_screen.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key, required this.id});
  final String id;

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ScreenThreeController>()
            .getProductDetails(widget.id);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsScreenProvider =
        context.watch<ScreenThreeController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: [
          Stack(
            children: [
              Icon(Icons.notifications_none_outlined),
              Positioned(
                top: 4,
                right: 3,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.black,
                  child: Text("1",
                      style: TextStyle(fontSize: 6, color: Colors.white)),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: productDetailsScreenProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 400,
                          //width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      productDetailsScreenProvider
                                          .productDetails!.image
                                          .toString()))),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 28,
                              weight: 300,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    productDetailsScreenProvider.productDetails!.title
                        .toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Row(
children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        "${productDetailsScreenProvider.productDetails!.rating!.rate.toString()}/5 ",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "(45 reviews)",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    softWrap: true,
                    productDetailsScreenProvider.productDetails!.description
                        .toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Choose size",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "S",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "M",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "L",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("price"),
                            Text(
                              productDetailsScreenProvider.productDetails!.price
.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                            context.read<CartScreenController>().addProduct(
                              id: productDetailsScreenProvider.productDetails!.id!, 
                            price: productDetailsScreenProvider.productDetails!.price!,
                            name: productDetailsScreenProvider.productDetails!.title,
                            desc: productDetailsScreenProvider.productDetails!.description,
                            image: productDetailsScreenProvider.productDetails!.image,
                            );
                            
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "ADD TO CART",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
