import 'package:flutter/material.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

  // Sample auction data
  final List<Map<String, String>> activeAuctions = const [
    {'image': 'drill.jpg', 'title': 'Used Drill Press', 'price': '500 OMR', 'myBid': '480 OMR'},
    {'image': 'Dozer.jpg', 'title': 'Bulldozer', 'price': '6000 OMR', 'myBid': '5500 OMR'},
  ];

  final List<Map<String, String>> endedAuctions = const [
    {'image': 'Frontier.jpg', 'title': 'Frontier Tool', 'price': '52 OMR', 'myBid': '50 OMR'},
  ];

  final List<Map<String, String>> myBids = const [
    {'image': 'drill.jpg', 'title': 'Used Drill Press', 'price': '500 OMR', 'myBid': '480 OMR'},
    {'image': 'Dozer.jpg', 'title': 'Bulldozer', 'price': '6000 OMR', 'myBid': '5500 OMR'},
    {'image': 'Frontier.jpg', 'title': 'Frontier Tool', 'price': '52 OMR', 'myBid': '50 OMR'},
  ];

  String _getDescription(String title) {
    switch (title) {
      case 'Used Drill Press':
        return 'A well-maintained used drill press for metalworking.';
      case 'Bulldozer':
        return 'Heavy-duty bulldozer for construction and earthmoving.';
      case 'Frontier Tool':
        return 'Reliable tool for various frontier tasks.';
      default:
        return 'Auction item description.';
    }
  }

  Widget _buildAuctionGrid(List<Map<String, String>> items) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _auctionGridItem(context, item);
        },
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
                    top: Radius.circular(12)),
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
                        fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Current: ${item['price']}',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'My Bid: ${item['myBid']}',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Auctions'),
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
            _buildAuctionGrid(activeAuctions),
            _buildAuctionGrid(endedAuctions),
            _buildAuctionGrid(myBids),
          ],
        ),
      ),
    );
  }
}