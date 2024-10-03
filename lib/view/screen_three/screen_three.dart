import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/screen_three_controller.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({
    super.key,
    
   //required this.imageurl, required this.name, 
   required this.id,
   // required price
    });

  @override
  // final  imageurl;
  // final name;
  final String id;

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context.read<ScreenThreeController>().getProductDetails(widget.id);
   },);
    super.initState();
  }
 // final price;
 @override
  Widget build(BuildContext context) {
    final providerObj = context.read<ScreenThreeController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details",
        style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          Icon(Icons.notification_add),
          SizedBox(width: 10,)
        ],
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           

              // Text(price)
            
            Expanded(
              child: Stack(
                             children: [
                             
                              
                               Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: NetworkImage(
                                  //  widget.imageurl
                                   // myDataList[index]["imageurl"]
                                    providerObj.ProductDetails!.image.toString()
                                    ),fit: BoxFit.cover
                                    )
                                ),
                                                     ),
                                                      Positioned(
                                top: 3,right: 3,
                                child: Container(
                                  padding: EdgeInsets.all(8  ),
                                                       decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Icon(Icons.favorite_border,color: Colors.black,),
                                                    ),
                              ),
                              
                             ],
                           ),
            ),
                         Text("",
                          //widget.name,
                         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26
                         ),),
                         Row(
                          children: [
                            Icon(Icons.star,color: Colors.yellow,size: 15,),
                            Text("4.5/5(45 reviews)",
                            style: TextStyle(
                              fontSize: 15
                            ),)
                          ],
                         ),
                         Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution"
                         ),
                         Text("choose size",
                         style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                         ),),
                         SizedBox(height: 8,),
                         Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                             // width: 25,height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: Text("S",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(width: 10,),
                             Container(
                               padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: Text("M",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                             SizedBox(width: 10,),
                             Container(
                               padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: Text("L",style: TextStyle(fontWeight: FontWeight.bold),),
                            )
                          ],
                         )
        
          ],
        ),
      ) ,
    );
  }
}