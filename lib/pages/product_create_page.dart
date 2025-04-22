import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({Key? key}) : super(key: key);

  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final ProductService _service = ProductService();

  void _saveProduct() async {
    // Validación simple antes de enviar
    final name = _nameController.text.trim();
    final category = _categoryController.text.trim();
    final priceText = _priceController.text.trim();

    if (name.isEmpty || category.isEmpty || priceText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El precio debe ser un número válido')),
      );
      return;
    }

    final product = Product(
      id: 0,
      name: name,
      category: category,
      price: price,
    );

    try {
      await _service.createProduct(product);
      if (mounted) {
        Navigator.pop(context); // volver a la lista
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear producto: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProduct,
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

