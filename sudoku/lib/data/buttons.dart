import 'package:flutter/material.dart';
import 'package:sudoku/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sudoku/data/play_button_container.dart';


class TButtons extends StatelessWidget {
  final Function(int?) onNumberSelected;
  final VoidCallback undoLastMove ;
  final VoidCallback restartGame;
  final VoidCallback hint;
   const TButtons({super.key,required this.onNumberSelected,required this.undoLastMove,required this.restartGame,required this.hint});

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          const Padding(padding: EdgeInsets.all(TSizes.spaceBtwItem*1.2)),
          TPlayButtonContainer(onTap: undoLastMove, icon: Iconsax.undo4, text: 'Undo'),

          const SizedBox(width: TSizes.spaceBtwItem,),
          TPlayButtonContainer(onTap: () => onNumberSelected(null), icon: Iconsax.eraser, text: 'Eraser'),


          const SizedBox(width: TSizes.spaceBtwItem,),
          TPlayButtonContainer(onTap: restartGame, icon:Icons.restart_alt_sharp, text: 'Restart'),

          const SizedBox(width: TSizes.spaceBtwItem,),
          TPlayButtonContainer(onTap: hint, icon:Icons.lightbulb_outline_rounded, text: 'Hint'),
        ],
      );
  }
}
