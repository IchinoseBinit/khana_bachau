import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khana_bachau_app/main.dart';
import 'package:khana_bachau_app/screens/navigation_screen.dart';
import 'package:khana_bachau_app/widgets/general_elevated_button.dart';
import 'package:khana_bachau_app/widgets/general_text_button.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '/constants/constants.dart';
import '/models/firebase_user.dart';
import '/providers/user_provider.dart';
import '/screens/finger_print_auth_screen.dart';
import '/screens/home_screen.dart';
import '/screens/register_screen.dart';
import '/utils/size_config.dart';
import '/utils/validation_mixin.dart';
import '/widgets/general_alert_dialog.dart';
import '/widgets/general_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen(this.canCheckBioMetric, {Key? key}) : super(key: key);

  final bool canCheckBioMetric;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: basePadding,
        child: SingleChildScrollView(
          child: AutofillGroup(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    ImageConstants.logoWithName,
                    width: SizeConfig.width * 40,
                    height: SizeConfig.height * 25,
                  ),
                  SizedBox(
                    height: SizeConfig.height,
                  ),
                  GeneralTextField(
                    title: "Email",
                    autoFillhints: const [AutofillHints.email],
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validate: (value) =>
                        ValidationMixin().validateEmail(value!),
                    onFieldSubmitted: (_) {},
                  ),
                  SizedBox(
                    height: SizeConfig.height * 2,
                  ),
                  GeneralTextField(
                    title: "Password",
                    autoFillhints: const [AutofillHints.password],
                    isObscure: true,
                    controller: passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validate: (value) =>
                        ValidationMixin().validatePassword(value!),
                    onFieldSubmitted: (_) {
                      _submit(
                        context,
                      );
                    },
                  ),
                  SizedBox(height: SizeConfig.height * 2),
                  GeneralElevatedButton(
                    onPressed: () {
                      _submit(
                        context,
                      );
                    },
                    title: "Login",
                  ),
                  SizedBox(height: SizeConfig.height * 3),
                  if (canCheckBioMetric)
                    GeneralTextButton(
                      prefixIcon: Icons.fingerprint_outlined,

                      title: "Login via Fingerprint",
                      onPressed: () {
                        // _submit(context);
                        loginViaFingerprint(context);
                      },
                      // child: const Text("Login"),
                    ),
                  if (canCheckBioMetric)
                    SizedBox(
                      height: SizeConfig.height * 2,
                    ),
                  const Text("OR"),
                  SizedBox(height: SizeConfig.height * 2),
                  GeneralTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(),
                        ),
                      );
                    },
                    title: "Register",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context, {bool? isAuthenticated}) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isAuthenticated ??= await hasBiometrics();
      final firebaseAuth = FirebaseAuth.instance;
      GeneralAlertDialog().customLoadingDialog(context);
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final user = userCredential.user;
      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        final data = await firestore
            .collection(UserConstants.userCollection)
            .where(UserConstants.userId, isEqualTo: user.uid)
            .get();
        var map = {};
        if (data.docs.isEmpty) {
          map = FirebaseUser(
            displayName: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
            uuid: user.uid,
          ).toJson();
        } else {
          map = data.docs.first.data();
        }
        Provider.of<UserProvider>(context, listen: false).setUser(map);
      }
      Navigator.pop(context);
      if (isAuthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const NavigationScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => FingerPrintAuthScreen(
              username: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      var message = "";
      if (ex.code == "wrong-password") {
        message = "The password is incorrect";
      } else if (ex.code == "user-not-found") {
        message = "The user is not registered";
      }
      await GeneralAlertDialog().customAlertDialog(context, message);
    } catch (ex) {
      Navigator.pop(context);
      await GeneralAlertDialog().customAlertDialog(context, ex.toString());
    }
  }

  void loginViaFingerprint(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final authenticated = await localAuth.authenticate(
      localizedReason: "Place your fingerprint to login",
    );
    if (authenticated) {
      const secureStorage = FlutterSecureStorage();
      final email =
          await secureStorage.read(key: SecureStorageConstants.emailKey);
      final password =
          await secureStorage.read(key: SecureStorageConstants.passwordKey);
      if (email != null) {
        emailController.text = email;
        passwordController.text = password!;
        _submit(context, isAuthenticated: true);
      }
    }
  }
}
