import 'package:chat_app/widgets/date_form_field.dart';
import 'package:chat_app/widgets/multi_selection_form_field.dart';
import 'package:chat_app/widgets/text_form_field.dart';
import 'package:chat_app/widgets/toggle_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Gender {
  Male,
  Female,
  Other,
}

enum Interest {
  Sports,
  Tech,
  Games,
  Mentoring,
  Art,
  Travel,
  Music,
  Reading,
  Cooking,
  Blogging
}

class SignupUser {
  String name;
  Gender gender;
  DateTime birthdate;
  List<Interest> interests;
  bool ethicsAgreement;

  SignupUser({
    this.name,
    this.gender,
    this.birthdate,
    List<Interest> interests,
    this.ethicsAgreement = false,
  }) {
    this.interests = interests ?? [];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender.toString(),
        'birthdate': birthdate.toString(),
        'interests': interests.toString(),
        'ethicsAgreement': ethicsAgreement,
      };
}

class MyHomePageOne extends StatefulWidget {
  MyHomePageOne({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageStateOne createState() => _MyHomePageStateOne();
}

class _MyHomePageStateOne extends State<MyHomePageOne> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _formResult = SignupUser();

  final nameFocusNode = FocusNode();
  final genderFocusNodes = [FocusNode(), FocusNode(), FocusNode()];
  final birthdateFocusNodes = [FocusNode(), FocusNode(), FocusNode()];
  final interestsFocusNode = FocusNode();
  final ethicsAgreementFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              MyTextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                initialValue: _formResult.name,
                validator: (userName) {
                  if (userName.isEmpty) {
                    return 'Name is required';
                  }
                  if (userName.length < 3) {
                    return 'Name is too short';
                  }
                  return null;
                },
                onSaved: (userName) {
                  _formResult.name = userName;
                },
                autofocus: true,
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
              ),
              SizedBox(height: 8.0),
              MyToggleButtonsFormField<Gender>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                initialValue: _formResult.gender,
                items: Gender.values,
                itemBuilder: (BuildContext context, Gender genderItem) =>
                    Text(describeEnum(genderItem)),
                selectedItemBuilder:
                    (BuildContext context, Gender genderItem) =>
                        Text(describeEnum(genderItem)),
                validator: (gender) =>
                    gender == null ? 'Gender is required' : null,
                onSaved: (gender) {
                  _formResult.gender = gender;
                },
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                focusNodes: genderFocusNodes,
                onChanged: (gender) {
                  final genderIndex = Gender.values.indexOf(gender);
                  if (genderIndex >= 0) {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context)
                        .requestFocus(genderFocusNodes[genderIndex]);
                  }
                },
              ),
              SizedBox(height: 8.0),
              MyDateFormField(
                decoration: const InputDecoration(
                  labelText: 'Birthdate',
                ),
                validator: (birthdate) {
                  if (birthdate == null) {
                    return 'A valid birthdate is required';
                  }
                  final now = DateTime.now();
                  if (birthdate.isAfter(now)) {
                    return 'You are not born yet !';
                  }
                  const MAX_AGE = 99;
                  if (birthdate
                      .isBefore(now.subtract(Duration(days: 365 * MAX_AGE)))) {
                    return 'Select a more recent date';
                  }
                  const MIN_AGE = 18;
                  if (birthdate
                      .isAfter(now.subtract(Duration(days: 365 * MIN_AGE)))) {
                    return 'Only adults are allowed';
                  }
                  return null;
                },
                onSaved: (birthdate) {
                  _formResult.birthdate = birthdate;
                },
                dayFocusNode: birthdateFocusNodes[0],
                dayOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[0]);
                },
                monthFocusNode: birthdateFocusNodes[1],
                monthOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[1]);
                },
                yearFocusNode: birthdateFocusNodes[2],
                yearOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[2]);
                },
              ),
              SizedBox(height: 8.0),
              MyMultiSelectionFormField<Interest>(
                decoration: InputDecoration(
                  labelText: 'Interests',
                ),
                hint: Text('Select more interests'),
                isDense: true,
                focusNode: interestsFocusNode,
                options: Interest.values,
                titleBuilder: (interest) => Text(describeEnum(interest)),
                chipLabelBuilder: (interest) => Text(describeEnum(interest)),
                initialValues: _formResult.interests,
                validator: (interests) => interests.length < 3
                    ? 'Please select at least 3 interests'
                    : null,
                onSaved: (interests) {
                  _formResult.interests = interests;
                },
                onChanged: (_) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(interestsFocusNode);
                },
              ),
              SizedBox(height: 8.0),
              MySwitchFormField(
                decoration: InputDecoration(
                  labelText: 'Ethics agreement',
                  hintText: null,
                ),
                focusNode: ethicsAgreementFocusNode,
                initialValue: _formResult.ethicsAgreement,
                validator: (userHasAgreedWithEthics) =>
                    userHasAgreedWithEthics == false
                        ? 'Please agree with ethics'
                        : null,
                onSaved: (userHasAgreedWithEthics) {
                  _formResult.ethicsAgreement = userHasAgreedWithEthics;
                },
                onChanged: (_) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(ethicsAgreementFocusNode);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Save',
        child: Icon(
          Icons.check,
          size: 36.0,
        ),
      ),
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      print('New user saved with signup data:\n');
      print(_formResult.toJson());
    }
  }
}

// formFields/mySwitchFormField.dart ********************

class MySwitchFormField extends FormField<bool> {
  MySwitchFormField({
    Key key,
    bool initialValue,
    this.decoration = const InputDecoration(),
    this.onChanged,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool autovalidate = false,
    this.constraints = const BoxConstraints(),
    Color activeColor,
    Color activeTrackColor,
    Color inactiveThumbColor,
    Color inactiveTrackColor,
    ImageProvider<dynamic> activeThumbImage,
    ImageProvider<dynamic> inactiveThumbImage,
    MaterialTapTargetSize materialTapTargetSize,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color focusColor,
    Color hoverColor,
    FocusNode focusNode,
    bool autofocus = false,
  })  : assert(decoration != null),
        assert(initialValue != null),
        assert(autovalidate != null),
        assert(autofocus != null),
        assert(dragStartBehavior != null),
        assert(constraints != null),
        super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<bool> field) {
            final InputDecoration effectiveDecoration =
                decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: field.errorText),
              isEmpty: field.value == null,
              isFocused: focusNode?.hasFocus,
              child: Row(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: constraints,
                    child: Switch(
                      value: field.value,
                      onChanged: field.didChange,
                      activeColor: activeColor,
                      activeTrackColor: activeTrackColor,
                      inactiveThumbColor: inactiveThumbColor,
                      inactiveTrackColor: inactiveTrackColor,
                      activeThumbImage: activeThumbImage,
                      inactiveThumbImage: inactiveThumbImage,
                      materialTapTargetSize: materialTapTargetSize,
                      dragStartBehavior: dragStartBehavior,
                      focusColor: focusColor,
                      hoverColor: hoverColor,
                      focusNode: focusNode,
                      autofocus: autofocus,
                    ),
                  ),
                ],
              ),
            );
          },
        );

  final ValueChanged<bool> onChanged;
  final InputDecoration decoration;
  final BoxConstraints constraints;

  @override
  FormFieldState<bool> createState() => _MySwitchFormFieldState();
}

class _MySwitchFormFieldState extends FormFieldState<bool> {
  @override
  MySwitchFormField get widget => super.widget;

  @override
  void didChange(bool value) {
    super.didChange(value);
    if (this.hasError) {
      this.validate();
    }
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}

// formFields/myToggleButtonsFormField.dart ********************

class MyToggleButtonsFormField<T> extends FormField<T> {
  MyToggleButtonsFormField({
    Key key,
    this.initialValue,
    @required this.items,
    @required this.itemBuilder,
    @required this.selectedItemBuilder,
    this.decoration = const InputDecoration(),
    this.onChanged,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    bool autovalidate = false,
    TextStyle textStyle,
    BoxConstraints constraints,
    Color color,
    Color selectedColor,
    Color disabledColor,
    Color fillColor,
    Color focusColor,
    Color highlightColor,
    Color hoverColor,
    Color splashColor,
    List<FocusNode> focusNodes,
    bool renderBorder = true,
    Color borderColor,
    Color selectedBorderColor,
    Color disabledBorderColor,
    BorderRadius borderRadius,
    double borderWidth,
  })  : assert(decoration != null),
        assert(renderBorder != null),
        assert(autovalidate != null),
        assert(items != null),
        assert(itemBuilder != null),
        assert(selectedItemBuilder != null),
        assert(initialValue == null || items.contains(initialValue)),
        super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration =
                decoration.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: field.errorText),
              isFocused: focusNodes?.any((focusNode) => focusNode.hasFocus),
              child: MyToggleButtons(
                items: items,
                value: field.value,
                itemBuilder: itemBuilder,
                selectedItemBuilder: selectedItemBuilder,
                onPressed: field.didChange,
                textStyle: textStyle,
                constraints: constraints,
                color: color,
                selectedColor: selectedColor,
                disabledColor: disabledColor,
                fillColor: fillColor,
                focusColor: focusColor,
                highlightColor: highlightColor,
                hoverColor: hoverColor,
                splashColor: splashColor,
                focusNodes: focusNodes,
                renderBorder: renderBorder,
                borderColor: borderColor,
                selectedBorderColor: selectedBorderColor,
                disabledBorderColor: disabledBorderColor,
                borderRadius: borderRadius,
                borderWidth: borderWidth,
              ),
            );
          },
        );

  final List<T> items;
  final ValueChanged<T> onChanged;
  final T initialValue;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(BuildContext, T) selectedItemBuilder;
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _MyToggleButtonsFormFieldState<T>();
}

class _MyToggleButtonsFormFieldState<T> extends FormFieldState<T> {
  @override
  MyToggleButtonsFormField<T> get widget => super.widget;

  @override
  void didChange(T value) {
    super.didChange(value);
    if (this.hasError) {
      this.validate();
    }
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }
}
