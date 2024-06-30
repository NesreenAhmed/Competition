import 'package:flutter/material.dart';
import 'package:sudoku/common/widget/custom_shapes/primary_header_home.dart';
import 'package:sudoku/screens/home_appbar.dart';
import 'package:sudoku/utils/constants/sizes.dart';
import 'package:sudoku/screens/game_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainerHome(
              child: Column(
              children: [
                THomeAppBar(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(height: TSizes.spaceBtwSections,),

              ],
            ),
            ),

            const Stack(
              children: [
                  Image(
                   image: AssetImage("assets/images/welcome_image/Designer__30_-removebg-preview.png"),
                 height: 200,),
                Padding(padding: EdgeInsets.only(left:115,top: 60
                ),
                  child: Image(
                    image: AssetImage("assets/images/welcome_image/Designer__22_-removebg-preview.png",
                  ),
                    width: 200,
                    height: 300,
                  ),
                )
              ],
            ),

            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const SudokuGamePage(level: 'Easy')),
              ),
              child: const Text(' Easy '),
            ),
            const SizedBox(height: TSizes.spaceBtwItem,),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const SudokuGamePage(level: 'Medium')),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 80),
              ),
              child: const Text(' Medium '),
            ),
            const SizedBox(height: TSizes.spaceBtwItem,),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const SudokuGamePage(level: 'Hard')),
              ),
              child: const Text(' Hard '),
            ),
          ],
        ),
      ),
    );
  }
}
