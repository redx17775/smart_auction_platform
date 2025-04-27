import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AuctionDetailsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String currentBid;
  final String description;

  const AuctionDetailsPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.currentBid,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auction Details'),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'Current bid: $currentBid',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Item Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 24),
            const Text(
              'Bidding Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your bid',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text('Place Bid'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FBottomNavigationBar(
        index: 0,
        onChange: (int index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        children: [
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.house),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.search),
            label: const Text('Auctions'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.plus),
            label: const Text('Sell Item'),
          ),
          FBottomNavigationBarItem(
            icon: FIcon(FAssets.icons.user),
            label: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
