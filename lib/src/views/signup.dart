import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/src/services/location_picker_service.dart';
import 'package:fyp/src/views/home_screen.dart';
import 'package:fyp/src/widgets/app_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/auth_service.dart';
import '../widgets/custom_form.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  void _pickLocationWithGoogleMaps() async {
    final result = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Select Your Location')),
          body: LocationPicker(
            onLocationSelected: (location) {
              Navigator.of(context).pop(location);
            },
          ),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _locationController.text = "${result.latitude}, ${result.longitude}";
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Sign Up", showHomeIcon: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CustomTextFormField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _locationController,
                  label: 'Location',
                  icon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter or select your location';
                    }
                    return null;
                  },
                  onTap: () {
                    _pickLocationWithGoogleMaps();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      _getCurrentLocation();
                    },
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Only proceed if the form is valid
                      _signUp();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.redAccent
                  ),
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 16.0),
                _buildSocialSignUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() {
    // Implement the sign-up logic, e.g., calling a method from your AuthService
    // TODO: Implement sign-up logic
  }

  Widget _buildSocialSignUpButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.login),
      label: Text('Sign up with Google'),
      onPressed: () async {
        try {
          await _authService.signInWithGoogle();
          // Handle successful Google sign-in
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } catch (error) {
          // Handle sign-in error
          // TODO: Show an error message
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle it accordingly.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle it accordingly.
      return Future.error('Location permissions are permanently denied');
    }

    // When permissions are granted, continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _locationController.text = "${position.latitude}, ${position.longitude}";
    });
  }
}
