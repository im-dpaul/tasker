import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/core/theme/app_colors.dart';
import 'package:tasker/core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// align text in input field
  final TextAlign? textAlign;

  ///focuse node of input filed
  final FocusNode? focusNode;

  /// List of auto fill hints.
  final Iterable<String>? autoFillHints;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether to enable autocorrect. Defaults to true.
  final bool autocorrect;

  /// Whether the text field should be read-only. Defaults to false.
  final bool readOnly;

  /// Whether this text field should focus itself if nothing else is already focused. Defaults to false. Cannot be null.
  final bool autofocus;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// Text that suggests what sort of input the field accepts.
  final String? labelText;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text style that suggests what sort of style will be applied on hint text.
  final TextStyle? hintStyle;

  /// Text that appears below the field.
  final String? errorText;

  /// A widget that appears before the editable part of the text field.
  final Widget? prefix;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  final TextInputType? keyboardType;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// Called for each tap that occurs outside of the[TextFieldTapRegion] group when the text field is focused.
  final void Function(PointerDownEvent)? onTapOutside;

  /// Called when the text field has been tapped.
  final VoidCallback? onTap;

  /// type of border for input field
  final InputBorder? border;

  ///focused border of input filed
  final InputBorder? focusedBorder;

  /// type of border for input field when it is enabled
  final InputBorder? enabledBorder;

  /// Color of cursor
  final Color? cursorColor;

  /// The maximum number of lines to show at one time, wrapping if necessary.
  ///
  /// If this is 1 (the default), the text will not wrap, but will scroll horizontally instead.
  ///
  /// If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered, up to the height of its constraints.
  final int? maxLines;

  /// This value must be either null, [TextField.noMaxLength], or greater than 0. If null (the default) then there is no limit to the number of characters that can be entered.
  ///
  ///  If set to a number greater than 0, it will also display the maximum number allowed.
  final int? maxLength;

  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.textAlign,
    this.autoFillHints,
    this.inputFormatters,
    this.autocorrect = true,
    this.readOnly = false,
    this.autofocus = false,
    this.border,
    this.keyboardType,
    this.cursorColor,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onTapOutside,
    this.style,
    this.hintText,
    this.errorText,
    this.prefix,
    this.labelText,
    this.suffix,
    this.enabledBorder,
    this.focusedBorder,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final InputBorder textFieldBorder = border ?? InputBorder.none;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          textAlign: textAlign ?? TextAlign.start,
          autofillHints: autoFillHints,
          inputFormatters: inputFormatters,
          autocorrect: autocorrect,
          autofocus: autofocus,
          readOnly: readOnly,
          keyboardType: keyboardType,
          cursorColor: cursorColor ?? AppColors.smokyGrey,
          style: style ?? AppTextStyles.f14w600TextBlack,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ??
                AppTextStyles.f14w400TextBlack
                    .copyWith(color: AppColors.smokyGrey),
            errorText: errorText,
            prefixIcon: prefix,
            labelText: labelText,
            labelStyle: AppTextStyles.f14w600TextBlack,
            prefixIconColor: AppColors.smokyGrey,
            suffixIcon: suffix,
            border: textFieldBorder,
            focusedBorder: focusedBorder ?? textFieldBorder,
            enabledBorder: enabledBorder ?? textFieldBorder,
            filled: true,
            isDense: true,
            fillColor: AppColors.white,
          ),
          onTap: onTap,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onTapOutside: onTapOutside,
        ),
      ],
    );
  }
}
