import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khana_bachau_app/screens/food_trucks_screen.dart';
import 'package:khana_bachau_app/screens/home_screen.dart';
import 'package:khana_bachau_app/screens/menu_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    FoodTruckScreen(),
    MenuScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: const Text("Do you want to close the app?"),
            actions: [
              TextButton(
                onPressed: () => SystemNavigator.pop(animated: true),
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int newIndex) => setState(() {
            index = newIndex;
          }),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.location_on_outlined,
            //   ),
            //   label: 'Maps',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.add,
            //   ),
            //   label: 'Add',
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fire_truck,
              ),
              label: 'Food Trucks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
