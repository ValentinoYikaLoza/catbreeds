import 'package:catbreeds/app/config/constants/app_colors.dart';
import 'package:catbreeds/app/features/shared/plugins/formx/formx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.textInputAction,
  });

  final FormxInput<String> value;
  final void Function(FormxInput<String> value) onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String value)? onFieldSubmitted;
  final bool autofocus;
  final TextInputAction? textInputAction;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  @override
  void initState() {
    super.initState();
    setValue();

    _effectiveFocusNode.addListener(() {
      if (!_effectiveFocusNode.hasFocus) {
        widget.onChanged(widget.value.touch());
      }
    });
  }

  @override
  void dispose() {
    _effectiveFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomSearchField oldWidget) {
    //actualiza el controller cada vez que el valor se actualiza desde afuera
    setValue();
    super.didUpdateWidget(oldWidget);
  }

  setValue() {
    if (widget.value.value != _controller.value.text) {
      _controller.value = _controller.value.copyWith(
        text: widget.value.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
          height: 16 / 14,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 16 / 14,
            color: AppColors.black, //otro color
          ),
          contentPadding: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 20,
            bottom: 10,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 16,
            ),
            width: 24,
            height: 24,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.black, //otro color
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        controller: _controller,
        onChanged: (value) {
          widget.onChanged(
            widget.value.updateValue(value),
          );
        },
        focusNode: _effectiveFocusNode,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autofocus: widget.autofocus,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
