import 'package:flutter/material.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:kidflix_app/widgets/half_circle.dart';
import 'package:pinput/pinput.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 254, 255, 255),
            Color.fromARGB(255, 254, 255, 255),
            Color.fromARGB(255, 91, 162, 255),
            Color.fromARGB(255, 233, 112, 229),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.purple,
        ),
        // body: SingleChildScrollView(
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Image(
                  image: AssetImage('assets/images/logo 1.png'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Image(
                image: AssetImage('assets/images/Register.png'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            ),
            const Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                  style: TextStyle(color: Color.fromARGB(255, 12, 25, 148)),
                  'please enter the 6-didital code sent to your email for verification'),
            ),
            Pinput(
              length: 6,
              onChanged: (pin) {
                print('Pin entered: $pin');
              },
              onCompleted: (pin) {
                print('Pin completed: $pin');
              },
              defaultPinTheme: PinTheme(
                width: 48,
                height: 50,
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple),
                    color: Colors.white),
              ),
            ),
            CustomButton(
              data: "Verfiy",
              onPressed: () {},
            ),
            const Text(
                style: TextStyle(fontWeight: FontWeight.w900),
                "Didn't receive any code?"),
            const Text(
                style: TextStyle(color: Colors.black54),
                "Request new code in 00:30s"),
            Spacer(),
            Image.asset("assets/images/half_circle.png"),
          ],
        ),
        // ),
      ),
    );
  }
}
