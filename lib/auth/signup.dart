import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_taxi_app/auth/login.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_svg/svg.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  bool _obscureText = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }
  Future<bool> _register(String email, String password, String confirmPassword) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        return true; // Ensure you return true on success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')),
        );
        return false; // Return false on failure
      }
    } catch (e) {
      print('Error when calling API: $e');
      return false; // Ensure you return false if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 18,
              color: Colors.black,),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageTitle(),
                _buildTextTitle(),
                const SizedBox(height: 30),
                _buildFormRegister(),
                _buildOrSplitDivider(),
                _buildSocialRegister(),
                _buildHaveAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle(){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text(
        "Đăng kí",
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormRegister(){
    return Form(
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUsernameField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildRegisterButton(context),

          ],
        ),
      ),
    );
  }

  Widget _buildTextTitle(){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        child:
        Text("Chào mừng bạn đến với Taxi App, hãy nhập thông tin chi tiết của bạn bên dưới để tiếp tục đặt xe"));
  }

  Widget _buildUsernameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email người dùng",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "Roboto",
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Nhập email người dùng",
              hintStyle: const TextStyle(
                color:  Colors.grey,
                fontSize: 16,
                fontFamily: "Roboto",
              ),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              fillColor: Color(0xFFE1E5E2),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "Roboto",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập email người dùng';
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin:const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mật khẩu",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "Roboto",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Nhập mật khẩu",
                hintStyle: const TextStyle(
                  color: Color(0xFF535353),
                  fontSize: 16,
                  fontFamily: "Roboto",
                ),
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color:Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color:Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                fillColor: Color(0xFFE1E5E2),
                filled: true,
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "Roboto",
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      margin:const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nhập lại mật khẩu",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "Roboto",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    hintText: "Nhập lại mật khẩu",
                    hintStyle: const TextStyle(
                      color: Color(0xFF535353),
                      fontSize: 16,
                      fontFamily: "Roboto",
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color:Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor:Color(0xFFE1E5E2),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color:Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Roboto",
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context){
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 45),
      child: ElevatedButton(
        // onPressed:() async {
        //   // Call the login function with the email and password values
        //   bool isRegisterIn = await _register(emailController.text, passwordController.text, confirmpasswordController.text);
        //   if (isRegisterIn) {
        //     // Navigate to the next screen if login is successful
        //     Navigator.pop(context);
        //   } else {
        //     // Show an error message if login fails
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Đăng nhập thất bại!')),
        //     );
        //   }
        // },
        onPressed: (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()), // Change this to your target screen
      );
    },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBackgroundColor: const Color(0xFF8687E7).withOpacity(0.5)
        ),
        child:  const  Text(
          "ĐĂNG KÍ",
          style:  TextStyle(
              fontSize: 16,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 25 ),
      padding:const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
          const  Text(
            "Hoặc",
            style:  TextStyle(
              fontSize: 16,
              fontFamily: "Roboto",
              color: Color(0xFF979797),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialRegister(){
    return Column(
      children: [
        _buildSocialGoogleLogin(),
        _buildSocialAppleLogin(),
      ],
    );
  }

  Widget _buildSocialGoogleLogin(){
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 28),
      padding:const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: (){
          //TODO : xu ly sau
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            )
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/gg.png",
              // TODO chưa khắc phục được ảnh để tạm
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Đăng kí với Google",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialAppleLogin(){
    return Container(
      width: double.infinity,
      height: 48,
      padding:const EdgeInsets.symmetric(horizontal: 24),
      // margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: (){
          //TODO : xu ly sau
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            )
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/appple.png",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              color: Colors.black,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Đăng kí với Facebook",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHaveAccount(BuildContext context){
    return Container(
      margin:const EdgeInsets.only(top: 30, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(text: "Đã có tài khoản? ",
          style:const TextStyle(
              fontSize: 14,
              fontFamily: "Roboto",
              color: Color(0xFF979797)
          ),
          children: [
            TextSpan(text: "Đăng nhập",
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
                recognizer: TapGestureRecognizer()..onTap = (){
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
