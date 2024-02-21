import 'package:flutter/material.dart';

Future<dynamic> showGlobalBottomSheet(BuildContext context,
    {required Widget child}) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GlobalBottomSheetDialog(animation: animation, child: child);
      },
    ),
  );
}

class GlobalBottomSheetDialog extends StatelessWidget {
  const GlobalBottomSheetDialog({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: AnimatedBuilder(
          animation: animation,
          child: SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          builder: (context, child) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4 * animation.value),
              ),
              child: Transform.translate(
                offset: Offset(0, 50 - 50 * animation.value),
                child: Opacity(
                  opacity: animation.value,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
