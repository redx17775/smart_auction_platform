import 'package:flutter/material.dart';
import 'package:smart_auction_platform/main.dart';

class ProfilePage extends StatelessWidget {
  final double containerPadding = 24.0;
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight - 140; // 70px top + 70px bottom
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to HomePage and clear the stack
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Application()),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
            top: 70,
            bottom: 70,
            left: 20,
            right: 20,
          ),
          padding: EdgeInsets.all(containerPadding),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(24),
          ),
          width: double.infinity,
          height: containerHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/pfp.png'),
              ),
              const SizedBox(height: 32),
              const Text(
                'Albasil',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Al- Rawahi',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text('Joined: 2023-01-01', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              const Text('+968 9123 4567', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
