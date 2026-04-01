import 'package:flutter/material.dart';
import 'voyager_info_screen.dart';
import 'hotels_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int selectedCategory = 0;
  final List<String> categories = ['All', 'Adventure', 'Popular'];

  // Separate filters
  String? selectedPreference;
  String? selectedBudget;
  String? selectedInterest;
  final List<Map<String, dynamic>> places = [
    {
      'title': 'Cox’s Bazar',
      'category': 'Popular',
      'image': 'assets/coxsbazar.png',
      'preference': 'Beach',
      'budget': 5000,
      'interest': 'Relaxation',
    },
    {
      'title': 'Sundarbans',
      'category': 'Adventure',
      'image': 'assets/sundarbans.png',
      'preference': 'Forest',
      'budget': 8000,
      'interest': 'Wildlife',
    },
    {
      'title': 'Srimangal',
      'category': 'Adventure',
      'image': 'assets/srimangal.png',
      'preference': 'Hill',
      'budget': 4000,
      'interest': 'Nature',
    },
    {
      'title': 'Bandarban',
      'category': 'Popular',
      'image': 'assets/bandarban.png',
      'preference': 'Hill',
      'budget': 7000,
      'interest': 'Adventure',
    },
    {
      'title': 'Kuakata',
      'category': 'All',
      'image': 'assets/kuakata.png',
      'preference': 'Beach',
      'budget': 6000,
      'interest': 'Relaxation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPlaces = places.where((place) {
      if (selectedPreference != null &&
          place['preference'] != selectedPreference) {
        return false;
      }
      if (selectedBudget != null &&
          place['budget'] > int.parse(selectedBudget!)) {
        return false;
      }
      if (selectedInterest != null &&
          place['interest'] != selectedInterest) {
        return false;
      }
      return true;
    }).toList();

    if (selectedCategory != 0) {
      filteredPlaces = filteredPlaces
          .where((place) =>
      place['category'] == categories[selectedCategory])
          .toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Places',
                        hintStyle:
                        const TextStyle(color: Color(0xFF008080)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search,
                            color: Color(0xFF008080)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF008080)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.filter_list,
                        color: Color(0xFF008080)),
                    onPressed: _showFilterOptionsSheet,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const VoyagerAccountScreen()),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF008080),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Travel Places',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008080),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF008080)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF008080)),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF008080),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: filteredPlaces.map((place) {
                    return _buildPlaceCard(
                        place['title'], place['image']);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFilterSection(
                  'What is your preference?',
                  ['Beach', 'Forest', 'Hill'],
                  'Preference'),
              const SizedBox(height: 20),
              _buildFilterSection(
                  'What is your budget?',
                  ['4000', '6000', '8000'],
                  'Budget'),
              const SizedBox(height: 20),
              _buildFilterSection(
                  'What is your interest?',
                  ['Relaxation', 'Wildlife', 'Adventure'],
                  'Interest'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(
      String title, List<String> options, String filterType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF008080),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((opt) {
            bool isSelected = false;

            if (filterType == 'Preference') {
              isSelected = selectedPreference == opt;
            } else if (filterType == 'Budget') {
              isSelected = selectedBudget == opt;
            } else if (filterType == 'Interest') {
              isSelected = selectedInterest == opt;
            }

            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  if (filterType == 'Preference') {
                    selectedPreference = opt;
                  } else if (filterType == 'Budget') {
                    selectedBudget = opt;
                  } else if (filterType == 'Interest') {
                    selectedInterest = opt;
                  }
                });
              },
              child: Container(
                width: 100,
                padding:
                const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF008080)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color(0xFF008080)),
                ),
                child: Center(
                  child: Text(
                    opt,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF008080),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPlaceCard(String title, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelsScreen(placeName: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF008080),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
