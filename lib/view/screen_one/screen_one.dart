import 'package:flutter/material.dart';
import 'package:shopping_cart_api/view/screen_two/screen_two.dart';
//import 'package:shoppingcart_buttonsample_ui/view/screen_two/screen_two.dart';

class ScreenOne extends StatelessWidget{
  const ScreenOne({super.key});
  Widget build(BuildContext context){
    return Scaffold(
     body:
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
        children: [
          // ElevatedButton(onPressed: (){
          //   Navigator.push(context,
          //    MaterialPageRoute(builder: (context)=> ScreenTwo()
          //    )
          //    );
          // },
          //  child: 
            Expanded(
              child: Container(
                height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(
                  "https://images.pexels.com/photos/6813473/pexels-photo-6813473.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  
                  ),
                  fit: BoxFit.cover
                  )
              ),
                      ),
            ),
          SizedBox(height: 20,),
          
         // ),
         TextButton(onPressed:  (){
            Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context)=> ScreenTwo()
             )
             );
          },
          child:
           Container(
           padding: EdgeInsets.symmetric(vertical: 20,horizontal: 70),
            
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8)
            ),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                     children: [
              Text("Get Started",
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Icon(Icons.arrow_forward_rounded,
              color: Colors.white,)
                     ],
                    ),
           )
         )
        ],
             ),
      ),
    );
  }
}