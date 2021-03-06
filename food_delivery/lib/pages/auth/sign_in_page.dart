import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custon_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/singUp_body.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/my_button.dart';
import 'package:food_delivery/widgets/my_text_field.dart';
import 'package:get/get.dart';

class SignIpScreen extends StatelessWidget {
  const SignIpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _registration(AuthController authController) {
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (phone.length != 7) {
        Get.snackbar("Error", "Email is wrong!");
      } else if (password.length < 6) {
        Get.snackbar("Error", "Password must be more then 6");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            Get.snackbar("Success", "Welcome");
          } else {
            Get.snackbar(
              "Error",
              status.message,
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 85, 149, 1),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.15),
                      //Image logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          /*child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius:
                                Dimensions.radius30 * 2 + Dimensions.radius30,
                            backgroundImage:
                                const AssetImage("assets/image/logo2.png"),
                          ),*/
                          child: Image(
                            image: AssetImage("assets/image/logo2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //Welcome Text
                      /* Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                              ),
                            ),
                            Text(
                              "Sign in to your account",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: phoneController,
                        text: "Phone",
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: passwordController,
                        text: "Password",
                        icon: Icons.password_outlined,
                        isObscure: true,
                      ),

                      SizedBox(height: Dimensions.screenHeight * 0.08),
                      Column(
                        children: [
                          MyButtom(
                            text: "Sign in",
                            onTap: () => _registration(authController),
                            color: Color.fromRGBO(255, 186, 49, 0.973),
                          ),
                          SizedBox(height: Dimensions.height10),
                          RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => print("Recover password?"),
                              text: "Forgot password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          text: "Don\'t have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const SignUpScreen()),
                              text: " Create",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font20 + 2,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
