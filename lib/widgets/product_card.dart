import 'package:flutter/material.dart';
import 'package:madshop_ui_golovin/models/cart_item.dart';
import 'package:madshop_ui_golovin/models/product.dart';
import 'package:madshop_ui_golovin/services/cart_service.dart';
import 'package:madshop_ui_golovin/theme/colors.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);
    final isInCart = cartService.items.any(
      (item) => item.product.id == product.id,
    );
    final CartItem? cartItem = isInCart
        ? cartService.items.firstWhere((item) => item.product.id == product.id)
        : null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              height: 80,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${product.price.toStringAsFixed(2)} ₽',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isInCart
                        ? Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 8,
                                      color: AppColors.primaryText,
                                    ),
                                    onPressed: () {
                                      cartService.decrementQuantity(product.id);
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${cartItem?.quantity ?? 0}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColors.primaryText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8,
                                      ), // Уменьшен размер шрифта
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 8,
                                      color: AppColors.primaryText,
                                    ),
                                    onPressed: () {
                                      cartService.incrementQuantity(product.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                cartService.addItem(product);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'В корзину',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
