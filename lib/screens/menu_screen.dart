import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khana_bachau_app/constants/constants.dart';
import 'package:khana_bachau_app/main.dart';
import 'package:khana_bachau_app/providers/user_provider.dart';
import 'package:khana_bachau_app/screens/accepted_food_screen.dart';
import 'package:khana_bachau_app/screens/login_screen.dart';
import 'package:khana_bachau_app/screens/profile_screen.dart';
import 'package:khana_bachau_app/utils/navigate.dart';
import 'package:khana_bachau_app/utils/size_config.dart';
import 'package:khana_bachau_app/widgets/curved_body_widget.dart';
import 'package:khana_bachau_app/widgets/general_alert_dialog.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<UserProvider>(
      context,
    ).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Menu"),
      ),
      body: CurvedBodyWidget(
          widget: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: basePadding,
                  child: Column(
                    children: [
                      Hero(
                        tag: "image-url",
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(SizeConfig.height * 8),
                          child: profileData.image == null
                              ? Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                  size: SizeConfig.height * 10,
                                )
                              : Image.memory(
                                  base64Decode(profileData.image!),
                                  fit: BoxFit.cover,
                                  height: SizeConfig.height * 10,
                                  width: SizeConfig.height * 10,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      Text(
                        profileData.name!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: SizeConfig.height,
                      ),
                      Text(profileData.phoneNumber),
                      SizedBox(
                        height: SizeConfig.height / 2,
                      ),
                      Text(profileData.email!),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.height * 3,
            ),
            buildListTile(
              context,
              icon: Icons.person,
              label: "Your Profile",
              widget: ProfileScreen(),
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            buildListTile(
              context,
              icon: Icons.history_outlined,
              label: "Accepted Foods",
              widget: AcceptedFoodScreen(),
            ),
            SizedBox(
              height: SizeConfig.height * 2,
            ),
            buildListTile(
              context,
              icon: Icons.logout_outlined,
              label: "Logout",
              color: Colors.red,
              func: () async {
                GeneralAlertDialog().customLoadingDialog(context);
                final hasBiometric = await hasBiometrics();
                navigateAndRemoveAll(
                  context,
                  LoginScreen(hasBiometric),
                );
              },
            ),
            // SizedBox(
            //   height: SizeConfig.height * 3,
            // ),
            // buildListTile(
            //   context,
            //   label: "Your Profile",
            //   widget: ProfileScreen(),
            // ),
          ],
        ),
      )),
    );
  }

  Widget buildListTile(
    BuildContext context, {
    required String label,
    required IconData icon,
    Widget? widget,
    Color? color,
    Function? func,
  }) {
    return Card(
      child: ListTile(
        selectedColor: color,
        selected: color != null ? true : false,
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(
          Icons.arrow_right_outlined,
        ),
        onTap: () => func != null ? func() : navigate(context, widget!),
      ),
    );
  }
}
