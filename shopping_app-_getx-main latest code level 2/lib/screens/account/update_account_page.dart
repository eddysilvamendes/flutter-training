
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/base/go_to_sign_in_page.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/widgets/app_text_field.dart';

import '../../base/custom_button.dart';
import '../../base/custom_image.dart';
import '../../base/custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/splash_controller.dart';
import '../../controllers/user_controller.dart';
import 'package:get/get.dart';

import '../../models/response_model.dart';
import '../../models/user_info_model.dart';
import '../../uitls/app_dimensions.dart';
import '../../uitls/styles.dart';
class UpdateAccountPage extends StatefulWidget {
  @override
  State<UpdateAccountPage> createState() => _UpdateAccountPageState();
}

class _UpdateAccountPageState extends State<UpdateAccountPage> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<UserController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text("Update profile"),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(onPressed: ()=>Get.offNamed(RouteHelper.getAccountPage()),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height:800,
        child: GetBuilder<UserController>(builder: (userController) {

          print("my image is "+'${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}');
          if(userController.userInfoModel != null && _phoneController.text.isEmpty) {
            _firstNameController.text = userController.userInfoModel?.fName ?? '';
            _phoneController.text = userController.userInfoModel?.phone ?? '';
            _emailController.text = userController.userInfoModel?.email ?? '';
          }

          return _isLoggedIn ? userController.userInfoModel != null ? Column(
           // print("Image "+('${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}').toString());
           children: [
             SizedBox(
               height: 10,
             ),
             Center(child: Stack(children: [
               ClipOval(child: userController.pickedFile != null ? GetPlatform.isWeb ? Image.network(
                 userController.pickedFile!.path, width: 100, height: 100, fit: BoxFit.cover,
               ) : Image.file(
                 File(userController.pickedFile!.path), width: 100, height: 100, fit: BoxFit.cover,
               ): CustomImage(
                 image: '${Get.find<SplashController>().configModel?.baseUrls?.customerImageUrl}/${userController.userInfoModel?.image}',
                 height: 100, width: 100, fit: BoxFit.cover, placeholder: '',
               )),
               Positioned(
                 bottom: 0, right: 0, top: 0, left: 0,
                 child: InkWell(
                   onTap: () => userController.pickImage(),
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                       border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                     ),
                     child: Container(
                       margin: EdgeInsets.all(25),
                       decoration: BoxDecoration(
                         border: Border.all(width: 2, color: Colors.white),
                         shape: BoxShape.circle,
                       ),
                       child: Icon(Icons.camera_alt, color: Colors.white),
                     ),
                   ),
                 ),
               ),
             ])),
             Expanded(

               child: Scrollbar(

                 child: SingleChildScrollView(
                   physics:BouncingScrollPhysics(),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Text(
                           'Your name',
                           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                         ),
                         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                         AppTextField(hintText: "Name", textController: _firstNameController, icon: Icons.phone,),
                         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                         Text(
                           'email',
                           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                         ),
                         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                         AppTextField(hintText: "Email", textController: _emailController, icon: Icons.email,),

                         SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                         Row(children: [
                           Text(
                             'phone',
                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                           ),
                           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                           Text('(${'non_changeable'})', style: robotoRegular.copyWith(
                             fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).errorColor,
                           )),
                         ]),
                         SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                         AppTextField(readOnly:true,hintText: "Phone", textController: _phoneController, icon: Icons.phone,),


                     SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                     !userController.isLoading ? CustomButton(
                       onPressed: () => _updateProfile(userController),
                       margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                       buttonText: 'update',
                     ) : Center(child: CircularProgressIndicator()),

                   ]),
                 ),
               ),
             ),
           ],
          ) : Center(child: CircularProgressIndicator()) : GoToSignInPage();
        }),
      ),
    );
  }

  void _updateProfile(UserController userController) async {
    String _firstName = _firstNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    if (userController.userInfoModel?.fName == _firstName &&

        userController.userInfoModel?.email == _emailController.text && userController.pickedFile == null) {
      showCustomSnackBar('change_something_to_update');
    }else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name');
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address');
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address');
    }else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number');
    }else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number');
    } else {
      UserInfoModel _updatedUser = UserInfoModel(fName: _firstName,  email: _email, phone: _phoneNumber);
      ResponseModel _responseModel = await userController.updateUserInfo(_updatedUser, Get.find<AuthController>().getUserToken());
      if(_responseModel.isSuccess) {
        showCustomSnackBar('Profile updated successfully', isError: false, title: "Success");
        //Get.offNamed(RouteHelper.getAccountPage());
      }else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}
