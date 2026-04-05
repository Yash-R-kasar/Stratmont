import 'package:flutter/material.dart';
import 'package:stratmont/buttom_navbar.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CategoriesScreen extends StatefulWidget {
  final String companyName;
  final String mobileNumber;

  const CategoriesScreen({
    Key? key,
    required this.companyName,
    required this.mobileNumber,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;
  late Dio _dio;
  bool _isLoading = true;
  String _errorMessage = '';
  List<dynamic> _categories = [];
  Map<String, Set<String>> _selectedL2 = {}; // L1 ID -> Set of L2 IDs

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _fetchCategories();
  }

  /// ── Fetch Categories from API ──────────────────────────────────
  Future<void> _fetchCategories() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      print("\n📤 CATEGORIES REQUEST");
      print("URL: https://api.stratmontind.com/api/v1/catalog/l1");

      final response = await _dio.get(
        "https://api.stratmontind.com/api/v1/catalog/l1",
        options: Options(
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      print("\n📥 CATEGORIES RESPONSE");
      print("Status Code: ${response.statusCode}");
      print("Data: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data['success'] == true) {
          final categories = data['data'] as List<dynamic>;

          // Initialize selected L2 items map
          for (var category in categories) {
            final l1Id = category['id'];
            _selectedL2[l1Id] = {};
          }

          setState(() {
            _categories = categories;
            _isLoading = false;
          });

          print("✅ Loaded ${categories.length} categories");
        } else {
          setState(() {
            _errorMessage = 'Invalid response format';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.message}");
      setState(() {
        _errorMessage = 'Connection error: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      print("❌ Error fetching categories: $e");
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  /// ── Toggle L2 Selection ────────────────────────────────────────
  void _toggleL2Selection(String l1Id, String l2Id) {
    setState(() {
      if (_selectedL2[l1Id] == null) {
        _selectedL2[l1Id] = {};
      }

      if (_selectedL2[l1Id]!.contains(l2Id)) {
        _selectedL2[l1Id]!.remove(l2Id);
      } else {
        _selectedL2[l1Id]!.add(l2Id);
      }
    });
  }

  /// ── Get Category Icon ──────────────────────────────────────────
  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'steel':
        return Icons.layers;
      case 'cement':
        return Icons.home;
      case 'chemicals':
        return Icons.local_pharmacy;
      case 'polymers':
        return Icons.shopping_bag;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A52),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A52),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Select Your Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Help us serve you with personalized\nprices, offers and news',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: _buildContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        companyName: widget.companyName,
        mobileNumber: widget.mobileNumber,
      ),
    );
  }

  /// ── Build Content based on State ───────────────────────────────
  Widget _buildContent() {
    // Loading State
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF1A3A52)),
      );
    }

    // Error State
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchCategories,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A3A52),
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    // Empty State
    if (_categories.isEmpty) {
      return const Center(
        child: Text(
          'No categories available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Categories List
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return _buildCategoryCard(category);
      },
    );
  }

  /// ── Build Category Card ────────────────────────────────────────
  Widget _buildCategoryCard(Map<String, dynamic> category) {
    final String l1Id = category['id'] ?? '';
    final String l1Name = category['name'] ?? '';
    final String l1Description = category['description'] ?? '';
    final List<dynamic> l2Categories = category['categoriesL2'] ?? [];

    return _CategoryCard(
      l1Id: l1Id,
      l1Name: l1Name,
      l1Description: l1Description,
      l2Categories: l2Categories,
      icon: _getCategoryIcon(l1Name),
      onL2Toggle: _toggleL2Selection,
      isL2Selected: (l2Id) => _selectedL2[l1Id]?.contains(l2Id) ?? false,
    );
  }
}

/// ── Category Card Widget ────────────────────────────────────────
class _CategoryCard extends StatefulWidget {
  final String l1Id;
  final String l1Name;
  final String l1Description;
  final List<dynamic> l2Categories;
  final IconData icon;
  final Function(String, String) onL2Toggle;
  final bool Function(String) isL2Selected;

  const _CategoryCard({
    required this.l1Id,
    required this.l1Name,
    required this.l1Description,
    required this.l2Categories,
    required this.icon,
    required this.onL2Toggle,
    required this.isL2Selected,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        children: [
          // L1 Category Header
          ListTile(
            leading: Icon(
              widget.icon,
              color: const Color(0xFF1A3A52),
              size: 28,
            ),
            title: Text(
              widget.l1Name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3A52),
              ),
            ),
            subtitle: Text(
              widget.l1Description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: const Color(0xFF1A3A52),
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),

          // L2 Categories (Sub-items)
          if (_isExpanded && widget.l2Categories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 12),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.l2Categories.map((l2) {
                      final String l2Id = l2['id'] ?? '';
                      final String l2Name = l2['name'] ?? '';
                      final bool isSelected = widget.isL2Selected(l2Id);

                      return GestureDetector(
                        onTap: () {
                          widget.onL2Toggle(widget.l1Id, l2Id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFC9A961)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFC9A961)
                                  : const Color(0xFFE0E0E0),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                l2Name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1A3A52),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                isSelected ? Icons.check : Icons.add,
                                size: 14,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1A3A52),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
