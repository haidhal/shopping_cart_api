import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_api/controller/cart_screen_controller.dart';
import 'package:shopping_cart_api/controller/screen_three_controller.dart';
import 'package:shopping_cart_api/controller/screen_two_controller.dart';
import 'package:shopping_cart_api/model/cart_model.dart';
import 'package:shopping_cart_api/view/screen_one/screen_one.dart';
//import 'package:shoppingcart_buttonsample_ui/view/screen_one/screen_one.dart';


Future<void> main () async {
  // hive
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); // hive step 1
  Hive.registerAdapter(CartModelAdapter());
  var box =await Hive.openBox<CartModel>("cartBox"); // hive step 2

runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context){
 return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context)=>ScreenTwoController()),
    ChangeNotifierProvider(create: (context)=>ScreenThreeController()),
    ChangeNotifierProvider(create: (context)=>CartScreenController())
  ],
   child: const MaterialApp(
    debugShowCheckedModeBanner: false,
   home: ScreenOne(),
   ),
 );
 } 
} 
