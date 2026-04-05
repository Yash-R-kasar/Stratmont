import 'package:flutter/material.dart';
import 'package:stratmont/buttom_navbar.dart';
import 'price_form.dart';

class PricesScreen extends StatefulWidget {
  final String companyName;
  final String mobileNumber;

  const PricesScreen({
    Key? key,
    required this.companyName,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  State<PricesScreen> createState() => _PricesScreenState();
}

class _PricesScreenState extends State<PricesScreen> {
  final List<PriceItem> priceItems = [
    PriceItem(
      name: 'Sponge Pellet',
      specs: 'Fe 500D  10-25mm',
      price: '₹24,200/MT',
      priceChange: '1.4%',
      isPositive: true,
      time: '10 Hrs Ago',
      location: 'Ex- Rourkela',
      image: 'assets/img.jpeg',
    ),
    PriceItem(
      name: 'Sponge Pellet',
      specs: 'Fe 500D  10-25mm',
      price: '₹24,200/MT',
      priceChange: '1.4%',
      isPositive: true,
      time: '10 Hrs Ago',
      location: 'Ex- Rourkela',
      image: 'assets/img.jpeg',
    ),
    PriceItem(
      name: 'Sponge Pellet',
      specs: 'Fe 500D  10-25mm',
      price: '₹24,200/MT',
      priceChange: '1.4%',
      isPositive: false,
      time: '10 Hrs Ago',
      location: 'Ex- Rourkela',
      image: 'assets/img.jpeg',
    ),
    PriceItem(
      name: 'Sponge Pellet',
      specs: 'Fe 500D  10-25mm',
      price: '₹24,200/MT',
      priceChange: '1.4%',
      isPositive: false,
      time: '10 Hrs Ago',
      location: 'Ex- Rourkela',
      image: 'assets/img.jpeg',
    ),
  ];

  String selectedCategory = 'Sponge Pellet';
  String selectedLocation = 'Location';
  String selectedBrand = 'Brands';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A52),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/stratmont_logo.jpeg',
                width: 200,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Container(
              color: const Color(0xFF1A3A52),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for Products, Orders, News & More',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            // Category Tabs
            Container(
              color: const Color(0xFF1A3A52),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Mild Steel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3A52),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Pipes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
            // Filter Dropdowns
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildFilterDropdown(
                      label: 'Sponge Pellet',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFilterDropdown(
                      label: 'Location',
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFilterDropdown(
                      label: 'Brands',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            // Price Items List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: priceItems.length,
                itemBuilder: (context, index) {
                  return _buildPriceCard(priceItems[index]);
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {},
        companyName: widget.companyName,
        mobileNumber: widget.mobileNumber,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show form as bottom sheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            builder: (context) => const PriceFormModal(),
          );
        },
        backgroundColor: const Color(0xFF1A3A52),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A3A52),
              ),
            ),
            const Icon(
              Icons.expand_more,
              size: 18,
              color: Color(0xFF1A3A52),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(PriceItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with name and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A3A52),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.specs,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: const Color(0xFF1A3A52),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.chat_bubble_outline,
                    color: Color(0xFF25D366),
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Price and change
          Row(
            children: [
              Text(
                item.price,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A3A52),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: item.isPositive ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.priceChange,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item.time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Location and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Color(0xFF1A3A52),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1A3A52),
                    ),
                  ),
                ],
              ),
              // ✅ UPDATED: Buy and Sell buttons with onTap
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // ✅ Open form when Buy is clicked
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) => const PriceFormModal(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // ✅ Open form when Sell is clicked
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) => const PriceFormModal(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFFA500),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Sell',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFA500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PriceItem {
  final String name;
  final String specs;
  final String price;
  final String priceChange;
  final bool isPositive;
  final String time;
  final String location;
  final String image;

  PriceItem({
    required this.name,
    required this.specs,
    required this.price,
    required this.priceChange,
    required this.isPositive,
    required this.time,
    required this.location,
    required this.image,
  });
}