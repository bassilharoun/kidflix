import 'package:flutter/material.dart';
import 'package:kidflix_app/app/styles/color.dart';

class ChooseFavoriteAnimal extends StatelessWidget {
  const ChooseFavoriteAnimal({super.key});

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
                'Choose Favorite Animal',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 4, 0, 211),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.purble),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/cats.png'),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'Cats',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 4, 0, 211),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.purble),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/falcon.png'),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'Falcon',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 4, 0, 211),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.purble),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/tiger.png'),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'Tiger',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 4, 0, 211),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.purble),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/dog.png'),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'Dog',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 4, 0, 211),
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
    );
  }
}
