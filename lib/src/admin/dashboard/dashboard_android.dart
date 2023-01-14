import 'package:flutter/material.dart';

class DashboardAndroid extends StatefulWidget {
  const DashboardAndroid({super.key});

  @override
  State<DashboardAndroid> createState() => _DashboardAndroidState();
}

class _DashboardAndroidState extends State<DashboardAndroid> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fatec Avisos dashboard'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05, bottom: size.height * 0.05),
                  child: TextFormField(
                    maxLines: 5,
                    minLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Texto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.37,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text('Adicionar Imagens'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.37,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text('Adicionar Videos'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: SizedBox(
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Center(
                        child: Text('Publicar'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
