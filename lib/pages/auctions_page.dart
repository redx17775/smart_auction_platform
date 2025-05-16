import 'package:flutter/material.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
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
        body: const TabBarView(
          children: [
            Center(child: Text('Active Auction List')),
            Center(child: Text('Ended Auctions')),
            Center(child: Text('My Bids')),
          ],
        ),
      ),
    );
  }
}
