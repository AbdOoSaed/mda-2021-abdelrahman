import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShowProgress extends StatelessWidget {
  const ShowProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      return Center(
        child: (defaultTargetPlatform == TargetPlatform.iOS)
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      );
    });
  }
}
