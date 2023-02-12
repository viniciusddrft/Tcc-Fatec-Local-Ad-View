import 'package:flutter/material.dart';

class DashboardAndroid extends StatefulWidget {
  const DashboardAndroid({super.key});

  @override
  State<DashboardAndroid> createState() => _DashboardAndroidState();
}

class _DashboardAndroidState extends State<DashboardAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Adicionar publicação',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
