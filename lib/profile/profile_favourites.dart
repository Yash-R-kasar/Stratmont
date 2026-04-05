import 'package:flutter/material.dart';
import 'package:stratmont/buttom_navbar.dart';

class ProfileFavouritesScreen extends StatefulWidget {
  final String companyName;
  final String mobileNumber;

  const ProfileFavouritesScreen({
    Key? key,
    required this.companyName,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  State<ProfileFavouritesScreen> createState() =>
      _ProfileFavouritesScreenState();
}

class _ProfileFavouritesScreenState extends State<ProfileFavouritesScreen> {
  final List<FavouriteItem> favouritedItems = [
    FavouriteItem(name: 'Construction', isFollowed: true),
    FavouriteItem(name: 'Construction', isFollowed: true),
  ];

  final List<FavouriteItem> otherItems = [
    FavouriteItem(name: 'Construction', isFollowed: false),
    FavouriteItem(name: 'Construction', isFollowed: false),
    FavouriteItem(name: 'Construction', isFollowed: false),
    FavouriteItem(name: 'Construction', isFollowed: false),
    FavouriteItem(name: 'Construction', isFollowed: false),
    FavouriteItem(name: 'Construction', isFollowed: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A52),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Favourites',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Products, Orders, News & More',
                    hintStyle:
                    const TextStyle(color: Colors.grey, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
            // Favourite Commodity Products Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Favourite Commodity Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A3A52),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouritedItems.length,
                    itemBuilder: (context, index) {
                      return _buildFavouriteItem(
                        item: favouritedItems[index],
                        onToggle: () {
                          setState(() {
                            favouritedItems[index].isFollowed =
                            !favouritedItems[index].isFollowed;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Other Commodities Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Other Commodities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A3A52),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: otherItems.length,
                    itemBuilder: (context, index) {
                      return _buildFavouriteItem(
                        item: otherItems[index],
                        onToggle: () {
                          setState(() {
                            otherItems[index].isFollowed =
                            !otherItems[index].isFollowed;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // ✅ UPDATED: Use BottomNavBar component
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
        companyName: widget.companyName,
        mobileNumber: widget.mobileNumber,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1A3A52),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildFavouriteItem({
    required FavouriteItem item,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon/Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.folder,
              color: Color(0xFF1A3A52),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Commodity Name
          Expanded(
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3A52),
              ),
            ),
          ),
          // Follow/Followed Button
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: item.isFollowed ? const Color(0xFF1A3A52) : Colors.white,
                border: Border.all(
                  color: const Color(0xFF1A3A52),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!item.isFollowed)
                    const Text(
                      '+ ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A3A52),
                      ),
                    ),
                  Text(
                    item.isFollowed ? 'Followed' : 'Follow',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: item.isFollowed
                          ? Colors.white
                          : const Color(0xFF1A3A52),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Dropdown Icon
          const Icon(
            Icons.expand_more,
            color: Color(0xFF1A3A52),
            size: 20,
          ),
        ],
      ),
    );
  }
}

class FavouriteItem {
  final String name;
  bool isFollowed;

  FavouriteItem({
    required this.name,
    required this.isFollowed,
  });
}