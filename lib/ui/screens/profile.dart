import 'package:flutter/material.dart';
import '../../data/data model/user_model.dart';
import '../../data/data source/profile_data_source.dart';
import '../widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    if (ProfileDataSource.user == null) {
      ProfileDataSource.getUserFromFireStore().then((value) {
        setState(() {});
      });
    } else {
      print("user data already loaded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserTile(
              text: "Email",
              value: ProfileDataSource.user?.email,
              icon: Icons.mail),
          UserTile(
              text: "Name",
              value: ProfileDataSource.user?.name,
              icon: Icons.person),
          UserTile(
              text: "Phone",
              value: ProfileDataSource.user?.phone,
              icon: Icons.phone),
        ],
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key, required this.text, required this.value, required this.icon});

  final String text;
  final String? value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListTile(
        tileColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        leading: Icon(
          icon,
          size: 35,
        ),
        title: CustomText(
          data: text,
          fontSize: 20,
        ),
        subtitle: Text(
          value ?? "Loading...",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
