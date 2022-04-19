import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custon_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/singUp_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/my_button.dart';
import 'package:food_delivery/widgets/my_text_field.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty || phone.isEmpty || password.isEmpty || email.isEmpty) {
        Get.snackbar("Error", "All field is required");
      } else if (!GetUtils.isEmail(email)) {
        Get.snackbar("Error", "Email is wrong!");
      } else if (password.length < 6) {
        Get.snackbar("Error", "Password must be more then 6");
      } else if (phone.length != 7) {
        Get.snackbar("Error", "Phone number must be 7");
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          password: password,
          email: email,
          phone: phone,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("success");
            Get.snackbar("Success", "Registration Done");
          } else {
            Get.snackbar(
              "Error",
              status.message,
            );
          }
        });
      }
    }

    void validation() {}
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: ((_authcontroller) {
          return !_authcontroller.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      //Image logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: Dimensions.radius20 + Dimensions.radius30,
                            backgroundImage:
                                const AssetImage("assets/image/logotipo.png"),
                          ),
                        ),
                      ),
                      AppTextField(
                        textController: emailController,
                        text: "Email",
                        icon: Icons.email,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: passwordController,
                        text: "Password",
                        icon: Icons.password_outlined,
                        isObscure: true,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: nameController,
                        text: "Name",
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: phoneController,
                        text: "Phone",
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimensions.height20 * 2),
                      MyButtom(
                        text: "Sign up",
                        onTap: () => _registration(_authcontroller),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have and account already?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          text: "Sign up using one of the following methods?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.all(Dimensions.height10 - 2),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage(
                                "assets/image/" + signUpImages[index],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }),
      ),
    );
  }
}
