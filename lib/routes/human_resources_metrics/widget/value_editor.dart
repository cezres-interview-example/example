import 'package:example/widgets/dashed_border_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HumanResourcesMetricsValueEditor extends StatelessWidget {
  const HumanResourcesMetricsValueEditor({
    super.key,
    this.width,
    this.showEditIcon = true,
    this.onDeletePressed,
    required this.onPressed,
    required this.child,
  });

  final bool showEditIcon;
  final double? width;
  final Widget child;
  final VoidCallback? onDeletePressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      child: this.child,
    );

    if (onDeletePressed == null && showEditIcon) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Image.asset(
              'assets/images/icon_text_editor.png',
              width: 16,
            ),
          ),
        ],
      );
    }

    if (width != null) {
      child = SizedBox(
        width: width,
        child: child,
      );
    } else {
      child = ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 68),
        child: Align(
          alignment: Alignment.centerRight,
          child: child,
        ),
      );
    }

    child = GestureDetector(
      onTap: onPressed,
      child: DashedBorderBox(
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.blue[50],
        borderColor: Colors.blue,
        borderRadius: BorderRadius.circular(4),
        borderWidth: 2,
        dashWidth: 4,
        dashSpace: 4,
        child: child,
      ),
    );

    if (onDeletePressed != null) {
      child = Padding(
        padding: const EdgeInsets.only(top: 6, right: 6),
        child: child,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Stack(
        children: [
          child,
          if (onDeletePressed != null)
            Positioned(
              right: 0,
              top: 0,
              child: HumanResourcesMetricsDeleteButton(
                onPressed: onDeletePressed!,
              ),
            ),
        ],
      ),
    );
  }
}

class HumanResourcesMetricsDeleteButton extends StatelessWidget {
  const HumanResourcesMetricsDeleteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xffFF5B6A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Icon(
              Icons.horizontal_rule,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class HumanResourcesMetricsEditIcon extends StatelessWidget {
  const HumanResourcesMetricsEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.edit,
      color: Colors.blue,
      size: 16,
    );
  }
}
