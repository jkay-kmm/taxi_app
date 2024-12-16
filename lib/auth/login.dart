
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_taxi_app/auth/signup.dart';

import '../common/nav_bar_screen.dart';

import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> login (String email, String password) async {
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
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print('Đăng nhập thành công: $data');
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Đăng nhập thành công!"),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      } else {
        print('Đăng nhập thất bại: ${response.body}');
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');

      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
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
                _buildFormLogin(context),
                _buildOrSplitDivider(),
                _buildSocialLogin(),
                _buildHaveNotAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle(){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
      child: const Text(
        "Đăng nhập",
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormLogin(BuildContext context){
    return Form(
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUsernameField(),
            _buildPasswordField(),
            _buildLoginButton(context),

          ],
        ),
      ),
    );
  }

  Widget _buildTextTitle(){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        child:
        Text("Đăng nhập vào tài khoản của bạn một cách nhanh chóng và an toàn"));
  }

  Widget _buildUsernameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email người dùng ",
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
              hintText: "Nhập email người dùng  ",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "Roboto",
              ),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mật khẩu ",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "Roboto",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Nhập mật khẩu",
                hintStyle: const TextStyle(
                  color: Colors.grey,
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
                fillColor: Color(0xFFE1E5E2),
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
                color:Colors.grey,
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
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context){
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        onPressed: () async {
          // Call the login function with the email and password values
          bool isLoggedIn = await login(emailController.text, passwordController.text);
          if (isLoggedIn) {
            // Navigate to the next screen if login is successful
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()), // Change this to your target screen
            );
          } else {
            // Show an error message if login fails
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập thất bại!')),
            );
          }
        },
        // onPressed: (){
        //   Navigator.pushReplacement(
        //             context,
        //             MaterialPageRoute(builder: (context) => const BottomNavBar()), // Change this to your target screen
        //           );
        // },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBackgroundColor: const Color(0xFF8687E7).withOpacity(0.5)
        ),
        child:  const  Text(
          "ĐĂNG NHẬP",
          style:  TextStyle(
              fontSize: 16,
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 25 , ),
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
            "hoặc",
            style:  TextStyle(
              fontSize: 16,
              fontFamily: "Lato",
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

  Widget _buildSocialLogin(){
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
              color: Colors.grey ,
            )
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/gg.png",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Đăng nhập với Google",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Lato",
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
              color: Colors.grey ,
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
                "Đăng nhập với Apple",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHaveNotAccount(BuildContext context){
    return Container(
      margin:const EdgeInsets.only(top: 30, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(text: "Bạn đã có tài khoản chưa ? ",
          style:const TextStyle(
              fontSize: 14,
              fontFamily: "Lato",
              color: Color(0xFF979797)
          ),
          children: [
            TextSpan(text: "Đăng kí",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Lato",
                  color: Colors.black,
                ),
                recognizer: TapGestureRecognizer()..onTap = (){
                  _goToRegisterPage(context);
                }
            ),
          ],
        ),
      ),
    );
  }

  void _goToRegisterPage(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const RegisterPage()));
  }
}

