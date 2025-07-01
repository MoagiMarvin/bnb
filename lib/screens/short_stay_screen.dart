import 'package:flutter/material.dart';
import '../widgets/accommodation_card.dart';
import '../widgets/category_button.dart';
import 'long_stay_screen.dart';
import 'restaurant_list_screen.dart';

class ShortStayScreen extends StatefulWidget {
  const ShortStayScreen({super.key});

  @override
  State<ShortStayScreen> createState() => _ShortStayScreenState();
}

class _ShortStayScreenState extends State<ShortStayScreen> {
  // Options for dropdown
  final List<String> _options = ['Long Stay', 'Short Stay', 'Restaurants'];
  String _selectedOption = 'Short Stay'; // Default for this screen
  final List<String> _categories = ["Resort", "Hotel", "Motel", "Cottage", "Villa"];
  String _selectedCategory = "Resort";
  
  // Mock short stay property data
  final List<Map<String, dynamic>> _properties = [
    {
      'title': 'Beachfront Resort',
      'rating': 4.9,
      'location': 'Coastal Area',
      'availability': 'Available for booking',
      'price': '\$150/night',
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
      'category': 'Resort',
    },
    {
      'title': 'Mountain View Villa',
      'rating': 4.7,
      'location': 'Highland Resort',
      'availability': 'Available next weekend',
      'price': '\$200/night',
      'imageUrl': 'https://images.unsplash.com/photo-1613490493576-7fde63acd811',
      'category': 'Villa',
    },
    {
      'title': 'Luxury Hotel Suite',
      'rating': 4.6,
      'location': 'City Center',
      'availability': 'Available this week',
      'price': '\$180/night',
      'imageUrl': 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461',
      'category': 'Hotel',
    },
    {
      'title': 'Budget Motel Room',
      'rating': 4.0,
      'location': 'Suburban',
      'availability': 'Available now',
      'price': '\$70/night',
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'category': 'Motel',
    },
    {
      'title': 'Cozy Cottage',
      'rating': 4.3,
      'location': 'Countryside',
      'availability': 'Available from next month',
      'price': '\$120/night',
      'imageUrl': 'https://images.unsplash.com/photo-1512918728675-ed5a9ecdebfd',
      'category': 'Cottage',
    },
  ];
  
  @override
  Widget build(BuildContext context) {
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
                          hintText: 'Search...',
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
                          setState(() {
                            _selectedOption = newValue!;
                          });
                          
                          // Navigate based on selection
                          if (newValue == 'Long Stay') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LongStayScreen(),
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
              
              // Category filters - horizontal scrollable
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((category) {
                    return CategoryButton(
                      label: category,
                      selected: _selectedCategory == category,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Accommodation listings
              Expanded(
                child: ListView(
                  children: _properties
                      .where((property) => property['category'] == _selectedCategory)
                      .map((property) => AccommodationCard(
                            title: property['title'],
                            rating: property['rating'],
                            location: property['location'],
                            availability: property['availability'],
                            price: property['price'],
                            imageUrl: property['imageUrl'],
                          ))
                      .toList(),
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