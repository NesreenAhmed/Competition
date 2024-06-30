import 'package:flutter/material.dart';
import 'package:sudoku/navigation_menu.dart';
import 'package:sudoku/utils/constants/sizes.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/welcome_image/Designer (16).png",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(TSizes.spaceBtwSections * 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: TSizes.spaceBtwItem,left: TSizes.spaceBtwItem),
                  child: ElevatedButton(
                    onPressed: () =>    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const NavigationMenu()),
                    ),

                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff52aaea),
                      disabledForegroundColor: Colors.grey,
                      disabledBackgroundColor: Colors.grey,
                      side: const BorderSide(color: Color(0xff52aaea),),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      textStyle: const TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      ' Let\'s Play... ',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
