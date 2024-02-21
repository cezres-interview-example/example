import 'package:flutter/material.dart';

class HumanResourcesMetricsCard extends StatelessWidget {
  const HumanResourcesMetricsCard({
    super.key,
    required this.title,
    this.subTitle,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 8,
    ),
    this.child,
  });

  final String title;
  final String? subTitle;
  final EdgeInsets padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text(title),
                ),
              ),
              if (subTitle != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      subTitle!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (child != null) child!,
      ],
    );
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.grey[300]!,
      ),
      borderRadius: BorderRadius.circular(8),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: padding,
        decoration: decoration,
        child: content,
      ),
    );
  }
}
