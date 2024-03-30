import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// ignore: must_be_immutable
class GenericFormBuilderTextField extends StatefulWidget {
  String name;
  String labelText;
  IconData prefixIcon;
  String? errorText;
  final void Function(String?)? onChanged;
  GenericFormBuilderTextField(
      {Key? key,
      required this.name,
      required this.labelText,
      required this.prefixIcon,
      this.errorText,
      this.onChanged})
      : super(key: key);

  @override
  State<GenericFormBuilderTextField> createState() =>
      _GenericFormBuilderTextFieldState();
}

class _GenericFormBuilderTextFieldState
    extends State<GenericFormBuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white30,
          labelText: widget.labelText,
          prefixIcon: Icon(widget.prefixIcon),
          floatingLabelStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 16.0,
              fontWeight: FontWeight.w500),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
