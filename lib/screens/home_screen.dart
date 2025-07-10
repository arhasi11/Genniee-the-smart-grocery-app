import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../widgets/delivery_mode_switch.dart';
import '../widgets/ai_basket_planner.dart';
import 'cart_screen.dart';
import 'grocery_screen.dart';
import 'fruits_screen.dart' as fruits;
import 'dairy_screen.dart' as dairy;
import 'snacks_screen.dart' as snacks;
import 'profile_screen.dart';
import '../utils/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  final bool showWelcome;

  const HomeScreen({super.key, this.showWelcome = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Map<String, dynamic>> _cartItems = [];
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showWelcome) {
        _showWelcomeDialog();
      }
    });
  }

  Future<void> _loadUserName() async {
    final name = await SharedPrefs.getUserName();
    setState(() {
      userName = name ?? 'User';
    });
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Welcome 🎉'),
        content: Text('Hi $userName, great to see you again!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Let's Shop"),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _addToCart(List<Map<String, dynamic>> items) {
    for (var newItem in items) {
      final existingIndex =
          _cartItems.indexWhere((item) => item['name'] == newItem['name']);
      if (existingIndex != -1) {
        _cartItems[existingIndex]['quantity'] += newItem['quantity'];
      } else {
        _cartItems.add(Map.from(newItem));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<Widget> _pages = [
      HomeContent(
        onCategorySelected: (Widget page) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        addToCart: _addToCart,
      ),
      CartScreen(cartItems: _cartItems),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/Ge.png', height: 48),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Gennie', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(userName, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final Function(Widget) onCategorySelected;
  final Function(List<Map<String, dynamic>>) addToCart;

  const HomeContent({
    super.key,
    required this.onCategorySelected,
    required this.addToCart,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await SharedPrefs.getUserName();
    setState(() {
      userName = name ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text("Good Evening, $userName 👋", style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
          const DeliveryModeSwitch(),
          const SizedBox(height: 30),
          AiBasketPlanner(onAddToCart: widget.addToCart),
          const SizedBox(height: 30),
          const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () => widget.onCategorySelected(
                    GroceryScreen(onAddToCart: widget.addToCart)),
                child: const CategoryCard(
                  title: 'Groceries',
                  imagePath: 'assets/images/groceries.png',
                ),
              ),
              GestureDetector(
                onTap: () => widget.onCategorySelected(
                    fruits.FruitsScreen(onAddToCart: widget.addToCart)),
                child: const CategoryCard(
                  title: 'Fruits',
                  imagePath: 'assets/images/vegetables.png',
                ),
              ),
              GestureDetector(
                onTap: () => widget.onCategorySelected(
                    dairy.DairyScreen(onAddToCart: widget.addToCart)),
                child: const CategoryCard(
                  title: 'Dairy',
                  imagePath: 'assets/images/dairy.png',
                ),
              ),
              GestureDetector(
                onTap: () => widget.onCategorySelected(
                    snacks.SnacksScreen(onAddToCart: widget.addToCart, cartItems: [])),
                child: const CategoryCard(
                  title: 'Snacks',
                  imagePath: 'assets/images/snacks.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
