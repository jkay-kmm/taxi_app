import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
  Widget _buildPageTitle(){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 30),
      child: const Text(
        "Đăng kí",
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: "Lato",
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
            // const SizedBox(height: 25,),
            _buildRegisterButton(),

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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Số điện thoại người dùng",
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

  Widget _buildRegisterButton(){
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 45),
      child: ElevatedButton(
        onPressed: (){},
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
            "Or container with",
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
                "Đăng kis Google",
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
                "Đăng kí Facebook",
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
  Widget _buildHaveAccount(BuildContext context){
    return Container(
      margin:const EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(text: "Đã có tài khoản? ",
          style:const TextStyle(
              fontSize: 12,
              fontFamily: "Lato",
              color: Color(0xFF979797)
          ),
          children: [
            TextSpan(text: "Đăng nhập",
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Lato",
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
