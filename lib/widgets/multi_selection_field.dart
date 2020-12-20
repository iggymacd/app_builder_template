// fields/myMultiselectionField.dart ************************

import 'package:flutter/material.dart';

import 'checkbox_list_tile.dart';
import 'chip_list.dart';

class MyMultiSelectionField<T> extends StatelessWidget {
  MyMultiSelectionField({
    Key key,
    this.values,
    @required this.options,
    this.titleBuilder,
    this.subtitleBuilder,
    this.secondaryBuilder,
    @required this.chipLabelBuilder,
    this.chipAvatarBuilder,
    this.hint,
    @required this.onChanged,
    this.disabledHint,
    this.elevation = 8,
    this.style,
    this.chipLabelStyle,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.activeColor,
    this.checkColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight,
    this.autofocus = false,
    this.focusNode,
    this.focusColor,
    this.isItemdense,
    this.isItemThreeLine = false,
    this.deleteButtonTooltipMessage,
    this.chipListSpacing = 8.0,
    this.chipListAlignment = WrapAlignment.start,
    this.chipLabelPadding,
    this.chipPadding,
    this.chipDeleteIcon,
    this.chipDeleteIconColor,
    this.chipShape,
    this.chipClipBehavior = Clip.none,
    this.chipBackgroundColor,
    this.chipShadowColor,
    this.chipMaterialTapTargetSize,
    this.chipElevation,
  })  : assert(options == null ||
            options.isEmpty ||
            values == null ||
            values.every((value) =>
                options.where((T option) {
                  return option == value;
                }).length ==
                1)),
        assert(chipLabelBuilder != null),
        assert(onChanged != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(autofocus != null),
        assert(isItemThreeLine != null),
        assert(chipListSpacing != null),
        assert(chipListAlignment != null),
        assert(chipClipBehavior != null),
        super(key: key);

  final ValueChanged<List<T>> onChanged;
  final List<T> values;
  final List<T> options;
  final Widget hint;
  final Widget disabledHint;
  final Widget Function(T) titleBuilder;
  final Widget Function(T) subtitleBuilder;
  final Widget Function(T) secondaryBuilder;
  final Widget Function(T) chipLabelBuilder;
  final Widget Function(T) chipAvatarBuilder;
  final int elevation;
  final TextStyle style;
  final TextStyle chipLabelStyle;
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final Color activeColor;
  final Color checkColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color focusColor;
  final FocusNode focusNode;
  final bool autofocus;
  final bool isItemThreeLine;
  final bool isItemdense;
  final String deleteButtonTooltipMessage;
  final double chipListSpacing;
  final WrapAlignment chipListAlignment;
  final EdgeInsetsGeometry chipLabelPadding;
  final EdgeInsetsGeometry chipPadding;
  final Widget chipDeleteIcon;
  final Color chipDeleteIconColor;
  final ShapeBorder chipShape;
  final Clip chipClipBehavior;
  final Color chipBackgroundColor;
  final Color chipShadowColor;
  final MaterialTapTargetSize chipMaterialTapTargetSize;
  final double chipElevation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: null,
            items: options
                .map<DropdownMenuItem<T>>(
                  (T option) => DropdownMenuItem<T>(
                    value: option,
                    child: MyCheckboxListTile<T>(
                      selected: values.contains(option),
                      title: titleBuilder(option),
                      subtitle: subtitleBuilder != null
                          ? subtitleBuilder(option)
                          : null,
                      secondary: secondaryBuilder != null
                          ? secondaryBuilder(option)
                          : null,
                      isThreeLine: isItemThreeLine,
                      dense: isItemdense,
                      activeColor: activeColor,
                      checkColor: checkColor,
                      onChanged: (_) {
                        if (!values.contains(option)) {
                          values.add(option);
                        } else {
                          values.remove(option);
                        }
                        onChanged(values);
                      },
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (BuildContext context) {
              return options.map<Widget>((T option) {
                return Text('');
              }).toList();
            },
            hint: hint,
            onChanged: onChanged == null ? null : (T value) {},
            disabledHint: disabledHint,
            elevation: elevation,
            style: style,
            underline: underline,
            icon: icon,
            iconDisabledColor: iconDisabledColor,
            iconEnabledColor: iconEnabledColor,
            iconSize: iconSize,
            isDense: isDense,
            isExpanded: isExpanded,
            itemHeight: itemHeight,
            focusNode: focusNode,
            focusColor: focusColor,
            autofocus: autofocus,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: MyChipList<T>(
                values: values,
                spacing: chipListSpacing,
                alignment: chipListAlignment,
                chipBuilder: (T value) {
                  return Chip(
                    label: chipLabelBuilder(value),
                    labelStyle: chipLabelStyle,
                    labelPadding: chipLabelPadding,
                    avatar: chipAvatarBuilder != null
                        ? chipAvatarBuilder(value)
                        : null,
                    onDeleted: () {
                      values.remove(value);
                      onChanged(values);
                    },
                    deleteIcon: chipDeleteIcon,
                    deleteIconColor: chipDeleteIconColor,
                    deleteButtonTooltipMessage: deleteButtonTooltipMessage,
                    shape: chipShape,
                    clipBehavior: chipClipBehavior,
                    backgroundColor: chipBackgroundColor,
                    padding: chipPadding,
                    materialTapTargetSize: chipMaterialTapTargetSize,
                    elevation: chipElevation,
                    shadowColor: chipShadowColor,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
