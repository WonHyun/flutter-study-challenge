import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/color.dart';

class UserInfoTextField extends StatefulWidget {
  const UserInfoTextField({
    super.key,
    this.labelText,
    this.guideText,
    this.floatingLabelText,
    this.validator,
    this.onSaved,
    this.isEnabled = true,
    this.isObscure = false,
    this.textInputType = TextInputType.none,
    this.controller,
  });

  final String? labelText;
  final String? floatingLabelText;
  final String? guideText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool isEnabled;
  final bool isObscure;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  State<UserInfoTextField> createState() => _UserInfoTextFieldState();
}

class _UserInfoTextFieldState extends State<UserInfoTextField> {
  final FocusNode _focusNode = FocusNode();
  bool hasFocus = false;

  bool _isOff() {
    if (widget.validator == null) return true;
    if (widget.validator!(widget.controller?.text) == null) {
      return false;
    } else {
      return true;
    }
  }

  String _getLabelText() {
    if (widget.labelText == null) return "";
    if (widget.floatingLabelText == null) return widget.labelText!;
    if (hasFocus || (widget.controller?.text.isNotEmpty ?? false)) {
      return widget.floatingLabelText!;
    }
    return widget.labelText!;
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      enabled: widget.isEnabled,
      obscureText: widget.isObscure,
      focusNode: _focusNode,
      controller: widget.controller,
      onChanged: (value) => setState(() => widget.validator?.call(value)),
      validator: widget.validator,
      onSaved: widget.onSaved,
      style: const TextStyle(
        color: ThemeColors.twitterColor,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 10),
        label: Text(_getLabelText()),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
        ),
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.inverseSurface,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        floatingLabelBehavior: widget.floatingLabelText == null
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto,
        hintText: widget.guideText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.5),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 5, left: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                opacity: _isOff() ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: const FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: ThemeColors.verifyColor,
                ),
              ),
            ],
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
