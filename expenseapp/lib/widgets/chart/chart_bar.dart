import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: FractionallySizedBox(
            heightFactor: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(1),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            )),
      ),
    );
  }
}
