import 'package:flutter/material.dart';
import 'package:marketplace_design/app/constans/app_constants.dart';

class SearchField extends StatelessWidget {
  SearchField({this.onSearch, Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final Function(String value)? onSearch;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search),
        hintText: 'What are you looking for...',
      ),
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        if (onSearch != null) onSearch!(controller.text);
      },
      textInputAction: TextInputAction.search,
      style: TextStyle(
        color: Colors.grey[800],
      ),
    );
  }
}
