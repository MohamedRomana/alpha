import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SeeMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;
  final TextStyle seeMoreStyle;

  const SeeMoreText({
    super.key,
    required this.text,
    this.maxLines = 2,
    required this.textStyle,
    required this.seeMoreStyle,
  });

  @override
  State<SeeMoreText> createState() => _SeeMoreTextState();
}

class _SeeMoreTextState extends State<SeeMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_expanded) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(text: widget.text, style: widget.textStyle),
                TextSpan(
                  text: '  See less',
                  style: widget.seeMoreStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _expanded = false;
                      });
                    },
                ),
              ],
            ),
          );
        }

        final text = _getCollapsedText(widget.text, constraints.maxWidth);

        return RichText(
          maxLines: widget.maxLines,
          overflow: TextOverflow.clip,
          text: TextSpan(
            children: [
              TextSpan(text: text, style: widget.textStyle),
              TextSpan(
                text: '... See more',
                style: widget.seeMoreStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      _expanded = true;
                    });
                  },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getCollapsedText(String text, double maxWidth) {
    String result = text;

    final suffix = '... See more';

    int low = 0;
    int high = text.length;

    while (low <= high) {
      final mid = (low + high) ~/ 2;

      final testText = text.substring(0, mid);

      final painter = TextPainter(
        text: TextSpan(text: '$testText$suffix', style: widget.textStyle),
        textDirection: TextDirection.ltr,
        maxLines: widget.maxLines,
      );

      painter.layout(maxWidth: maxWidth);

      if (!painter.didExceedMaxLines) {
        result = testText;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }

    return result.trimRight();
  }
}
