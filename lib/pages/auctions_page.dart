import 'package:flutter/material.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Auctions here'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Ended'),
              Tab(text: 'My Bids'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AuctionGridView(type: 'active'),
            AuctionGridView(type: 'ended'),
            AuctionGridView(type: 'myBids'),
          ],
        ),
      ),
    );
  }
}

class AuctionGridView extends StatelessWidget {
  final String type;

  const AuctionGridView({super.key, required this.type});

  // Dummy data
  List<String> _getItems() {
    return List.generate(6, (index) => '$type Auction Item ${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                items[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
