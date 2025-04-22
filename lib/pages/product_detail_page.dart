import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int productId = ModalRoute.of(context)!.settings.arguments as int;
    final ProductService service = ProductService();

    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Producto')),
      body: FutureBuilder<Product>(
        future: service.getProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Producto no encontrado'));
          }

          final product = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${product.name}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 8),
                Text('Categoría: ${product.category}'),
                SizedBox(height: 8),
                Text('Precio: \$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
