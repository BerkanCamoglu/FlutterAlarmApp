import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.yellow,
              ),
              child: ListTile(
                title: Text('Alarm ${index + 1}'),
                subtitle: const Text('Kurulan Saat: 08:00'),
                trailing: const Text('Kalan Süre: 2 saat'),
              ),
            ),
          );
        },
      ),
    );
  }
}
