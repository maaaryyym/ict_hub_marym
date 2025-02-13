import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_marym/ui/screens/profile.dart';
import '../../auth/app_auth.dart';
import '../../cubits/products_cubit/cubit.dart';
import '../widgets/custom_elevatedButton.dart';
import 'apiTest.dart';

class homeNav extends StatefulWidget {
  const homeNav({super.key});

  @override
  State<homeNav> createState() => _homeNavState();
}

class _homeNavState extends State<homeNav> {
  final List<Widget> _screens = const [
    ApiTest(),
    ProfileScreen(),
  ];

  final List<String> titles = [
    "Home",
    "Profile",
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
            create: (context) => ProductsCubit()..getProducts()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){AppAuth.signOut(context);}, icon: Icon(Icons.logout)),
          title: Text(titles[_index]),
        ),
        body: _screens[_index],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 35,
                ),
                label: "Products"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 35,
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
