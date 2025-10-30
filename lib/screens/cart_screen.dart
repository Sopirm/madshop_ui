import 'package:flutter/material.dart';
import 'package:madshop_ui_golovin/models/cart_item.dart';
import 'package:madshop_ui_golovin/services/cart_service.dart';
import 'package:madshop_ui_golovin/theme/colors.dart';
import 'package:madshop_ui_golovin/theme/text_styles.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Корзина',
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
      body: Column(
        children: [
          Expanded(
            child: cartService.items.isEmpty
                ? const Center(child: Text('Корзина пуста'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cartService.items.length,
                    itemBuilder: (context, index) {
                      final item = cartService.items[index];
                      return _buildCartItem(context, item);
                    },
                  ),
          ),
          _buildCartSummary(context, cartService.totalPrice),
          BottomNavigationBar(
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
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: AppColors.cardBackground,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage(item.product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.removeButton,
                    size: 20,
                  ),
                  onPressed: () {
                    Provider.of<CartService>(
                      context,
                      listen: false,
                    ).removeItem(item.product.id);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ),
                  Text(
                    'Pink, Size M',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.productSizeText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${item.totalPrice.toStringAsFixed(2)} ₽',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: AppColors.bottomNavIcon,
                  ),
                  onPressed: () {
                    Provider.of<CartService>(
                      context,
                      listen: false,
                    ).decrementQuantity(item.product.id);
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bottomNavIcon.withAlpha(
                      (0.2 * 255).round(),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      color: AppColors.bottomNavIcon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.bottomNavIcon,
                  ),
                  onPressed: () {
                    Provider.of<CartService>(
                      context,
                      listen: false,
                    ).incrementQuantity(item.product.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, double total) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Итого ${total.toStringAsFixed(2)} ₽',
            style: AppTextStyles.headlineLarge.copyWith(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              // тут будет оплата
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Оплатить', style: AppTextStyles.buttonText),
          ),
        ],
      ),
    );
  }
}
