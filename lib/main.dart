import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/screen_two_controller.dart';
import 'package:shopping_cart_api/view/screen_one/screen_one.dart';
//import 'package:shoppingcart_buttonsample_ui/view/screen_one/screen_one.dart';


void main (){
runApp(MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 Widget build(BuildContext context){
 return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context)=>ScreenTwoController())
  ],
   child: MaterialApp(
    debugShowCheckedModeBanner: false,
   home: ScreenOne(),
   ),
 );
 } 
} 
