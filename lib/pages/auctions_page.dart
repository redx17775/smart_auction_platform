import 'package:flutter/material.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

  // Reusing the auction items from home.dart
  final List<Map<String, String>> auctionItems = const [
    {'image': 'drill.jpg', 'title': 'Drill', 'price': '7 OMR'},
    {'image': 'Dozer.jpg', 'title': 'Dozer', 'price': '6000 OMR'},
    {'image': 'Frontier.jpg', 'title': 'Frontier', 'price': '52 OMR'},
    {'image': 'Breaker.jpg', 'title': 'Breaker', 'price': '98 OMR'},
  ];

  String _getDescription(String title) {
    switch (title) {
      case 'Drill':
        return 'A well-maintained used drill press for metalworking.';
      case 'Dozer':
        return 'Heavy-duty bulldozer for construction and earthmoving.';
      case 'Frontier':
        return 'Reliable tool for various frontier tasks.';
      case 'Breaker':
        return 'Powerful breaker machine for demolition.';
      default:
        return 'Auction item description.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Auctions'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Ended'),
              Tab(text: 'My Bids'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active Auctions Grid
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: auctionItems.length,
                itemBuilder: (context, index) {
                  final item = auctionItems[index];
                  return _auctionGridItem(context, item);
                },
              ),
            ),
            // Ended Auctions (same grid but could filter different items)
            const Center(child: Text('Ended Auctions')),
            // My Bids
            const Center(child: Text('My Bids')),
          ],
        ),
      ),
    );
  }

  Widget _auctionGridItem(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuctionDetailsPage(
              imagePath: 'assets/images/${item['image']}',
              title: item['title']!,
              currentBid: item['price']!,
              description: _getDescription(item['title']!),
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/${item['image']}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item['price']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}