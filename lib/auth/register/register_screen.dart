import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/providers/auth_user_provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register_screen';
  TextEditingController nameController = TextEditingController(text: "Menna");
  TextEditingController emailController = TextEditingController(text: "menna@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "12345678");
  TextEditingController confirmPasswordController = TextEditingController(text: "12345678");
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundLightColor,
            child: Image.asset('assets/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create Account',
            style: TextStyle(
              color: AppColors.whiteColor
            ),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: FormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                    ),
                    CustomTextFormField(label: 'Username',
                    controller: nameController,
                    validator:  (text){
                      if(text == null || text.trim().isEmpty){
                        return "Please enter your username";
                      }
                      return null;
                    }
                    ),
                    CustomTextFormField(label: "Email",
                    controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:  (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter your email";
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if(!emailValid){
                            return "Please enter valid email.";
                          }
                          return null;
                        }),
                    CustomTextFormField(label: 'Password',
                    controller: passwordController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator:  (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter your password";
                          }
                          if(text.length < 6){
                            return "Password should be at least 6 chars. ";
                          }
                          return null;
                        }),
                    CustomTextFormField(label: "Confirm Password",
                    controller: confirmPasswordController,
                        keyboardType: TextInputType.phone,
                        obscureText: true,
                        validator:  (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter your confirm password";
                          }
                          if(text != passwordController.text){
                            return "Confirm password doesn't match password.";
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        register(context);
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          child: Text('Create Account' ,
                          style: Theme.of(context).textTheme.titleLarge,)),
                    )
                  ],
                ),
              )
          ),
        )
      ],
    );
  }

  void register(BuildContext context) async {
    if(FormKey.currentState?.validate() == true){
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text
        );

        var authProvider = Provider.of<AuthUserProvider>(context , listen: false);
        authProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);


        DialogUtils.hideLoading(context);


        DialogUtils.showMessage(context: context, content: "Register Successfully."
        ,title: "Success" , posActionName: "Ok" ,
        posAction: (){
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
        print("Register Successfully.");
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {

          DialogUtils.hideLoading(context);


          DialogUtils.showMessage(context: context,
              content: "The password provided is too weak.",
              title: "Error" , posActionName: "Ok");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {

          DialogUtils.hideLoading(context);


          DialogUtils.showMessage(context: context,
              content: "The account already exists for that email."
              ,title: "Error" , posActionName: "Ok");
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);


        DialogUtils.showMessage(context: context,
            content: e.toString()
            ,title: "Error" , posActionName: "Ok");
        print(e);
      }

    }
  }
}
