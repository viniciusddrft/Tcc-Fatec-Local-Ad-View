import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/dashboard_interactor.dart';
import 'package:local_ad_view/src/modules/dashboard/interactor/dashboard_state.dart';

class DashboardWeb extends StatefulWidget {
  const DashboardWeb({super.key});

  @override
  State<DashboardWeb> createState() => _DashboardWebState();
}

class _DashboardWebState extends State<DashboardWeb> {
  final dashboardinteractor = Modular.get<DashboardInteractor>();

  @override
  void initState() {
    dashboardinteractor.loadAds();

    dashboardinteractor.addListener(() {
      if (dashboardinteractor.value is DashboardRemoveAdSuccess) {
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
        dashboardinteractor.loadAds();
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
        valueListenable: dashboardinteractor,
        builder: (context, value, child) {
          if (value is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value is DashboardFailed) {
            return Center(child: Text(value.message));
          } else if (value is DashboardLoadedAds) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 250),
              itemCount: value.ads.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () => showDialog(
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
                          dashboardinteractor.removeAd(value.ads[index]);
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
                        if (!value.ads[index].hasImageSecondary!)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              value.ads[index].path,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          )
                        else
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  value.ads[index].path,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  value.ads[index].imageSecondary!,
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        const Spacer(),
                        SizedBox(
                          width: 200,
                          child: Text(
                            value.ads[index].creator,
                            overflow: TextOverflow.ellipsis,
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
