import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/app_drawer.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  final List<Book> _myBooks = [
    Book(
      id: '1',
      name: 'Flutter in Action',
      writerName: 'Eric Windmill',
      marketPrice: 50.0,
      sellingPrice: 35.0,
      location: 'New York',
      condition: 'Like New',
      sellerId: 'seller1',
      genre: 'Programming',
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _writerController = TextEditingController();
  final _marketPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCondition = 'Like New';
  String _selectedGenre = 'Programming';

  @override
  void dispose() {
    _nameController.dispose();
    _writerController.dispose();
    _marketPriceController.dispose();
    _sellingPriceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _addNewBook() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _myBooks.add(
          Book(
            id: DateTime.now().toString(),
            name: _nameController.text,
            writerName: _writerController.text,
            marketPrice: double.parse(_marketPriceController.text),
            sellingPrice: double.parse(_sellingPriceController.text),
            location: _locationController.text,
            condition: _selectedCondition,
            sellerId: 'seller1',
            genre: _selectedGenre,
          ),
        );
      });
      Navigator.pop(context);
    }
  }

  void _showAddBookDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Book'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Book Name'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
                TextFormField(
                  controller: _writerController,
                  decoration: const InputDecoration(labelText: 'Writer Name'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
                TextFormField(
                  controller: _marketPriceController,
                  decoration: const InputDecoration(labelText: 'Market Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
                TextFormField(
                  controller: _sellingPriceController,
                  decoration: const InputDecoration(labelText: 'Selling Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required field' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCondition,
                  decoration: const InputDecoration(labelText: 'Condition'),
                  items: ['Like New', 'Good', 'Fair', 'Poor']
                      .map((condition) => DropdownMenuItem(
                            value: condition,
                            child: Text(condition),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCondition = value!;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedGenre,
                  decoration: const InputDecoration(labelText: 'Genre'),
                  items: ['Programming', 'Fiction', 'Science']
                      .map((genre) => DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addNewBook,
            child: const Text('Add Book'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: _myBooks.length,
        itemBuilder: (context, index) {
          final book = _myBooks[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(book.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Author: ${book.writerName}'),
                  Text('Market Price: \$${book.marketPrice}'),
                  Text('Selling Price: \$${book.sellingPrice}'),
                  Text('Condition: ${book.condition}'),
                  Text('Location: ${book.location}'),
                ],
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Implement edit functionality
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
