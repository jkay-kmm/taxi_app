
import 'package:flutter/material.dart';
import 'package:global_taxi_app/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../onbording/onbording_screen.dart';
import '../ultils/contants.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  Future<void> _checkAppState(BuildContext context) async{
    // Kiem tra xem co kOnboardingCompleted
    final isComplete = await _isOnboardingCompleted();
    if(isComplete){
      // di chuyen den man hinh welcome
      if(!context.mounted){
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(
          ),
        ),
      );
    }else{
      if(!context.mounted){
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Onbording(),
        ),
      );
    }
  }
  Future<bool> _isOnboardingCompleted() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool("kOnboardingComplete");
      return result ?? false;
    }catch(e){
      return false;
    }
  }
  @override
  Widget build(BuildContext context){

    _checkAppState(context);
    return  Scaffold(
      backgroundColor: kColors,
      body: SafeArea(
          child: _buildBodyPage()
      ),
    );
  }

  Widget _buildBodyPage(){
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconSplash(),
          _buildTextSplash()
        ],
      ),
    );
  }

  Widget _buildIconSplash(){
    return Image.asset('images/splash.png',
      width: 95,
      height: 80,
      fit: BoxFit.contain,
      color: Colors.black,
    );
  }

  Widget _buildTextSplash(){
    return Container(
      child: const Text('Taxi App',style: TextStyle(
        fontSize: 24,
        color: kblackColor,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }
}