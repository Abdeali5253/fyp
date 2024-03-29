import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return _auth.signInWithCredential(credential);
    } else {
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<User> signUp(String email, String password, String name) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    if (user != null) {
      // Update the user's displayName with the provided name
      await user.updateDisplayName(name);
      await user.reload(); // Reload user to ensure displayName is updated

      // Optionally, get the current location if needed
      String location = await _getCurrentLocation();

      // Save user details in Firestore, including location if necessary
      // await _firestore.collection('users').doc(user.uid).set({
      //   'name': name,
      //   'email': email,
      //   'location': location,
      // });

      // Return the updated user
      return FirebaseAuth.instance.currentUser!;
    } else {
      throw FirebaseAuthException(code: 'ERROR_USER_NOT_CREATED', message: 'User could not be created.');
    }
  }


  Future<String> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Handle the case when the user denies permission forever
        throw Exception('Location permissions are permanently denied');
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      return '${position.latitude},${position.longitude}';
    } else {
      // Handle the case when permission is still not granted
      throw Exception('Location permissions are denied');
    }
  }

  Future<UserCredential> login(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result;
  }

  User? checkUser() {
    return _auth.currentUser;
  }

}
