import 'package:flutter/widgets.dart';

class Unfocus extends StatelessWidget {
  final Widget child;
  const Unfocus({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}
