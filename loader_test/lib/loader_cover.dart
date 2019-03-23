import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showLoaderDialog({
  @required BuildContext context,
  @required String loadingText,
}) {
  assert(context != null);
  assert(loadingText != null);
  return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Color(0x80000000),
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (context, startAnim, endAnim) {
        return LoaderCover(
          loadingText: loadingText,
        );
      });
}

class LoaderCover extends StatelessWidget {
  final String loadingText;

  LoaderCover({
    Key key,
    @required this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final isiOS = () => Theme.of(context).platform == TargetPlatform.iOS;
    return Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: isiOS()
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  loadingText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
