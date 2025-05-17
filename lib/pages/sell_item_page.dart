import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellItemPage extends StatefulWidget {
  const SellItemPage({super.key});

  @override
  State<SellItemPage> createState() => _SellItemPageState();
}

class _SellItemPageState extends State<SellItemPage> {
  final int _selectedIndex = 2;
  int _selectedMethod = 0; // 0: Fixed Price, 1: Auction
  File? _selectedImage;
  Uint8List? _webImageBytes;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _onNavBarTap(int index) {
    if (index == 2) return; // Already on Sell Item
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          _selectedImage = null;
        });
      } else {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _webImageBytes = null;
        });
      }
    }
  }

  void _submitItem() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final price = _priceController.text.trim();
    final hasImage = _selectedImage != null || _webImageBytes != null;

    if (name.isEmpty || description.isEmpty || price.isEmpty || !hasImage) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Please fill all fields and upload an image.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Are you sure you want to submit this item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final itemData = {
                    'title': _nameController.text.trim(),
                    'description': _descriptionController.text.trim(),
                    'price': int.tryParse(_priceController.text.trim()) ?? 0,
                    'image_path': _selectedImage?.path ?? '',
                    'id': DateTime.now().millisecondsSinceEpoch,
                  };
                  final collection =
                      _selectedMethod == 0 ? 'fixed_price' : 'auction';
                  await FirebaseFirestore.instance
                      .collection(collection)
                      .add(itemData);

                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Item Submitted!'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title: 	${itemData['title']}'),
                              Text('Description: 	${itemData['description']}'),
                              Text('Price: 	${itemData['price']}'),
                              Text('Image Path: 	${itemData['image_path']}'),
                              Text('ID: 	${itemData['id']}'),
                              Text(
                                'Type: 	${collection == 'fixed_price' ? 'Fixed Price' : 'Auction'}',
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.of(context).pop(); // Go back
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Your Item'),
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
            const Text(
              'Select Selling Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethod = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            _selectedMethod == 0
                                ? Colors.white
                                : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:
                            _selectedMethod == 0
                                ? [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                                : [],
                        border: Border.all(
                          color:
                              _selectedMethod == 0
                                  ? Colors.black12
                                  : Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Fixed Price',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethod = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color:
                            _selectedMethod == 1
                                ? Colors.white
                                : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow:
                            _selectedMethod == 1
                                ? [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                                : [],
                        border: Border.all(
                          color:
                              _selectedMethod == 1
                                  ? Colors.black12
                                  : Colors.transparent,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Auction',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Item Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter item name',
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
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter item description',
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
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  _webImageBytes != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          _webImageBytes!,
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      )
                      : _selectedImage == null
                      ? const Text(
                        'Select image',
                        style: TextStyle(color: Colors.grey),
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Pricing Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            if (_selectedMethod == 0) // Fixed Price
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Set fixed price (if applicable)',
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
              ),
            if (_selectedMethod == 1) // Auction
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Starting bid price (if auction)',
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
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FBottomNavigationBar(
        index: _selectedIndex,
        onChange: _onNavBarTap,
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
