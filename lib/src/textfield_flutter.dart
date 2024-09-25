import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field widget that wraps [TextFormField] with additional configuration options.
///
/// This widget supports a variety of features including text validation, prefix and suffix widgets,
/// custom borders, and styling for labels and hints.
///
/// Example usage:
/// ```dart
/// TextfieldFlutter(
///   controller: _controller,
///   hintText: 'Enter text',
///   validator: (value) => value.isEmpty ? 'Field cannot be empty' : null,
///   onChanged: (value) => print('Text changed: $value'),
///   suffixWidget: Icon(Icons.visibility),
///   prefixWidget: Icon(Icons.text_fields),
///   textStyle: TextStyle(color: Colors.black),
///   errorTextStyle: TextStyle(color: Colors.red),
///   border: OutlineInputBorder(),
///   labelText: 'Label',
/// )
/// ```
class TextfieldFlutter extends StatelessWidget {
  /// Creates a [TextfieldFlutter] widget.
  const TextfieldFlutter({
    super.key,
    // Text content
    this.controller,
    this.hintText,
    this.labelText,
    this.maxLength,
    this.maxLines,

    // Behavior
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.isObscure = false,
    this.readOnly = false,
    this.enabled,
    this.autofocus = false,

    // Validation and callbacks
    this.validator,
    this.onChanged,
    this.onTap,

    // Styling
    this.textStyle,
    this.hintTextStyle,
    this.labelStyle,
    this.cursorColor,
    this.contentPadding,

    // Borders
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,

    // Widgets
    this.prefixWidget,
    this.suffixWidget,

    // Error styling
    this.errorTextStyle,
    this.errorIcon = Icons.error_sharp,
    this.errorColor = const Color(0xFFD8272D),
    this.errorIconSize = 16,

    // Input formatting
    this.inputFormatters,
    this.focusNode,
  });

  // Text content properties
  /// An optional controller for managing the text being edited. If null, the text field will be unmanaged.
  final TextEditingController? controller;

  /// An optional hint text displayed when the field is empty.
  final String? hintText;

  /// Optional text displayed above the text field as a label.
  final String? labelText;

  /// The maximum length of text that can be entered.
  final int? maxLength;

  /// The maximum number of lines to show in the text field.
  final int? maxLines;

  // Behavior properties
  /// The type of keyboard to use for input.
  final TextInputType keyboardType;

  /// Action to take when the user submits the text.
  final TextInputAction? textInputAction;

  /// Whether the text should be obscured (e.g., for passwords).
  final bool isObscure;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field is enabled or disabled.
  final bool? enabled;

  /// Whether the text field should autofocus when the widget is built.
  final bool autofocus;

  // Validation and callback properties
  /// A function to validate the input text.
  final String? Function(String val)? validator;

  /// A callback invoked when the text changes.
  final void Function(String val)? onChanged;

  /// Callback function invoked when the user taps on the text field.
  final void Function()? onTap;

  // Styling properties
  /// Style to use for the text input.
  final TextStyle? textStyle;

  /// Style to use for the hint text.
  final TextStyle? hintTextStyle;

  /// Style to use for the label text.
  final TextStyle? labelStyle;

  /// The color of the cursor.
  final Color? cursorColor;

  /// Padding around the content of the text field.
  final EdgeInsets? contentPadding;

  // Border properties
  /// The border to display around the text field.
  final InputBorder? border;

  /// The border to display when the text field is enabled.
  final InputBorder? enabledBorder;

  /// The border to display when the text field is disabled.
  final InputBorder? disabledBorder;

  /// The border to display when the text field has an error.
  final InputBorder? errorBorder;

  // Widget properties
  /// A widget displayed at the beginning of the text field.
  final Widget? prefixWidget;

  /// A widget displayed at the end of the text field.
  final Widget? suffixWidget;

  // Error styling properties
  /// Style to use for the error message text.
  final TextStyle? errorTextStyle;

  /// The icon to use for the error icon.
  final IconData errorIcon;

  /// The color of the error icon.
  final Color errorColor;

  /// The size of the error icon.
  final double errorIconSize;

  // Input formatting properties
  /// List of formatters to apply to the input.
  final List<TextInputFormatter>? inputFormatters;

  /// A focus node to control the field's focus.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: isObscure,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: isObscure ? 1 : maxLines,
      maxLength: maxLength,
      style: textStyle,
      cursorColor: cursorColor,
      inputFormatters: inputFormatters,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        contentPadding: contentPadding,
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        border: border,
        enabledBorder: enabledBorder,
        disabledBorder: disabledBorder,
        errorBorder: errorBorder,
      ),
      errorBuilder: (context, errorText) {
        return Row(
          children: [
            Icon(errorIcon, color: errorColor, size: errorIconSize),
            const SizedBox(width: 8),
            Expanded(
              child: Text(errorText, style: errorTextStyle),
            ),
          ],
        );
      },
      validator: (value) {
        if (validator != null) {
          return validator?.call(value!);
        }
        return null;
      },
    );
  }
}
