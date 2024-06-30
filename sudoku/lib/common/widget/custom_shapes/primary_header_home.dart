import 'package:flutter/material.dart';
import 'package:sudoku/common/widget/custom_shapes/curved_edges_widget.dart';
import 'package:sudoku/common/widget/custom_shapes/circular_container.dart';

class TPrimaryHeaderContainerHome extends StatelessWidget {
  const TPrimaryHeaderContainerHome({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color:const Color(0XFF2f6fb7),
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            //Positioned(top: -150,right: 300, child: TCircularContainer(backgroundColor:  Colors.white.withOpacity(0.1),),),
            Positioned(top: 55,right: -300, child: TCircularContainer(backgroundColor:  Colors.white.withOpacity(0.1),),),
            Positioned(top: 70,right: -340, child: TCircularContainer(backgroundColor:  Colors.white.withOpacity(0.1),),),

            Positioned(top: 65,right: 300, child: TCircularContainer(backgroundColor:  Colors.white.withOpacity(0.1),),),
            Positioned(top: 70,right: 340, child: TCircularContainer(backgroundColor:  Colors.white.withOpacity(0.1),),),

            child,
          ],
        ),

      ),
    );
  }
}