import 'package:flutter/material.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/category_button.dart';
import 'short_stay_screen.dart';
import 'restaurant_list_screen.dart';
import '../models/accommodation.dart';

class LongStayScreen extends StatefulWidget {
  const LongStayScreen({super.key});

  @override
  State<LongStayScreen> createState() => _LongStayScreenState();
}

class _LongStayScreenState extends State<LongStayScreen> {
  // Options for dropdown
  final List<String> _options = ['Long Stay', 'Short Stay', 'Restaurants'];
  String _selectedOption = 'Long Stay'; // Default for this screen

  // Example categories
  final List<String> _categories = [
    "Single",
    "Sharing",
    "Bachelor",
    "Apartment",
    "House"
  ];
  String _selectedCategory = "House"; // Default selected

  // List of accommodations
  final List<Accommodation> _accommodations = [
    Accommodation(
      title: "Luxury Apartment with View",
      rating: 4.8,
      location: "City Center",
      availability: "Available from June 1",
      price: "\$1800/month",
      imageUrl: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2",
      category: "Apartment",
    ),
    Accommodation(
      title: "Cozy 2-Bedroom House",
      rating: 4.3,
      location: "Suburban Area",
      availability: "Available from July 15",
      price: "\$1500/month",
      imageUrl: "https://images.unsplash.com/photo-1568605114967-8130f3a36994",
      category: "House",
    ),
    // Add more accommodations with different categories
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProperties = _accommodations
        .where((property) => property.category == _selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar with dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search long-term accommodations...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    // Dropdown menu
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: _selectedOption,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.grey[800], fontSize: 14),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue == null || newValue == _selectedOption) return;
                          setState(() {
                            _selectedOption = newValue;
                          });
                          
                          // Navigate based on selection
                          if (newValue == 'Short Stay') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShortStayScreen(),
                              ),
                            );
                          } else if (newValue == 'Restaurants') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RestaurantListScreen(),
                              ),
                            );
                          }
                        },
                        items: _options.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Category filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ..._categories.map((category) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = selected ? category : _selectedCategory;
                          });
                        },
                      ),
                    )),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Accommodation listings
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final acc = filteredProperties[index];
                    return Column(
                      children: [
                        AccommodationCard(
                          title: acc.title,
                          rating: acc.rating,
                          location: acc.location,
                          availability: acc.availability,
                          price: acc.price,
                          imageUrl: acc.imageUrl,
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}