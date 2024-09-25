import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textfield_flutter/src/custom_error.dart';

/// A customizable text field widget that wraps [TextFormField] with additional configuration options.
///
/// This widget supports a variety of features including text validation, prefix and suffix widgets,
/// custom borders, and styling for labels and hints.
///
/// Example usage:
/// dart
/// FlutterCustomEdit(
///   controller: _controller,  // Can be null
///   hintText: 'Enter text',
///   validator: (value) => value!.isEmpty ? 'Field cannot be empty' : null,
///   onChanged: (value) => print('Text changed: $value'),
///   suffixWidget: Icon(Icons.visibility),
///   prefixWidget: Icon(Icons.text_fields),
///   textStyle: TextStyle(color: Colors.black),
///   errorTextStyle: TextStyle(color: Colors.red),
///   border: OutlineInputBorder(),
///   labelText: 'Label',
/// )
/// 
class TextfieldFlutter extends StatefulWidget {
  /// Creates a [FlutterCustomEdit] widget.
  ///
  /// The [controller] parameter is optional and controls the text being edited.
  const TextfieldFlutter({
    super.key,
    this.hintText,
    this.controller, // Nullable
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.errorIcon = Icons.error_sharp,
    this.errorColor = const Color(0xFFD8272D),
    this.errorIconSize = 16,
    this.isObscure = false,
    this.autofocus = false,
    this.readOnly = false,
    this.focusNode,
    this.contentPadding,
    this.validator,
    this.suffixWidget,
    this.maxLines,
    this.prefixWidget,
    this.enabled,
    this.maxLength,
    this.textInputAction,
    this.errorTextStyle,
    this.textStyle,
    this.onTap,
    this.cursorColor,
    this.border,
    this.hintTextStyle,
    this.inputFormatters,
    this.labelText,
    this.disabledBorder,
    this.errorBorder,
    this.enabledBorder,
    this.labelStyle,
  });

  /// An optional hint text displayed when the field is empty.
  final String? hintText;

  /// An optional controller for managing the text being edited. If null, the text field will be unmanaged.
  final TextEditingController? controller;

  /// A callback invoked when the text changes.
  final void Function(String val)? onChanged;

  /// The type of keyboard to use for input.
  final TextInputType keyboardType;

  /// A focus node to control the field's focus.
  final FocusNode? focusNode;

  /// Padding around the content of the text field.
  final EdgeInsets? contentPadding;

  /// A function to validate the input text.
  final String? Function(String val)? validator;

  /// A widget displayed at the end of the text field.
  final Widget? suffixWidget;

  /// A widget displayed at the beginning of the text field.
  final Widget? prefixWidget;

  /// Whether the text field is enabled or disabled.
  final bool? enabled;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// The maximum number of lines to show in the text field.
  final int? maxLines;

  /// Whether the text should be obscured (e.g., for passwords).
  final bool isObscure;

  /// Whether the text field should autofocus when the widget is built.
  final bool autofocus;

  /// Action to take when the user submits the text.
  final TextInputAction? textInputAction;

  /// Style to use for the error message text.
  final TextStyle? errorTextStyle;

  /// Style to use for the text input.
  final TextStyle? textStyle;

  /// Style to use for the hint text.
  final TextStyle? hintTextStyle;

  /// Callback function invoked when the user taps on the text field.
  final void Function()? onTap;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The border to display around the text field.
  final InputBorder? border;

  /// List of formatters to apply to the input.
  final List<TextInputFormatter>? inputFormatters;

  /// The maximum length of text that can be entered.
  final int? maxLength;

  /// Optional text displayed above the text field as a label.
  final String? labelText;

  /// The border to display when the text field is disabled.
  final InputBorder? disabledBorder;

  /// The border to display when the text field has an error.
  final InputBorder? errorBorder;

  /// The border to display when the text field is enabled.
  final InputBorder? enabledBorder;

  /// Style to use for the label text.
  final TextStyle? labelStyle;

  /// The icon to user for the error icon
  final IconData errorIcon;

  /// The color of the error icon
  final Color errorColor;

  /// The size of the error icon
  final double errorIconSize;

  @override
  State<TextfieldFlutter> createState() => _TextfieldFlutterState();
}

class _TextfieldFlutterState extends State<TextfieldFlutter> {
  final _errorTextNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorTextNotifier,
      builder: (context, value, child) {
        return CustomError(
          style: widget.errorTextStyle,
          text: value,
          icon: widget.errorIcon,
          iconSize: widget.errorIconSize,
          color: widget.errorColor,
          child: TextFormField(
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            enabled: widget.enabled,
            obscureText: widget.isObscure,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            cursorColor: widget.cursorColor,
            autofocus: widget.autofocus,
            style: widget.textStyle,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              prefixIcon: widget.prefixWidget,
              suffixIcon: widget.suffixWidget,
              border: widget.border,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              disabledBorder: widget.disabledBorder,
              errorBorder: widget.errorBorder,
              enabledBorder: widget.enabledBorder,
            ),
            onChanged: (value) => widget.onChanged?.call(value),
            validator: (String? value) {
              if (widget.validator != null) {
                String? error = widget.validator!(value ?? '');
                if (error != null) {
                  _errorTextNotifier.value = widget.validator!(value ?? '');
                  return '';
                }
                _errorTextNotifier.value = widget.validator!(value ?? '');
              }
              return null;
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _errorTextNotifier.dispose();
    super.dispose();
  }
}