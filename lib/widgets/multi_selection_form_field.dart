// formFields/myMultiselectionFormField.dart ********************

import 'package:flutter/material.dart';

import 'multi_selection_field.dart';

class MyMultiSelectionFormField<T> extends FormField<List<T>> {
  MyMultiSelectionFormField({
    Key key,
    @required List<T> initialValues,
    @required List<T> options,
    @required Widget Function(T) titleBuilder,
    Widget Function(T) subtitleBuilder,
    Widget Function(T) secondaryBuilder,
    @required Widget Function(T) chipLabelBuilder,
    Widget Function(T) chipAvatarBuilder,
    Widget hint,
    this.decoration = const InputDecoration(),
    this.onChanged,
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    bool autovalidate = false,
    Widget disabledHint,
    int elevation = 8,
    TextStyle style,
    TextStyle chipLabelStyle,
    Widget underline,
    Widget icon,
    Color iconDisabledColor,
    Color iconEnabledColor,
    Color activeColor,
    Color checkColor,
    double iconSize = 24.0,
    bool isDense = false,
    bool isExpanded = false,
    double itemHeight,
    bool autofocus = false,
    FocusNode focusNode,
    Color focusColor,
    bool isItemdense,
    bool isItemThreeLine = false,
    String deleteButtonTooltipMessage,
    double chipListSpacing = 8.0,
    WrapAlignment chipListAlignment = WrapAlignment.start,
    EdgeInsetsGeometry chipLabelPadding,
    EdgeInsetsGeometry chipPadding,
    Widget chipDeleteIcon,
    Color chipDeleteIconColor,
    ShapeBorder chipShape,
    Clip chipClipBehavior = Clip.none,
    Color chipBackgroundColor,
    Color chipShadowColor,
    MaterialTapTargetSize chipMaterialTapTargetSize,
    double chipElevation,
  })  : assert(
          options == null ||
              options.isEmpty ||
              initialValues == null ||
              initialValues.every((value) =>
                  options.where((T option) {
                    return option == value;
                  }).length ==
                  1),
          'There should be exactly one item with [DropdownButton]\'s value: '
          '$initialValues. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        assert(decoration != null),
        assert(elevation != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(itemHeight == null || itemHeight > 0),
        assert(autofocus != null),
        assert(isItemThreeLine != null),
        assert(chipListSpacing != null),
        assert(chipListAlignment != null),
        assert(chipClipBehavior != null),
        super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValues,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<List<T>> field) {
            final InputDecoration effectiveDecoration =
                decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: field.errorText),
              isEmpty: field.value.isEmpty,
              isFocused: focusNode?.hasFocus,
              child: MyMultiSelectionField<T>(
                values: field.value,
                options: options,
                titleBuilder: titleBuilder,
                subtitleBuilder: subtitleBuilder,
                secondaryBuilder: secondaryBuilder,
                chipLabelBuilder: chipLabelBuilder,
                chipAvatarBuilder: chipAvatarBuilder,
                hint: field.value.isNotEmpty ? hint : null,
                onChanged: field.didChange,
                disabledHint: disabledHint,
                elevation: elevation,
                style: style,
                chipLabelStyle: chipLabelStyle,
                underline: underline,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                activeColor: activeColor,
                checkColor: checkColor,
                iconSize: iconSize,
                isDense: isDense,
                isExpanded: isExpanded,
                itemHeight: itemHeight,
                focusNode: focusNode,
                focusColor: focusColor,
                autofocus: autofocus,
                isItemdense: isItemdense,
                isItemThreeLine: isItemThreeLine,
                deleteButtonTooltipMessage: deleteButtonTooltipMessage,
                chipListSpacing: chipListSpacing,
                chipListAlignment: chipListAlignment,
                chipLabelPadding: chipLabelPadding,
                chipPadding: chipPadding,
                chipDeleteIcon: chipDeleteIcon,
                chipDeleteIconColor: chipDeleteIconColor,
                chipShape: chipShape,
                chipClipBehavior: chipClipBehavior,
                chipBackgroundColor: chipBackgroundColor,
                chipShadowColor: chipShadowColor,
                chipMaterialTapTargetSize: chipMaterialTapTargetSize,
                chipElevation: chipElevation,
              ),
            );
          },
        );

  final ValueChanged<List<T>> onChanged;

  final InputDecoration decoration;

  @override
  FormFieldState<List<T>> createState() => _MyMultiSelectionFormFieldState<T>();
}

class _MyMultiSelectionFormFieldState<T> extends FormFieldState<List<T>> {
  @override
  MyMultiSelectionFormField<T> get widget => super.widget;

  @override
  void didChange(List<T> values) {
    super.didChange(values);
    if (this.hasError) {
      this.validate();
    }
    if (widget.onChanged != null) {
      widget.onChanged(values);
    }
  }
}
