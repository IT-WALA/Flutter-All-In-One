import 'package:flutter/material.dart';
import 'package:flutter_all_in_one/modules/common_widgets/common_widgets.dart';
import 'package:flutter_all_in_one/modules/hero/hero_second_screen.dart';

class HeroFirstScreen extends StatefulWidget {
  const HeroFirstScreen({Key? key}) : super(key: key);

  @override
  State<HeroFirstScreen> createState() => _HeroFirstScreenState();
}

class _HeroFirstScreenState extends State<HeroFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Hero First Screen"),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: "hero_image",
                child: Image.asset(
                  'assets/images/it_wala.jpg',
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HeroSecondScreen()));
                },
                child: const Text("Go to second page."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
