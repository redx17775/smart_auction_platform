import 'package:flutter/material.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 80,
                child: Image.asset('assets/images/logo.gif', fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Active Auction', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _auctionCard(context, 'drill.jpg', 'Drill', '7 OMR'),
                  _auctionCard(context, 'Dozer.jpg', 'Dozer', '6000 OMR'),
                  _auctionCard(context, 'Frontier.jpg', 'Frontier', '52 OMR'),
                  _auctionCard(context, 'Breaker.jpg', 'Breaker', '98 OMR'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Current Auction', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _verticalCard(context, 'drill.jpg', 'Drill', '7 OMR'),
            _verticalCard(context, 'Frontier.jpg', 'Frontier', '52 OMR'),
            _verticalCard(context, 'Breaker.jpg', 'Breaker', '98 OMR'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _auctionCard(BuildContext context, String image, String title, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuctionDetailsPage(
              imagePath: 'assets/images/$image',
              title: title,
              currentBid: price,
              description: _getDescription(title),
            ),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                'assets/images/$image',
                height: 150,
                width: 280,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _verticalCard(BuildContext context, String image, String title, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuctionDetailsPage(
              imagePath: 'assets/images/$image',
              title: title,
              currentBid: price,
              description: _getDescription(title),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.asset(
                'assets/images/$image',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
}
