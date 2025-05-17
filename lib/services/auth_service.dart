import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _usersCollection = 'user';

  // Get current user
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Auth state changes stream
  Stream<UserModel?> get authStateChanges => _firestore
      .collection(_usersCollection)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs
                .map((doc) => UserModel.fromMap(doc.data()))
                .firstOrNull,
      );

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      print('Attempting to sign in with email: $email'); // Debug log

      // Query the users collection for the email
      final QuerySnapshot result =
          await _firestore
              .collection(_usersCollection)
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      print('Query result size: ${result.docs.length}'); // Debug log

      if (result.docs.isEmpty) {
        print('No user found with email: $email'); // Debug log
        throw 'No user found with this email.';
      }

      // Get the user document
      final userDoc = result.docs.first;
      final userData = userDoc.data() as Map<String, dynamic>;

      print('User data found: ${userData.toString()}'); // Debug log

      // Verify password
      if (userData['password'] != password) {
        print('Password mismatch for user: $email'); // Debug log
        throw 'Wrong password provided.';
      }

      // Create user model
      _currentUser = UserModel.fromMap({'id': userDoc.id, ...userData});

      print(
        'User successfully authenticated: ${_currentUser?.email}',
      ); // Debug log
      return _currentUser!;
    } catch (e) {
      print('Authentication error: $e'); // Debug log
      if (e is FirebaseException) {
        throw 'Firebase error: ${e.message}';
      }
      throw _handleAuthException(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    _currentUser = null;
  }

  // Handle auth exceptions
  String _handleAuthException(String error) {
    print('Handling auth exception: $error'); // Debug log

    if (error.contains('No user found')) {
      return 'No user found with this email.';
    } else if (error.contains('Wrong password')) {
      return 'Wrong password provided.';
    } else if (error.contains('invalid-email')) {
      return 'The email address is not valid.';
    } else if (error.contains('user-disabled')) {
      return 'This user account has been disabled.';
    } else if (error.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later.';
    } else if (error.contains('Firebase error')) {
      return 'Connection error. Please check your internet connection.';
    } else {
      return 'An error occurred: $error';
    }
  }
}
