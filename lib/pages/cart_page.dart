import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/product.dart';
import '../services/cart_service.dart';
import 'detail_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: ValueListenableBuilder(
        valueListenable: CartService.box.listenable(),
        builder: (context, box, child) {
          final items = CartService.getItems();
          if (items.isEmpty) {
            return const Center(child: Text('Keranjang masih kosong'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final Product product = items[i];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                  title: Text(product.title),
                  subtitle: Text(
                    '\$${product.price}\n★ ${product.rate} (${product.count})',
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(productId: product.id),
                      ),
                    );
                  },
                  trailing: IconButton(
                    tooltip: 'Hapus',
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => CartService.removeFromCart(product.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
