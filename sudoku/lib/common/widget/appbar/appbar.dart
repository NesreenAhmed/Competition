import 'package:flutter/material.dart';
import 'package:sudoku/utils/constants/sizes.dart';
import 'package:sudoku/utils/constants/device_utilty.dart';


class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.leadingOnPressed,
        this.actions});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.md,
      ),
      child: AppBar(
        backgroundColor: Color(0XFF2f6fb7),
        actions: actions,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          onPressed: () {
            if (leadingOnPressed != null) {
              leadingOnPressed!(); // Navigate back when onPressed is provided
            } else {
              Navigator.of(context).pop(); // Default behavior to pop the current screen
            }
          },
          icon:Icon(Icons.chevron_left,color: Colors.black,),
        )
            : leadingIcon != null
            ? IconButton(
          onPressed: leadingOnPressed,
          icon: Icon(leadingIcon),
        )
            : null,
        title: title,

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
