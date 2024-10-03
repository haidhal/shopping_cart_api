import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/screen_two_controller.dart';
import 'package:shopping_cart_api/view/screen_three/screen_three.dart';
//import 'package:shoppingcart_buttonsample_ui/view/screen_one/screen_one.dart';
//import 'package:shoppingcart_buttonsample_ui/view/screen_three/screen_three.dart';

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

    //  List myDataList = [
    //   {
    //     "itemName" : "casual shirt",
    //     "imageurl" : "https://images.pexels.com/photos/3800478/pexels-photo-3800478.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price" : 499
    //   },
    //   {
    //     "itemName": "casual shirt",
    //     "imageurl":"https://images.pexels.com/photos/22305184/pexels-photo-22305184/free-photo-of-model-in-shirt-and-pants-sitting-on-steps.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":399
    //   },
    //   {
    //     "itemName": "regular shirt",
    //     "imageurl":"https://images.pexels.com/photos/6981611/pexels-photo-6981611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":350
    //   },
    //   {
    //     "itemName": "casual outfit",
    //     "imageurl":"https://images.pexels.com/photos/19238014/pexels-photo-19238014/free-photo-of-man-in-jacket-and-sweater-sitting-on-ground-in-evening.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":500
    //   },
    //    {
    //     "itemName": "trending jackets",
    //     "imageurl":"https://images.pexels.com/photos/16791407/pexels-photo-16791407/free-photo-of-model-in-jacket.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":40
    //   },
    //    {
    //     "itemName": "casual shirt",
    //     "imageurl":"https://images.pexels.com/photos/22305184/pexels-photo-22305184/free-photo-of-model-in-shirt-and-pants-sitting-on-steps.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":40
    //   },
    //   {
    //     "itemName": "regular shirt",
    //     "imageurl":"https://images.pexels.com/photos/6981611/pexels-photo-6981611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":90
    //   },
    //   {
    //     "itemName": "casual outfit",
    //     "imageurl":"https://images.pexels.com/photos/19238014/pexels-photo-19238014/free-photo-of-man-in-jacket-and-sweater-sitting-on-ground-in-evening.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":2999
    //   },
    //   {
    //     "itemName": "trending jackets",
    //     "imageurl":"https://images.pexels.com/photos/16791407/pexels-photo-16791407/free-photo-of-model-in-jacket.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    //     "price":6999
    //   },
    //  ];
    return Scaffold(
      //  debugShowCheckedModeBanner: false  ,

      appBar: AppBar(
        leadingWidth: 70,
        toolbarHeight: 60,
        title: const Text(
          "Discover",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),
        ),
        actions: const [
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    providerObj.categoryList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                           context.read<ScreenTwoController>().onCategorySelection(index);
                    
                        },
                        child: Container(
                          height: 50,
                          //width: 70,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                            // color: context.read<ScreenTwoController>().selectedClr == index ? Colors.black : Colors.grey
                          ),
                          child: Text(
                            providerObj.categoryList[index].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  )
                      // Container(
                      //   height: 50,width: 70,
                      //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Colors.grey,
                      //    ),
                      //   child: Text("All",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 20),),
                      // ),
                      // SizedBox(width: 10,),
                      // Container(
                      //   height: 50,width: 70,
                      //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Colors.grey,
                      //    ),
                      //   child: Text("Men",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 20),),
                      // ),
                      // SizedBox(width: 10,),
                      //  Container(
                      //   height: 50,width: 115,
                      //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Colors.grey,
                      //   ),
                      //   child: Text("women",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,
                      //   fontSize: 20
                      //   ),),
                      // ),
                      // SizedBox(width: 10,),
                      //  Container(
                      //   height: 50,width: 80,
                      //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Colors.grey,
                      //   ),
                      //   child: Text("Kids",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 20),),
                      // ),
                      // SizedBox(width: 10,),
                      //  Container(
                      //   height: 50,width: 115,
                      //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     color: Colors.grey,
                      //   ),
                      //   child: Text("Adult",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 20),),
                      // ),
                      //

                      ),
                ),

                Expanded(
                  child: providerObj.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: providerObj.newproduct.length,
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
                                          id: providerObj.newproduct[index].id.toString(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                          .newproduct[index]
                                                          .image
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          top: 3,
                                          right: 3,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                    providerObj.newproduct[index].title
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const Text(
                                    "PKR 1,190",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  )
                                ],
                              ))),
                )
                ///////////
              ],
            ),

      //
    );
  }
}
