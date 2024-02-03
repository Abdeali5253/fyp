import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<UserCredential> signUp(String email, String password, String name, String location) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    // Save user details in Firestore
    await _firestore.collection('users').doc(user!.uid).set({
      'name': name,
      'email': email,
      'location': location,
    });

    // Uncomment the following to use Realtime Database instead
    /*
    await _database.ref().child('users').child(user!.uid).set({
      'name': name,
      'email': email,
      'location': location,
    });
    */

    return result;
  }

// Add more methods as needed for login, logout, etc.
}
