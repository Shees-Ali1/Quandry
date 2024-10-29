import 'package:flutter/material.dart';
import 'package:quandry/const/images.dart';
import 'package:quandry/widgets/appbar_small.dart';

class ProfileScreenMain extends StatelessWidget {
  const ProfileScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppbarSmall(
        // title: "My Custom Title", // Change title as needed
        iconImage: AppImages.drawer_icon, // Change icon as needed
        onIconTap: () {
          // Define the action when the icon is tapped
        },
      ),

      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Screen Main")
        ],
      ),
    );
  }
}
