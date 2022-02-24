// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_taskapp_with_local_notification/screen/profile/profile_screen.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/app_bar.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/setting_widget.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  CountryStateCityPicker(
                    country: country,
                    state: state,
                    city: city,
                    textFieldInputBorder: UnderlineInputBorder(),
                  ),
                  SizedBox(height: 15),
                  LanguagePickerDropdown(
                    initialValue: Languages.english,
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (Language language) {
                      _selectedDropdownLanguage = language;
                      print(_selectedDropdownLanguage.name);
                      print(_selectedDropdownLanguage.isoCode);
                    },
                  ),
                  SizedBox(height: 30),
                  buildContent(
                    name: "Privacy",
                    icon: Icons.lock,
                    color: Colors.blue,
                    child: Container(),
                  ),
                  SizedBox(height: 15),
                  buildContent(
                    name: "Security",
                    icon: Icons.security,
                    color: Colors.red,
                    child: Container(),
                    ontap: () => Get.snackbar("Security", "Security"),
                  ),
                  SizedBox(height: 15),
                  buildContent(
                      name: "Account Info",
                      icon: Icons.text_snippet,
                      color: Colors.purple,
                      child: Container(),
                      ontap: () => Get.to(() => ProfileScreen())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Language _selectedDropdownLanguage = Languages.english;

// It's sample code of Dropdown Item.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }
}
