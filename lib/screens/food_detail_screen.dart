import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khana_bachau_app/constants/constants.dart';
import 'package:khana_bachau_app/models/food.dart';
import 'package:khana_bachau_app/providers/food_provider.dart';
import 'package:khana_bachau_app/providers/user_provider.dart';
import 'package:khana_bachau_app/screens/map_screen.dart';
import 'package:khana_bachau_app/utils/size_config.dart';
import 'package:khana_bachau_app/widgets/curved_body_widget.dart';
import 'package:khana_bachau_app/widgets/custom_card.dart';
import 'package:khana_bachau_app/widgets/general_alert_dialog.dart';
import 'package:khana_bachau_app/widgets/general_elevated_button.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({
    Key? key,
    required this.food,
    required this.toShowButton,
  }) : super(key: key);

  final Food food;
  final bool toShowButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          food.name,
        ),
      ),
      body: CurvedBodyWidget(
        widget: Column(
          children: [
            CustomCard(
              children: [
                SizedBox(
                  width: SizeConfig.width * 100,
                  height: SizeConfig.height * 15,
                  child: Image.memory(
                    base64Decode(food.image),
                    fit: BoxFit.contain,
                    height: SizeConfig.height * 15,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  food.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: SizeConfig.height * .5,
                ),
                Text(
                  food.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Quantity",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(
                          height: SizeConfig.height * .5,
                        ),
                        Text(
                          food.quantity.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Unit Price",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(
                          height: SizeConfig.height * .5,
                        ),
                        Text(
                          "Rs. ${food.price}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.height * 2,
                ),
                Text(
                  "Total Price: ${food.totalPrice}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                        color: Colors.deepOrange,
                      ),
                ),
                if (toShowButton || food.acceptingUserName != null)
                  SizedBox(
                    height: SizeConfig.height * 2,
                  ),
                if (food.acceptingUserName != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.width * 40,
                        child: Text(
                          "Accepted By: ${food.acceptingUserName!}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Spacer(),
                      if (food.rating != null)
                        Text(
                          "Rating: ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (food.rating != null)
                        RatingBarIndicator(
                          rating: food.rating!,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          itemCount: 5,
                          itemSize: SizeConfig.width * 4,
                          direction: Axis.horizontal,
                        ),
                    ],
                  ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height * 3,
            ),
            Expanded(
              child: MapScreen(
                requireAppBar: false,
                latitude: food.latitude,
                longitude: food.longitude,
                title: "Donor",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: toShowButton
          ? Container(
              color: const Color(0xffEBEEF2),
              padding: basePadding,
              child: GeneralElevatedButton(
                title: "Take Food",
                onPressed: () async {
                  try {
                    GeneralAlertDialog().customLoadingDialog(context);
                    final user =
                        Provider.of<UserProvider>(context, listen: false).user;
                    await Provider.of<FoodProvider>(context, listen: false)
                        .updateFood(
                      context,
                      acceptingUserId: user.uuid,
                      acceptingUserName: user.name ?? "",
                      foodId: food.id!,
                    );
                    Navigator.pop(context);
                  } catch (ex) {
                    Navigator.pop(context);
                    GeneralAlertDialog()
                        .customAlertDialog(context, ex.toString());
                  }
                },
              ),
            )
          : null,
    );
  }
}
