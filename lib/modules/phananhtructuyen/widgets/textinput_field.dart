import 'package:flutter/material.dart';
import 'package:image_recovery/constants.dart';
import 'package:image_recovery/modules/phananhtructuyen/widgets/widget.dart';

class TextInputField extends StatefulWidget {
  /// Callback called when text changed
  final Function onTextChanged;

  /// Initial value you want to display
  final String initialValue;

  /// Validator for the TextFormField
  final Function validators;

  /// String displayed at hintText in TextFormField
  final String label;

  /// Change the text direction of the input (RTL / LTR)
  final TextDirection textDirection;

  /// The maximum of lines that can be display in the input
  final int maxLines;

  TextInputField(this.onTextChanged, this.initialValue,
      {this.label, this.validators, this.textDirection, this.maxLines});

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _controller = TextEditingController();
  TextSelection textSelection =
  const TextSelection(baseOffset: 0, extentOffset: 0);

  void onTap(MarkdownType type, {int titleSize = 1}) {
    final basePosition = textSelection.baseOffset;

    final result = FormatMarkdown.convertToMarkdown(type, _controller.text,
        textSelection.baseOffset, textSelection.extentOffset,
        titleSize: titleSize);

    _controller.value = _controller.value.copyWith(
        text: result.data,
        selection:
        TextSelection.collapsed(offset: basePosition + result.cursorIndex));
  }

  @override
  void initState() {
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      if (_controller.selection.baseOffset != -1)
        textSelection = _controller.selection;
      widget.onTextChanged(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: textinput_color,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: TextFormField(
        style: TextStyle(color: textinput_color),
        controller: _controller,
        cursorColor: textinput_color,
        decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
          hintText: widget.label,
          hintStyle: TextStyle(
              fontSize: 16,
              color: placholderinput_color,
              fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
        onChanged: (value) {},
      ),
    );
//    return Container(
//      decoration: BoxDecoration(
//        color: Theme.of(context).cardColor,
//        border: Border.all(color: textinput_color, width: 1),
//        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//      ),
//      child: Column(
//        children: <Widget>[
//          TextFormField(
//            textInputAction: TextInputAction.newline,
//            maxLines: widget.maxLines,
//            controller: _controller,
//            textCapitalization: TextCapitalization.sentences,
//            validator: widget.validators != null
//                ? (value) => widget.validators(value) as String
//                : null,
//            cursorColor: textinput_color,
//            style: TextStyle(color: textinput_color),
//            textDirection: widget.textDirection ?? TextDirection.ltr,
//            decoration: InputDecoration(
//              contentPadding:
//              EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
//              hintText: widget.label,
//              hintStyle: TextStyle(
//                  fontSize: 16,
//                  color: placholderinput_color,
//                  fontWeight: FontWeight.normal),
//              border: InputBorder.none,
//            ),
//          ),
//        ],
//      ),
//    );
  }
}
