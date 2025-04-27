import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:smart_auction_platform/pages/sell_item_page.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';
import 'package:smart_auction_platform/pages/profile_page.dart';
import 'package:smart_auction_platform/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auction App',
      builder:
          (context, child) => FTheme(data: FThemes.zinc.light, child: child!),
      home: const LoginPage(),
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

  // Define pages for each tab (must match the nav bar)
  final List<Widget> _pages = [
    HomePage(),
    BrowsePage(),
    // The third tab is Sell Item, which opens as a modal, so we use a placeholder
    Container(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index], // Show current page based on selected index
      bottomNavigationBar: FBottomNavigationBar(
        index: index,
        onChange: (int selectedIndex) {
          if (selectedIndex == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SellItemPage()),
            );
          } else {
            setState(() {
              index = selectedIndex;
            });
          }
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 80,
          child: Image.asset('assets/images/logo.gif', fit: BoxFit.contain),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Auction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const AuctionDetailsPage(
                                imagePath: 'assets/images/drill.jpg',
                                title: 'Used Drill Press',
                                currentBid: 'OMR 500',
                                description:
                                    'A well-maintained used drill press for metalworking with all original parts.',
                              ),
                        ),
                      );
                    },
                    child: _buildFCard(
                      'assets/images/drill.jpg',
                      'Drill',
                      '7 OMR',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const AuctionDetailsPage(
                                imagePath: 'assets/images/Dozer.jpg',
                                title: 'Bulldozer',
                                currentBid: 'OMR 6000',
                                description:
                                    'Heavy-duty bulldozer suitable for construction and earthmoving.',
                              ),
                        ),
                      );
                    },
                    child: _buildFCard(
                      'assets/images/Dozer.jpg',
                      'Dozer',
                      '6000 OMR',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const AuctionDetailsPage(
                                imagePath: 'assets/images/Frontier.jpg',
                                title: 'Frontier Tool',
                                currentBid: 'OMR 52',
                                description:
                                    'Reliable tool for various frontier tasks and repairs.',
                              ),
                        ),
                      );
                    },
                    child: _buildFCard(
                      'assets/images/Frontier.jpg',
                      'Frontier',
                      '52 OMR',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => const AuctionDetailsPage(
                                imagePath: 'assets/images/Breaker.jpg',
                                title: 'Breaker Machine',
                                currentBid: 'OMR 98',
                                description:
                                    'Powerful breaker machine for demolition and construction.',
                              ),
                        ),
                      );
                    },
                    child: _buildFCard(
                      'assets/images/Breaker.jpg',
                      'Breaker',
                      '98 OMR',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Current Auction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => const AuctionDetailsPage(
                          imagePath: 'assets/images/drill.jpg',
                          title: 'Used Drill Press',
                          currentBid: 'OMR 500',
                          description:
                              'A well-maintained used drill press for metalworking with all original parts.',
                        ),
                  ),
                );
              },
              child: _buildVerticalAuctionCard(
                'assets/images/drill.jpg',
                'Drill',
                '7 OMR',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => const AuctionDetailsPage(
                          imagePath: 'assets/images/Frontier.jpg',
                          title: 'Frontier Tool',
                          currentBid: 'OMR 52',
                          description:
                              'Reliable tool for various frontier tasks and repairs.',
                        ),
                  ),
                );
              },
              child: _buildVerticalAuctionCard(
                'assets/images/Frontier.jpg',
                'Frontier',
                '52 OMR',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => const AuctionDetailsPage(
                          imagePath: 'assets/images/Breaker.jpg',
                          title: 'Breaker Machine',
                          currentBid: 'OMR 98',
                          description:
                              'Powerful breaker machine for demolition and construction.',
                        ),
                  ),
                );
              },
              child: _buildVerticalAuctionCard(
                'assets/images/Breaker.jpg',
                'Breaker',
                '98 OMR',
              ),
            ),
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
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
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
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
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
  // Mock data for auctions the user is part of
  final List<Map<String, String>> myAuctions = const [
    {
      'image': 'assets/images/drill.jpg',
      'name': 'Used Drill Press',
      'myBid': 'OMR 480',
      'currentBid': 'OMR 500',
    },
    {
      'image': 'assets/images/Dozer.jpg',
      'name': 'Bulldozer',
      'myBid': 'OMR 5500',
      'currentBid': 'OMR 6000',
    },
    {
      'image': 'assets/images/Frontier.jpg',
      'name': 'Frontier Tool',
      'myBid': 'OMR 50',
      'currentBid': 'OMR 52',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Auctions'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: myAuctions.length,
        itemBuilder: (context, index) {
          final auction = myAuctions[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => AuctionDetailsPage(
                        imagePath: auction['image']!,
                        title: auction['name']!,
                        currentBid: auction['currentBid']!,
                        description: _getDescriptionForItem(auction['name']!),
                      ),
                ),
              );
            },
            child: Card(
              color: Colors.grey[200],
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        auction['image']!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auction['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'My Bid: ${auction['myBid']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Current Bid: ${auction['currentBid']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDescriptionForItem(String name) {
    switch (name) {
      case 'Used Drill Press':
        return 'A well-maintained used drill press for metalworking with all original parts.';
      case 'Bulldozer':
        return 'Heavy-duty bulldozer suitable for construction and earthmoving.';
      case 'Frontier Tool':
        return 'Reliable tool for various frontier tasks and repairs.';
      default:
        return 'Powerful breaker machine for demolition and construction.';
    }
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Page'));
  }
}
