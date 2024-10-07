import 'package:flutter/material.dart';
import 'package:kidflix_app/widgets/custom_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

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
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Image(
                  image: AssetImage('assets/images/logo 1.png'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 4, 0, 211),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  decoration: InputDecoration(
                    suffixText: 'change',
                    suffixStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Visa************250',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 22),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your visa card number',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  decoration: InputDecoration(
                    suffixText: 'change',
                    suffixStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Credit / Debit / ATM Card',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 22),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your visa card number',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(
              data: 'Add Payment Method',
              onPressed: () {},
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: TextField(
                  decoration: InputDecoration(
                    suffixText: 'change',
                    suffixStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Cash on Payment',
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 22),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your visa card number',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Container(
                    width: 120,
                    height: 100,
                    child: const Image(
                      image: AssetImage('assets/images/paypal.png'),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  height: 30,
                  child: const Image(
                    image: AssetImage('assets/images/google pay.png'),
                  ),
                ),
                Container(
                  width: 80,
                  height: 30,
                  child: const Image(
                    image: AssetImage('assets/images/apple pay.png'),
                  ),
                ),
              ],
            ),
            CustomButton(
              data: 'Pay',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
