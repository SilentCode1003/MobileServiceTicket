import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ticket/config.dart';
// import 'package:ticket/pages/Nav01.dart';
import 'package:ticket/pages/forgotpw.dart';
import 'package:ticket/pages/hdpages/navbar.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/customhelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool passToggle = true;
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("videos/redbg.mp4");

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  void _loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        usernameController.text = prefs.getString('username') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
        _loadUserDetails();
      }
    });
  }

  void _loadUserDetails() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user.json');
      if (file.existsSync()) {
        final jsonData = await file.readAsString();
        final user = jsonDecode(jsonData);
        // Display the user details
        print('Full Name: ${user['fullname']}');
        print('Username: ${user['username']}');
        print('Role: ${user['role']}');
      }
    } catch (e) {
      print('Error loading user details: $e');
    }
  }
void _saveRememberMeStatus(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('rememberMe', value);
  if (!value) {
    await prefs.remove('username');
    await prefs.remove('password');
  } else {
    final username = usernameController.text;
    final password = passwordController.text;
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}



  Future<void> login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    final url = Uri.parse(Config.apiUrl + Config.authentication);
    final response = await http.post(
      url,
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      // Successful login
      final responseData = json.decode(response.body);
      final objects = responseData['data'] as List<dynamic>;
      final Map<String, dynamic> data = {
        'username': username,
        'password': password,
        'fullname': objects[0]['fullname'],
        'role': objects[0]['role']
      };

      if (responseData['msg'] != 'success') {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Incorrect'),
            content: const Text('Incorrect username and password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Login'),
            content: const Text('Success'),
            actions: [
              TextButton(
                onPressed: () async {
                  createJsonFile(data);

                  _saveRememberMeStatus(rememberMe);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // Failed login
      const errorMessage = 'Login failed. Please try again.';
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Login Error'),
          content: const Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                height: 370,
                width: 370,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.supervised_user_circle),
                ),
              ),
              const SizedBox(height: 10),
                  TextFormField(
              controller: passwordController,
              obscureText: passToggle,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(passToggle ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Password';
                }
                return null;
              },
            ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Remember Me'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(context);
                  }
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
