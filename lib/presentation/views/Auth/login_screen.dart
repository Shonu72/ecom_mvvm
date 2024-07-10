import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/auth_controller.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    animationURL = "assets/login.riv";
    _initializeRive();
  }

  Future<void> _initializeRive() async {
    await RiveFile.initialize();
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          for (var e in stateMachineController!.inputs) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          }

          for (var element in stateMachineController!.inputs) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          }
        }
        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  void login() async {
    setState(() {
      isLoading = true;
    });
    isChecking?.change(false);
    isHandsUp?.change(false);
    Future<bool> loggedin = authController.loginUser(
        username: _usernameController.text, password: _passwordController.text);
    if (await loggedin) {
      successTrigger?.fire();
      Future.delayed(const Duration(seconds: 2), () {
        context.pushNamed('mainpage', pathParameters: {
          'initialIndex': '0',
        });
      });
    } else {
      failTrigger?.fire();
    }
    setState(() {
      isLoading = false;
    });
  }

  void error() {
    failTrigger?.fire();
    Helper.toast("Please enter valid details");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_teddyArtboard != null)
                    SizedBox(
                      width: 400,
                      height: 300,
                      child: Rive(
                        artboard: _teddyArtboard!,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  Container(
                    alignment: Alignment.center,
                    width: 400,
                    padding: const EdgeInsets.only(bottom: 15),
                    margin: const EdgeInsets.only(bottom: 15 * 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              CustomTextField(
                                controller: _usernameController,
                                hintText: "Username",
                                onChanged: () => moveEyeBalls,
                                prefixIcon: const Icon(Icons.person),
                                obscureText: false,
                                ontap: lookOnTheTextField,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter username";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                obscureText: true,
                                ontap: handsOnTheEyes,
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: false,
                                        onChanged: (value) {
                                          Helper.saveUser(
                                              key: "isLoggedIn", value: true);
                                        },
                                      ),
                                      const Text("Remember me"),
                                    ],
                                  ),
                                  isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            Helper.validateField(
                                                            _usernameController
                                                                .text) ==
                                                        null &&
                                                    Helper.validateField(
                                                            _passwordController
                                                                .text) ==
                                                        null
                                                ? login()
                                                : error();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                          ),
                                          child: const Text("Login",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  TextButton(
                                    onPressed: () {
                                      context.push('/register');
                                    },
                                    child: const Text(
                                      "Register Now",
                                      style: TextStyle(
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: AppText(
                text: "hCommerce - Login",
                size: 20,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
