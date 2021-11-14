import 'package:flutter/material.dart';
import 'package:gas_station_finder/extensions/extensions.dart';

class YesNoAlertDialog extends StatelessWidget {
  final String? titleText;
  final String? contentText;
  final String? yesBtnText;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

  const YesNoAlertDialog({
    Key? key,
    @required this.titleText,
    this.contentText,
    @required this.onYesPressed,
    this.onNoPressed,
    this.yesBtnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(width: 16),
                Flexible(
                  child: Text(titleText ?? ''),
                ),
              ],
            ).addPaddingOnly(top: 18, bottom: 12),
            Container(
              height: 0.6,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFA0A0B3).withOpacity(0.35),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      return onNoPressed?.call();
                    },
                    child: const Text('No')
                        .addPaddingHorizontalVertical(horizontal: 18),
                  ),
                  const VerticalDivider(),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      onYesPressed?.call();
                    },
                    child: Text(
                      yesBtnText ?? 'yes',
                    ).addPaddingHorizontalVertical(horizontal: 18),
                  ),
                ],
              ),
            ),
          ],
        ).addPaddingHorizontalVertical(horizontal: 20),
      ),
    );
  }
}
