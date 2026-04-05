import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stratmont/screens/policy.dart';
import 'package:stratmont/screens/terms.dart';
import 'package:stratmont/profile/profile_favourites.dart';
import 'package:stratmont/buttom_navbar.dart';
import 'package:stratmont/profile/preferred_location.dart';
import 'package:stratmont/screens/select_categories_screen.dart';
import 'package:stratmont/services/api_services.dart';

class ProfileScreen extends StatefulWidget {
  final String companyName;
  final String mobileNumber;
  final String? authToken;

  const ProfileScreen({
    Key? key,
    required this.companyName,
    required this.mobileNumber,
    this.authToken,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>?> userProfileFuture;

  @override
  void initState() {
    super.initState();
    print('🔵 ProfileScreen initState');
    print('Auth Token received: ${widget.authToken}');
    print('Company: ${widget.companyName}, Mobile: ${widget.mobileNumber}');
    userProfileFuture = _fetchUserProfile();
  }

  // ✅ Fetch user profile using existing api_services
  Future<Map<String, dynamic>?> _fetchUserProfile() async {
    try {
      print('🟡 Fetching user profile...');
      print('Auth Token: ${widget.authToken}');

      final response = await getReq('/users/me', widget.authToken ?? '');

      print('🔵 Response status: ${response.statusCode}');
      print('🔵 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('🟢 Response data: $data');

        if (data['success'] == true) {
          print('🟢 User data received: ${data['data']}');
          return data['data'];
        } else {
          print('🔴 API returned success: false');
          return null;
        }
      } else {
        print('🔴 API Error status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('🔴 Error fetching user profile: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with blue background
            Container(
              color: const Color(0xFF1A3A52),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  // Logo and STRATMONT
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/stratmont_logo.jpeg',
                            width: 200,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for Products, Orders, News & More',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // White content area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  // ✅ User Card from API
                  FutureBuilder<Map<String, dynamic>?>(
                    future: userProfileFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildLoadingCard();
                      } else if (snapshot.hasData && snapshot.data != null) {
                        final user = snapshot.data!;
                        return _buildUserCard(user);
                      } else {
                        // Fallback to passed parameters
                        return _buildFallbackCard();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // Menu Items
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    title: 'Favourites',
                    subtitle: 'Add & Edit your Favourite Commodities',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFavouritesScreen(
                            companyName: widget.companyName,
                            mobileNumber: widget.mobileNumber,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Preferred Location',
                    subtitle: 'Add & Edit your Preferred Location',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreferredLocationScreen(
                            companyName: widget.companyName,
                            mobileNumber: widget.mobileNumber,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Manage Your Notification',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Privacy Policy',
                    subtitle: 'View Our Privacy Policy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms Of Use',
                    subtitle: 'View Our Terms',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsOfUseScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // ✅ Logout Button with confirmation dialog
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                'Are you sure you want to logout?',
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Color(0xFF1A3A52),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectCategoriesScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
        onTap: (index) {},
        companyName: widget.companyName,
        mobileNumber: widget.mobileNumber,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1A3A52),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  // ✅ Loading state card
  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  // ✅ User card with API data
  Widget _buildUserCard(Map<String, dynamic> user) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFFE8E8E8),
            backgroundImage: user['image'] != null
                ? NetworkImage(user['image'])
                : null,
            child: user['image'] == null
                ? const Icon(Icons.person, color: Color(0xFF1A3A52), size: 32)
                : null,
          ),
          const SizedBox(width: 16),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'] ?? widget.companyName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3A52),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user['phone'] ?? '+91 ${widget.mobileNumber}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Edit Button
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.edit, color: Color(0xFF1A3A52), size: 20),
          ),
        ],
      ),
    );
  }

  // ✅ Fallback card with passed parameters
  Widget _buildFallbackCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFFE8E8E8),
            child: const Icon(Icons.person, color: Color(0xFF1A3A52), size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.companyName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A3A52),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '+91 ${widget.mobileNumber}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.edit, color: Color(0xFF1A3A52), size: 20),
        ],
      ),
    );
  }

  static Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: isHovered ? const Color(0xFFF5F5F5) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isHovered
                        ? const Color(0xFF2196F3)
                        : const Color(0xFF1A3A52),
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isHovered
                                ? const Color(0xFF2196F3)
                                : const Color(0xFF1A3A52),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: isHovered
                                ? const Color(0xFF1976D2)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: isHovered ? const Color(0xFF2196F3) : Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
