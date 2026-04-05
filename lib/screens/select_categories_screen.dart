import 'package:flutter/material.dart';
import 'verify_screen.dart';
import 'categories.dart';

class SelectCategoriesScreen extends StatefulWidget {
  const SelectCategoriesScreen({super.key});

  @override
  State<SelectCategoriesScreen> createState() => _SelectCategoriesScreenState();
}

class _SelectCategoriesScreenState extends State<SelectCategoriesScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<CategorySlide> slides = [
    CategorySlide(
      title: 'Get live prices for 100k+\nraw materials',
      image: 'assets/images/cat3.jpeg',
    ),
    CategorySlide(
      title: 'Buy and sell directly on\nthe platform',
      image: 'assets/images/cat2.jpeg',
      isMarketplace: true,
    ),
    CategorySlide(
      title: 'Get market insights on\nyour fingertips',
      image: 'assets/images/cat1.jpeg',
      isNews: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get isTablet => MediaQuery.of(context).size.width >= 600;

  double get horizontalPadding => isTablet ? 40 : 20;
  double get logoSize => isTablet ? 140 : 100;
  double get titleFontSize => isTablet ? 32 : 26;
  double get buttonHeight => isTablet ? 60 : 50;
  double get buttonFontSize => isTablet ? 18 : 16;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Recommended max mockup height: ~55–65% of screen height
    final mockupHeight =
        screenHeight * (isTablet ? 0.60 : 0.58).clamp(400.0, 780.0);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF5FB),
      body: SafeArea(
        child: Column(
          children: [
            // PageView - takes most of the space
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return CategoryPage(
                    slide: slides[index],
                    horizontalPadding: horizontalPadding,
                    logoSize: logoSize,
                    titleFontSize: titleFontSize,
                    mockupHeight: mockupHeight,
                    isTablet: isTablet,
                  );
                },
              ),
            ),

            // Page indicators
            Padding(
              padding: EdgeInsets.only(bottom: isTablet ? 16 : 5, top: 12),
              child: _buildPageIndicator(),
            ),

            // Buttons area
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isTablet ? 16 : 10,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3A52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: TextStyle(fontSize: buttonFontSize),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VerifyPhoneScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Let's Get Started",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 12),
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF1A3A52),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: TextStyle(fontSize: buttonFontSize),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoriesScreen(
                              companyName: 'Guest User',
                              mobileNumber: 'XXXXXXXXXX',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Existing User',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A3A52),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        slides.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: _currentPage == index ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xFFC9A961)
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────

class CategorySlide {
  final String title;
  final String image;
  final bool isMarketplace;
  final bool isNews;

  CategorySlide({
    required this.title,
    required this.image,
    this.isMarketplace = false,
    this.isNews = false,
  });
}

class CategoryPage extends StatelessWidget {
  final CategorySlide slide;
  final double horizontalPadding;
  final double logoSize;
  final double titleFontSize;
  final double mockupHeight;
  final bool isTablet;

  const CategoryPage({
    super.key,
    required this.slide,
    required this.horizontalPadding,
    required this.logoSize,
    required this.titleFontSize,
    required this.mockupHeight,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          SizedBox(height: isTablet ? 60 : 40),

          // Logo
          ClipOval(
            child: Image.asset(
              'assets/images/stratmont.jpeg',
              width: logoSize,
              height: logoSize,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: isTablet ? 50 : 30),

          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A3A52),
              height: 1.3,
            ),
          ),

          SizedBox(height: isTablet ? 40 : 20),

          // Phone mockup – most important responsive part
          LayoutBuilder(
            builder: (context, constraints) {
              // Keep ~16:9 – 9:16 aspect ratio feel, but cap width
              final mockupWidth =
                  constraints.maxWidth * (isTablet ? 0.70 : 0.92);

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 500, // never too wide on tablets/web
                    maxHeight: mockupHeight,
                  ),
                  child: AspectRatio(
                    aspectRatio:
                        9 /
                        19.5, // typical phone ratio ≈ 9:19 – adjust per your images
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isTablet ? 32 : 22),
                      child: Image.asset(slide.image, fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: isTablet ? 60 : 30),
        ],
      ),
    );
  }
}
