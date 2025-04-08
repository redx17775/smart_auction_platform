import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auction App',
      builder: (context, child) => FTheme(
        data: FThemes.zinc.light,
        child: child!,
      ),
      home: Application(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int index = 0; // Default selected index

  // Define pages for each tab
  final List<Widget> _pages = [
    HomePage(),
    BrowsePage(), // Create your BrowsePage widget
    RadioPage(),  // Create your RadioPage widget
    LibraryPage(), // Create your LibraryPage widget
    SearchPage(), // Create your SearchPage widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index], // Show current page based on selected index
      bottomNavigationBar: FBottomNavigationBar(
        index: index,
        onChange: (int selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Auction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  _buildFCard('assets/images/drill.jpg', 'Drill', '7 OMR'),
                  _buildFCard('assets/images/Dozer.jpg', 'Dozer', '6000 OMR'),
                  _buildFCard('assets/images/Frontier.jpg', 'Frontier', '52 OMR'),
                  _buildFCard('assets/images/Breaker.jpg', 'Breaker', '98 OMR'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Current Auction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildVerticalAuctionCard('assets/images/drill.jpg', 'Drill', '7 OMR'),
            _buildVerticalAuctionCard('assets/images/Frontier.jpg', 'Frontier', '52 OMR'),
            _buildVerticalAuctionCard('assets/images/Breaker.jpg', 'Breaker', '98 OMR'),
          ],
        ),
      ),
    );
  }

  // Horizontal FCard that takes image, title, and price as parameters
  Widget _buildFCard(String image, String title, String price) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12, bottom: 16),
      child: FCard(
        image: AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(price),
      ),
    );
  }

  // Vertical Card with Image on Left that takes image, title, and price as parameters
  Widget _buildVerticalAuctionCard(String image, String title, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BrowsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Browse Page'));
  }
}

class RadioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Radio Page'));
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Library Page'));
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Page'));
  }
}
