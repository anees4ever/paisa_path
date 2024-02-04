import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa_path/src/core/theme/colors.dart';

const double controlHeight = 52;
const double controlHeightDesktop = 60;

enum EditBoxStyle {
  normal,
  highlight;
}

class EditBox extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? prefixOnClick;
  final Function()? suffixOnClick;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final bool autofocus;
  final FocusNode? focusNode;

  final double borderRadius = 4.0;

  final bool enabled;
  final bool readOnly;
  final bool expands = false;
  final bool noBorders;
  final bool selectAllOnFocus;

  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;

  final TextInputAction textInputAction;
  final TextInputAction textInputActionActual;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final TextCapitalization textCapitalization;
  final bool obscureText;
  final String obscuringCharacter;

  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;

  final double fontSize;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final String? labelText;
  final String? hintText;
  final String? errorText;

  final bool togglePassword;

  final bool autoHeight;
  final double? height;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;

  final EditBoxStyle editBoxStyle;

  const EditBox({
    super.key,
    this.controller,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.noBorders = false,
    this.selectAllOnFocus = false,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.validator,
    this.onEditingComplete,
    this.fontSize = 14,
    this.prefixIcon,
    this.prefixOnClick,
    this.suffixIcon,
    this.suffixOnClick,
    this.labelText,
    this.hintText,
    this.errorText,
    this.togglePassword = false,
    this.autoHeight = false,
    this.height,
    this.margin = const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
    this.padding = const EdgeInsets.all(1), //fromLTRB(2.0, 5.0, 2.0, 2.0),,
    this.contentPadding = const EdgeInsets.fromLTRB(6, 6, 6, 6),
    this.editBoxStyle = EditBoxStyle.normal,
  }) : textInputActionActual = keyboardType == TextInputType.multiline
            ? TextInputAction.newline
            : textInputAction;

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  bool? obscureText;
  FocusNode? _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode;
    if (widget.controller != null && widget.selectAllOnFocus) {
      _focusNode ??= FocusNode();
      _focusNode!.addListener(() {
        if (_focusNode!.hasFocus) {
          widget.controller!.selection = TextSelection(
              baseOffset: 0, extentOffset: widget.controller!.text.length);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    obscureText = obscureText ?? widget.obscureText;
    return Container(
      height: widget.autoHeight ? null : widget.height,
      margin: widget.margin,
      padding: widget.padding,
      child: TextFormField(
        controller: widget.controller,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autofocus,
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        textInputAction: widget.textInputActionActual,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        expands: widget.expands,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        textCapitalization: widget.textCapitalization,
        obscureText: obscureText ?? widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        validator: widget.validator,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          counter: const SizedBox.shrink(),
          contentPadding: widget.contentPadding,
          border: InputBorder.none,
          disabledBorder: widget.noBorders
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
          focusedErrorBorder: widget.noBorders
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[900]!, width: 1.0))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: Colors.red[900]!, width: 1.0),
                ),
          errorBorder: widget.noBorders
              ? UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[900]!, width: 1.0))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(color: Colors.red[900]!, width: 1.0),
                ),
          enabledBorder: widget.noBorders
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.editBoxStyle == EditBoxStyle.highlight
                          ? Colors.red[900]!
                          : inputBorderEnabled.theme,
                      width: 1.0))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                      color: widget.editBoxStyle == EditBoxStyle.highlight
                          ? Colors.red[900]!
                          : inputBorderEnabled.theme,
                      width: 1.0),
                ),
          focusedBorder: widget.noBorders
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange, width: 1.0))
              : OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1.5),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
          filled: false,
          fillColor: widget.noBorders ? Colors.transparent : Colors.white,
          prefixIcon: widget.prefixIcon == null
              ? null
              : IconButton(
                  icon: Icon(
                    widget.prefixIcon,
                    color: widget.enabled ? Colors.deepPurple : Colors.grey,
                    size: 20,
                  ),
                  onPressed: widget.prefixOnClick,
                ),
          suffixIcon: widget.togglePassword
              ? IconButton(
                  icon: obscureText ?? widget.obscureText
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.deepPurple,
                          size: 20,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.deepPurple,
                          size: 20,
                        ),
                  onPressed: () => setState(
                      () => obscureText = !(obscureText ?? widget.obscureText)),
                )
              : (widget.suffixIcon == null
                  ? null
                  : IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        color: widget.enabled ? Colors.deepPurple : Colors.grey,
                        size: 20,
                      ),
                      onPressed: widget.suffixOnClick,
                    )),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: widget.editBoxStyle == EditBoxStyle.highlight
                  ? Colors.red[900]!
                  : fontColor.theme,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize),
          errorText: widget.errorText,
          errorStyle: TextStyle(
              color: Colors.red[900]!,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontSize),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.editBoxStyle == EditBoxStyle.highlight
                ? Colors.red[900]!
                : fontColor.theme,
            fontSize: widget.fontSize,
          ),
        ),
        style: TextStyle(
            color: fontColor.theme,
            fontWeight: FontWeight.bold,
            fontSize: widget.fontSize),
      ),
    );
  }
}

insertTextToEditBox(
    TextEditingController controller, String textToInsert, int offset) {
  if (controller.selection.start < 0) return;
  String text = controller.text;
  TextSelection textSelection = controller.selection;
  String newText =
      text.replaceRange(textSelection.start, textSelection.end, textToInsert);
  final textLength = textToInsert.length - offset;
  controller.text = newText;
  controller.selection = textSelection.copyWith(
    baseOffset: textSelection.start + textLength,
    extentOffset: textSelection.start + textLength,
  );
}
