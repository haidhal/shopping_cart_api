// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/screen_two_controller.dart';
import 'package:shopping_cart_api/view/cart_screen/cart_screen.dart';
import 'package:shopping_cart_api/view/screen_three/screen_three.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<ScreenTwoController>().getcategory();
        await context.read<ScreenTwoController>().getAllproducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = context.watch<ScreenTwoController>();

    return Scaffold(
    
      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 60,
        title: const Text(
          "Discover",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Icons.card_travel)),
          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                size: 40,
                color: Colors.black,
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.black,
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          )
        ],
      ),
      body: providerObj.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "search anything",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // CATEGORY LIST
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    providerObj.categoryList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ScreenTwoController>()
                              .onCategorySelection(index);
                        },
                        child: Container(
                          height: 50,
                          //width: 70,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              //color: Colors.grey,

                              color: providerObj.selectedCategoryIndex == index
                                  ? Colors.black
                                  : Colors.grey),
                          child: Text(
                            providerObj.categoryList[index].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                //color: Colors.black,
                                color:
                                    providerObj.selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),

                Expanded(
                  child: providerObj.isProductLoading
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: () async {
                            await context
                                .read<ScreenTwoController>()
                                .getcategory();
                          },
                          child: GridView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: providerObj.productList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScreenThree(
                                                id: providerObj
                                                    .productList[index].id
                                                    .toString()
                                                // imageurl: providerObj
                                                //     .newproduct[index].image
                                                //     .toString(),
                                                // name: providerObj
                                                //     .newproduct[index].title
                                                //     .toString(),
                                                //price: ,
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(10)
                                      //   ),
                                      //   child: Icon(Icons.favorite_border),
                                      // ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          providerObj
                                                              .productList[
                                                                  index]
                                                              .image
                                                              .toString()),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Positioned(
                                              top: 3,
                                              right: 3,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        providerObj.productList[index].title
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "PKR 1,190",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ))),
                        ),
                )
                
              ],
            ),

     
    );
  }
}
