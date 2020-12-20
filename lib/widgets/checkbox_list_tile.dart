import 'package:flutter/material.dart';

class MyCheckboxListTile<T> extends StatefulWidget {
  MyCheckboxListTile(
      {Key key,
      @required this.title,
      this.subtitle,
      @required this.onChanged,
      @required this.selected,
      this.activeColor,
      this.checkColor,
      this.dense,
      this.isThreeLine = false,
      this.secondary})
      : assert(title != null),
        assert(onChanged != null),
        assert(selected != null),
        super(key: key);

  final Widget title;
  final Widget subtitle;
  final dynamic onChanged;
  final bool selected;
  final Color activeColor;
  final Color checkColor;
  final bool isThreeLine;
  final bool dense;
  final Widget secondary;

  @override
  _MyCheckboxListTileState<T> createState() => _MyCheckboxListTileState<T>();
}

class _MyCheckboxListTileState<T> extends State<MyCheckboxListTile<T>> {
  _MyCheckboxListTileState();

  bool _checked;

  @override
  void initState() {
    _checked = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _checked,
      selected: _checked,
      title: widget.title,
      subtitle: widget.subtitle,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        widget.onChanged(checked);
        setState(() {
          _checked = checked;
        });
      },
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      isThreeLine: widget.isThreeLine,
      dense: widget.dense,
      secondary: widget.secondary,
    );
  }
}
