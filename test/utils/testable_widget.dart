import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _Wrapper extends StatelessWidget {
  final Widget child;

  const _Wrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(
        constraints,
        designSize: const Size(411, 744), //width and height from figma
      );
      return child;
    });
  }
}

Widget testableWidget({required Widget child}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
      home: _Wrapper(child),
    ),
  );
}
