import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_api_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductApiService _api = const ProductApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  bool _loading = false;
  List<Product> _products = <Product>[];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() => _loading = true);

    try {
      final List<Product> data = await _api.getProducts();
      setState(() => _products = data);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar produtos.')),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _createProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final Product product = Product(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text.replaceAll(',', '.')),
      category: _categoryController.text.trim(),
    );

    try {
      await _api.createProduct(product);
      _formKey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _categoryController.clear();
      await _loadProducts();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produto cadastrado com sucesso.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar produto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos do Pet Shop')),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const Text(
              'Cadastro de Produto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome do produto'),
                    validator: (String? v) =>
                        v == null || v.trim().isEmpty ? 'Informe o nome' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (String? v) =>
                        v == null || v.trim().isEmpty ? 'Informe a descrição' : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Preço'),
                    validator: (String? v) {
                      if (v == null || v.trim().isEmpty) return 'Informe o preço';
                      if (double.tryParse(v.replaceAll(',', '.')) == null) {
                        return 'Preço inválido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Categoria'),
                    validator: (String? v) =>
                        v == null || v.trim().isEmpty ? 'Informe a categoria' : null,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createProduct,
                      child: const Text('Cadastrar'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Lista de Produtos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (_loading)
              const Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(),
              ))
            else if (_products.isEmpty)
              const Text('Nenhum produto encontrado na API.')
            else
              ..._products.map(
                (Product p) => Card(
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Text('${p.description}\nCategoria: ${p.category}'),
                    isThreeLine: true,
                    trailing: Text('R\$ ${p.price.toStringAsFixed(2)}'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
