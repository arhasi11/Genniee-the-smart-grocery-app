import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'create_account_screen.dart';
import 'admin_dashboard_screen.dart';
import '../utils/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final enteredEmail = _email.text.trim();
      final enteredPassword = _password.text.trim();

      if (enteredEmail == 'admin@gennie.com' && enteredPassword == 'admin123') {
        await SharedPrefs.saveLoginStatus(true);
        await SharedPrefs.saveUserName("Admin");
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
        );
      } else {
        await SharedPrefs.saveLoginStatus(true);
        // Extract name from email before '@'
        final extractedName = enteredEmail.split('@').first;
        final formattedName = extractedName[0].toUpperCase() + extractedName.substring(1);
        await SharedPrefs.saveUserName(formattedName);
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(showWelcome: true), // ✅ Trigger welcome popup
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/Ge.png',
                height: 160,
              ),
              const SizedBox(height: 30),
              const Text(
                'Welcome to Gennie!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Email is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateAccountScreen()),
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
