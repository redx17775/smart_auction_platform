import 'package:flutter/material.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

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

  // Sample auction data
  List<Map<String, dynamic>> _getAuctions() {
    switch (type) {
      case 'active':
        return [
          {
            'image': 'drill.jpg',
            'title': 'Used Drill Press',
            'currentBid': '500 OMR',
            'myBid': '480 OMR',
            'timeLeft': '2h 30m',
            'bids': 12,
          },
          {
            'image': 'Dozer.jpg',
            'title': 'Bulldozer',
            'currentBid': '6000 OMR',
            'myBid': '5500 OMR',
            'timeLeft': '1d 4h',
            'bids': 8,
          },
        ];
      case 'ended':
        return [
          {
            'image': 'Frontier.jpg',
            'title': 'Frontier Tool',
            'currentBid': '52 OMR',
            'myBid': '50 OMR',
            'status': 'Sold',
            'winner': 'You',
          },
        ];
      case 'myBids':
        return [
          {
            'image': 'drill.jpg',
            'title': 'Used Drill Press',
            'currentBid': '500 OMR',
            'myBid': '480 OMR',
            'status': 'Outbid',
          },
          {
            'image': 'Dozer.jpg',
            'title': 'Bulldozer',
            'currentBid': '6000 OMR',
            'myBid': '5500 OMR',
            'status': 'Winning',
          },
          {
            'image': 'Frontier.jpg',
            'title': 'Frontier Tool',
            'currentBid': '52 OMR',
            'myBid': '50 OMR',
            'status': 'Lost',
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final auctions = _getAuctions();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: auctions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final auction = auctions[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AuctionDetailsPage(
                    imagePath: 'assets/images/${auction['image']}',
                    title: auction['title'],
                    currentBid: auction['currentBid'],
                    description: _getDescription(auction['title']),
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
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
                        'assets/images/${auction['image']}',
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
                          auction['title'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Current: ${auction['currentBid']}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'My Bid: ${auction['myBid']}',
                          style: TextStyle(
                              color: _getStatusColor(auction['status']),
                              fontSize: 14),
                        ),
                        if (auction['timeLeft'] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Time left: ${auction['timeLeft']}',
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12),
                            ),
                          ),
                        if (auction['status'] != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Status: ${auction['status']}',
                              style: TextStyle(
                                  color: _getStatusColor(auction['status']),
                                  fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'winning':
        return Colors.green;
      case 'outbid':
        return Colors.red;
      case 'lost':
        return Colors.grey;
      case 'sold':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
}