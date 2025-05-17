import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'pages/login_page.dart';
import 'package:forui/forui.dart';
import 'package:smart_auction_platform/pages/sell_item_page.dart';
import 'package:smart_auction_platform/pages/auction_details_page.dart';
import 'package:smart_auction_platform/pages/profile_page.dart';
import 'package:smart_auction_platform/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'Smart Auction Platform',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const LoginPage(),
      ),
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
    SearchPage(),
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
  const HomePage({super.key});

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

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isAuction = true; // true for auction, false for fixed price
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Toggle between Auction and Fixed Price
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isAuction = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:
                                  isAuction ? Colors.blue : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Auctions',
                                style: TextStyle(
                                  color:
                                      isAuction ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isAuction = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color:
                                  !isAuction ? Colors.blue : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Fixed Price',
                                style: TextStyle(
                                  color:
                                      !isAuction ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Search Bar only
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText:
                        isAuction
                            ? 'Search auctions...'
                            : 'Search fixed price items...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                isAuction
                    ? StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('auction')
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No auctions found'));
                        }
                        // Client-side filtering
                        final docs =
                            searchQuery.isEmpty
                                ? snapshot.data!.docs
                                : snapshot.data!.docs.where((doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  final title =
                                      (data['title'] ?? '')
                                          .toString()
                                          .toLowerCase();
                                  return title.contains(searchQuery);
                                }).toList();
                        if (docs.isEmpty) {
                          return const Center(child: Text('No auctions found'));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final doc = docs[index];
                            final data = doc.data() as Map<String, dynamic>;
                            final imageUrl =
                                (data['image_path'] ?? '').toString().isNotEmpty
                                    ? data['image_path']
                                    : 'https://via.placeholder.com/80';
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DynamicDetailsPage(
                                          docId: doc.id,
                                          collection: 'auction',
                                          data: data,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          imageUrl,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.error),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['title'] ?? 'Untitled',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: OMR ${data['price'] ?? '0'}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            if (data['description'] != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                ),
                                                child: Text(
                                                  data['description'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                        );
                      },
                    )
                    : StreamBuilder<QuerySnapshot>(
                      stream:
                          FirebaseFirestore.instance
                              .collection('fixed_price')
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No items found'));
                        }
                        // Client-side filtering
                        final docs =
                            searchQuery.isEmpty
                                ? snapshot.data!.docs
                                : snapshot.data!.docs.where((doc) {
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  final title =
                                      (data['title'] ?? '')
                                          .toString()
                                          .toLowerCase();
                                  return title.contains(searchQuery);
                                }).toList();
                        if (docs.isEmpty) {
                          return const Center(child: Text('No items found'));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final doc = docs[index];
                            final data = doc.data() as Map<String, dynamic>;
                            final imageUrl =
                                (data['image_path'] ?? '').toString().isNotEmpty
                                    ? data['image_path']
                                    : 'https://via.placeholder.com/80';
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DynamicDetailsPage(
                                          docId: doc.id,
                                          collection: 'fixed_price',
                                          data: data,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          imageUrl,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.error),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['title'] ?? 'Untitled',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: OMR ${data['price'] ?? '0'}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            if (data['description'] != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                ),
                                                child: Text(
                                                  data['description'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

// Dynamic Details Page
class DynamicDetailsPage extends StatelessWidget {
  final String docId;
  final String collection;
  final Map<String, dynamic> data;

  const DynamicDetailsPage({
    super.key,
    required this.docId,
    required this.collection,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        (data['image_path'] ?? '').toString().isNotEmpty
            ? data['image_path']
            : 'https://via.placeholder.com/400x200';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auction Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error, size: 40),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] ?? 'Untitled',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: OMR ${data['price'] ?? '0'}',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Item Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['description'] ?? 'No description'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Delete Item'),
                              content: const Text(
                                'Are you sure you want to delete this item?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(true),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                      );
                      if (confirm == true) {
                        await FirebaseFirestore.instance
                            .collection(collection)
                            .doc(docId)
                            .delete();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item deleted successfully.'),
                            ),
                          );
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text('Delete Item'),
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
