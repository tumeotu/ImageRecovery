import 'package:flutter/material.dart';
import 'package:image_recovery/constants.dart';

class EditableTextInput extends StatefulWidget {
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

  EditableTextInput(this.onTextChanged, this.initialValue,
      {this.label, this.validators, this.textDirection, this.maxLines});

  @override
  _EditableTextInputState createState() => _EditableTextInputState();
}

class _EditableTextInputState extends State<EditableTextInput> {
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
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: textinput_color, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.newline,
            maxLines: widget.maxLines,
            controller: _controller,
            textCapitalization: TextCapitalization.sentences,
            validator: widget.validators != null
                ? (value) => widget.validators(value) as String
                : null,
            cursorColor: textinput_color,
            style: TextStyle(color: textinput_color),
            textDirection: widget.textDirection ?? TextDirection.ltr,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              hintText: widget.label,
              hintStyle: TextStyle(
                  fontSize: 16,
                  color: placholderinput_color,
                  fontWeight: FontWeight.normal),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class FormatMarkdown {
  /// Convert [data] part into [ResultMarkdown] from [type].
  /// Use [fromIndex] and [toIndex] for converting part of [data]
  /// [titleSize] is used for markdown titles
  static ResultMarkdown convertToMarkdown(
      MarkdownType type, String data, int fromIndex, int toIndex,
      {int titleSize = 1}) {
    String changedData;

    switch (type) {
      case MarkdownType.bold:
        changedData = '**${data.substring(fromIndex, toIndex)}**';
        break;
      case MarkdownType.italic:
        changedData = '_${data.substring(fromIndex, toIndex)}_';
        break;
      case MarkdownType.link:
        changedData =
            '[${data.substring(fromIndex, toIndex)}](${data.substring(fromIndex, toIndex)})';
        break;
      case MarkdownType.title:
        changedData =
            "${"#" * titleSize} ${data.substring(fromIndex, toIndex)}";
        break;
      case MarkdownType.list:
        var index = 0;
        final splitedData = data.substring(fromIndex, toIndex).split('\n');
        changedData = splitedData.map((value) {
          index++;
          return index == splitedData.length ? '* $value' : '* $value\n';
        }).join();
        break;
    }
    final cursorIndex = changedData.length;

    return ResultMarkdown(
        data.substring(0, fromIndex) +
            changedData +
            data.substring(toIndex, data.length),
        cursorIndex);
  }
}

class ResultMarkdown {
  /// String converted to mardown
  String data;

  /// cursor index just after the converted part in markdown
  int cursorIndex;

  /// Return [ResultMarkdown]
  ResultMarkdown(this.data, this.cursorIndex);
}

enum MarkdownType {
  /// For **bold** text
  bold,

  /// For _italic_ text
  italic,

  /// For [link](https://flutter.dev)
  link,

  /// For # Title or ## Title or ### Title
  title,

  /// For :
  ///   * Item 1
  ///   * Item 2
  ///   * Item 3
  list
}
