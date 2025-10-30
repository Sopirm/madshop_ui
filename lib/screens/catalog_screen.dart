import 'package:flutter/material.dart';
import 'package:madshop_ui_golovin/models/product.dart';
import 'package:madshop_ui_golovin/screens/cart_screen.dart';
import 'package:madshop_ui_golovin/theme/colors.dart';
import 'package:madshop_ui_golovin/theme/text_styles.dart';
import 'package:madshop_ui_golovin/widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _selectedIndex = 0;

  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Lorem ipsum dolor sit amet consectetur',
      description: 'Description 1',
      price: 175.00,
      imageUrl: 'assets/images/product_1.png',
    ),
    Product(
      id: '2',
      name: 'Lorem ipsum dolor sit amet consectetur',
      description: 'Description 2',
      price: 175.00,
      imageUrl: 'assets/images/product_2.png',
    ),
    Product(
      id: '3',
      name: 'Lorem ipsum dolor sit amet consectetur',
      description: 'Description 3',
      price: 175.00,
      imageUrl: 'assets/images/product_1.png',
    ),
    Product(
      id: '4',
      name: 'Lorem ipsum dolor sit amet consectetur',
      description: 'Description 4',
      price: 175.00,
      imageUrl: 'assets/images/product_2.png',
    ),
  ];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );

      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Каталог',
          style: AppTextStyles.appBarTitle.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.85,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: _products[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.bottomNavIcon,
        unselectedItemColor: AppColors.secondaryText,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.inputFill,
        elevation: 0,
      ),
    );
  }
}
