import 'package:flutter/material.dart';
// import 'package:ticket/hidden_drawer.txt';
import 'package:ticket/pages/hdpages/navbar.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:ticket/pages/forgotpw.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("videos/redbg.mp4");

  ChewieController? chewieController;

  // @override
  // void initState() {
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     aspectRatio: 16 / 9,
  //     autoPlay: true,
  //     looping: true,
  //     autoInitialize: false,
  //     showControls: true,
  //   );
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
                key: _formfield,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: Chewie(
                    //     controller: chewieController!,
                    //   ),
                    // ), 
                    Image.asset(
                      'images/logo.png',
                      height: 370,
                      width: 370,
                    ),
                    // const Icon(
                    //   Icons.data_thresholding,
                    //   size: 200,
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.teal),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Enter Email';
                        } else if (!emailValid) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (passController.text.length < 6) {
                          return "Password too Short";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () {
                          if (_formfield.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Welcome",
                                    textAlign: TextAlign.center),
                                content: const Text("Welcome Back!",
                                    textAlign: TextAlign.center),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            // const HiddeDrawer(),
                                            // const HomePage(),
                                            const Homepage(),
                                      ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.grey[400],
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "Okay",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            emailController.clear();
                            passController.clear();
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ForgotPassword();
                            }));
                          },
                          child: const Text(
                            "Click Here",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

// other

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: <Widget>[
          //         SizedBox(
          //             width: double.maxFinite,
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Colors.red,
          //               ),
          //               onPressed: () {},
          //               child: const Text(
          //                 'Become a programmer',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   letterSpacing: 0.5,
          //                 ),
          //               ),
          //             )),
          //         SizedBox(
          //           width: double.maxFinite,
          //           child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          //             onPressed: () {},
          //             child: const Text(
          //               'Login',
          //               style: TextStyle(
          //                 color: Colors.black87,
          //                 letterSpacing: 0.5,
          //               ),
          //             ),
          //           ),
          //         ),
          //         const SizedBox(height: 20)
          //       ],
          //     ),
          //   ),
          // )
//         ],
//       ),
//     );
//   }
// }
