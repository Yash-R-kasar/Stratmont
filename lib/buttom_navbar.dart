import 'package:flutter/material.dart';
import 'profile/profile.dart';
import 'nav_components/price.dart';
import 'nav_components/watchlist.dart';
import 'nav_components/tracking.dart';
import 'nav_components/news.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String? companyName;
  final String? mobileNumber;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.companyName,
    this.mobileNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF1A3A52),
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        // ✅ Navigate to Watchlist when index == 0
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WatchlistScreen(
                companyName: companyName ?? 'User',
                mobileNumber: mobileNumber ?? '0000000000',
              ),
            ),
          );
        }
        // ✅ Navigate to Prices when index == 1
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PricesScreen(
                companyName: companyName ?? 'User',
                mobileNumber: mobileNumber ?? '0000000000',
              ),
            ),
          );
        }
        // ✅ Navigate to Tracking when index == 2
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingScreen(
                companyName: companyName ?? 'User',
                mobileNumber: mobileNumber ?? '0000000000',
              ),
            ),
          );
        }
        // ✅ Navigate to News when index == 3
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsScreen(
                companyName: companyName ?? 'User',
                mobileNumber: mobileNumber ?? '0000000000',
              ),
            ),
          );
        }
        // ✅ Navigate to Profile when index == 4
        if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                companyName: companyName ?? 'User',
                mobileNumber: mobileNumber ?? '0000000000',
              ),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          activeIcon: Icon(Icons.bookmark),
          label: 'Watchlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Prices',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping),
          label: 'Tracking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}