import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_interector.dart';
import 'package:local_ad_view/src/modules/dashboard/interector/dashboard_state.dart';

class DashboardAndroid extends StatefulWidget {
  const DashboardAndroid({super.key});

  @override
  State<DashboardAndroid> createState() => _DashboardAndroidState();
}

class _DashboardAndroidState extends State<DashboardAndroid> {
  final dashboardInterector = Modular.get<DashboardInterector>();

  @override
  void initState() {
    dashboardInterector.loadAds();

    dashboardInterector.addListener(() {
      if (dashboardInterector.value is DashboardRemoveAdSuccess) {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('Anúncio removido com successo!'),
                ),
              );
            },
            backgroundColor: Colors.grey);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ValueListenableBuilder(
        valueListenable: dashboardInterector,
        builder: (context, value, child) {
          if (value is DashboardLoadedAds) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 250),
              itemCount: value.ads.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Deseja remover esse anúncio?'),
                    actions: [
                      TextButton(
                        onPressed: () => Modular.to.pop(),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          dashboardInterector.removeAd(value.ads[index].id!);
                          Modular.to.pop();
                        },
                        child: const Text('Remover Anúncio'),
                      ),
                    ],
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Defina o raio das bordas
                  ),
                  color: Colors.white,
                  child: SizedBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            value.ads[index].path,
                            width: 192,
                            height: 192,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              value.ads[index].creator,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          'Date: ${value.ads[index].date.toDate().toString().split(' ').first.replaceAll(r'-', '/')}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Modular.to.navigate('/dashboard/onboarding'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
