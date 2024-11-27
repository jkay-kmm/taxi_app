
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_taxi_app/auth/signup.dart';

import '../common/nav_bar_screen.dart';



class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // _buildPasswordField(),
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Số điện thoại",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Lato",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nhập số điện thoại",
                  hintStyle: const TextStyle(
                    color: Color(0xFF535353),
                    fontSize: 16,
                    fontFamily: "Lato",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Lato",
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
  // Widget _buildPasswordField() {
  //   return Container(
  //     margin:const EdgeInsets.only(top: 25),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               "Mật khẩu",
  //               style: TextStyle(
  //                 color:  Colors.black,
  //                 fontSize: 16,
  //                 fontFamily: "Lato",
  //               ),
  //             ),
  //             Container(
  //               margin: const EdgeInsets.only(top: 8),
  //               child: TextFormField(
  //                 decoration: InputDecoration(
  //                   hintText: "* * * * * * * * * * *",
  //                   hintStyle: const TextStyle(
  //                     color: Color(0xFF535353),
  //                     fontSize: 16,
  //                     fontFamily: "Lato",
  //                   ),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                   fillColor: Colors.white,
  //                   filled: true,
  //                 ),
  //                 style: const TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                   fontFamily: "Lato",
  //                 ),
  //                 obscureText: true,
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildLoginButton(BuildContext context){
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNavBar()));
        },
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
      margin:const EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(text: "Bạn đã có tài khoarn chưa ? ",
          style:const TextStyle(
              fontSize: 12,
              fontFamily: "Lato",
              color: Color(0xFF979797)
          ),
          children: [
            TextSpan(text: "Đăng kí",
                style: TextStyle(
                  fontSize: 12,
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

