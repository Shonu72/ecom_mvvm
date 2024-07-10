import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    animationURL = "assets/login.riv";
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

  void register() {
    setState(() {
      isLoading = true;
    });
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (_emailController.text == "admin" &&
        _passwordController.text == "admin") {
      successTrigger?.fire();
      Future.delayed(const Duration(seconds: 2), () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => const DemoScreen()));
      });
    } else {
      failTrigger?.fire();
    }
    setState(() {
      isLoading = false;
    });
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
                  // const Text("ABCD"),
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
                                controller: _emailController,
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
                                                            _emailController
                                                                .text) ==
                                                        null &&
                                                    Helper.validateField(
                                                            _passwordController
                                                                .text) ==
                                                        null
                                                ? register()
                                                : Helper.toast(
                                                    "Please enter valid details");
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                          ),
                                          child: const Text("Register",
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
                                  const Text("Already have an account? "),
                                  TextButton(
                                    onPressed: () {
                                      context.push('/login');
                                    },
                                    child: const Text(
                                      "Login Now",
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
          const SizedBox(
            height: 20,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Positioned(
                    // top: 70,
                    // right: 20,
                    // left: 150,
                    child: AppText(
                  text: "hCommerce - Register",
                  size: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
