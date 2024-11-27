
import 'package:flutter/material.dart';
import 'package:global_taxi_app/screens/search_screen.dart';

import '../screens/cart_screen.dart';
import '../home/home_screen.dart';
import '../screens/profile.dart';
import '../ultils/contants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0; // Default to HomeScreen
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    // Initialize the screens with the AddQuestion callback
    screens = [
      const HomeScreen(),
      const SearchScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }
  void callback(int newIndex) {
    setState(() {
      this.currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon:Image.asset("images/icon1.png",
                height: 28,
                color: currentIndex == 0 ? Colors.black : Colors.grey.shade400,
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon:Image.asset(
                'images/icon2.png',
                height: 28,
                color: currentIndex == 1 ? Colors.black : Colors.grey.shade400,
              ),
              label: 'Loại xe',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'images/Icon3.png',
                height: 28,
                color: currentIndex == 2 ? Colors.black : Colors.grey.shade400,
              ),
              label: 'Hoạt động',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'images/icon4.png',
                height: 28,
                color: currentIndex == 3 ? Colors.black : Colors.grey.shade400,
              ),
              label: 'Trang cá nhân',
            ),
          ],
        ),
      ),
    );
  }

}
