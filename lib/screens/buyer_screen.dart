import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/app_drawer.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final List<Book> _books = [
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
    // Add more sample books here
  ];

  String _selectedGenre = 'All';
  RangeValues _priceRange = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Books'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedGenre,
                    items: ['All', 'Programming', 'Fiction', 'Science']
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      '\$${_priceRange.start.round()}',
                      '\$${_priceRange.end.round()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                if ((_selectedGenre == 'All' || book.genre == _selectedGenre) &&
                    book.sellingPrice >= _priceRange.start &&
                    book.sellingPrice <= _priceRange.end) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(book.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Author: ${book.writerName}'),
                          Text('Price: \$${book.sellingPrice}'),
                          Text('Condition: ${book.condition}'),
                          Text('Location: ${book.location}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
