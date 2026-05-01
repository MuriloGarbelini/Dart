import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const PetShopApp());

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Shop Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/menu': (_) => const MenuPage(),
        '/produtos': (_) => const ProductsPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    final isValid = _userController.text == 'admin' && _passwordController.text == '1234';
    if (isValid) {
      Navigator.pushReplacementNamed(context, '/menu');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuário ou senha inválidos.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - Pet Shop')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userController,
                decoration: const InputDecoration(labelText: 'Usuário'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o usuário' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Principal')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/produtos'),
          icon: const Icon(Icons.pets),
          label: const Text('Cadastro/Listagem de Produtos'),
        ),
      ),
    );
  }
}

class Product {
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.id,
  });

  final String? id;
  final String name;
  final String description;
  final double price;
  final String category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id']?.toString(),
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    price: double.tryParse(json['price'].toString()) ?? 0,
    category: json['category'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'category': category,
  };
}

class ProductApiService {
  static const _baseUrl = 'https://68284f236075e87073a6bfc7.mockapi.io/api/v1/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar produtos');
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  }

  Future<void> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao salvar produto');
    }
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _service = ProductApiService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _isLoading = false;
  List<Product> _products = [];

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
    setState(() => _isLoading = true);
    try {
      final items = await _service.fetchProducts();
      setState(() => _products = items);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar produtos da API.')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final product = Product(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text.replaceAll(',', '.')),
      category: _categoryController.text,
    );

    try {
      await _service.createProduct(product);
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
        const SnackBar(content: Text('Erro ao cadastrar produto na API.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos do Pet Shop')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cadastro de Produto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome do produto'),
                    validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (v) => v == null || v.isEmpty ? 'Informe a descrição' : null,
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: 'Preço'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe o preço';
                      return double.tryParse(v.replaceAll(',', '.')) == null ? 'Preço inválido' : null;
                    },
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Categoria'),
                    validator: (v) => v == null || v.isEmpty ? 'Informe a categoria' : null,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveProduct,
                      child: const Text('Cadastrar Produto'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Produtos Cadastrados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_products.isEmpty)
              const Text('Nenhum produto cadastrado até o momento.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _products.length,
                itemBuilder: (_, index) {
                  final p = _products[index];
                  return Card(
                    child: ListTile(
                      title: Text(p.name),
                      subtitle: Text('${p.description}\nCategoria: ${p.category}'),
                      isThreeLine: true,
                      trailing: Text('R\$ ${p.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
