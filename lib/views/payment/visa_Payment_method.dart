import 'package:flutter/material.dart';
import 'package:kidflix_app/widgets/custom_button.dart';
import 'package:u_credit_card/u_credit_card.dart';

class VisaPaymentMethod extends StatelessWidget {
  const VisaPaymentMethod({super.key});

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
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: CreditCardUi(
                cardHolderFullName: 'Yahia Eltaweel',
                cardNumber: '1234567812345678',
                validThru: '10/24',
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
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
                padding: const EdgeInsets.only(top: 20),
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
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    suffixText: 'change',
                    suffixStyle:
                        const TextStyle(color: Colors.red, fontSize: 18),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Add a new card',
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
              data: 'Pay',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
