import 'package:covid_app/Model/world_states_model.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/countirs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WORLDSTATS extends StatefulWidget {
  const WORLDSTATS({Key? key}) : super(key: key);

  @override
  State<WORLDSTATS> createState() => _WORLDSTATSState();
}

class _WORLDSTATSState extends State<WORLDSTATS> with TickerProviderStateMixin {
  late final AnimationController _controller =AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context ,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.red,
                          size:50.0,
                          controller: _controller,



                        ));

                  }
                  else{
                    return Column(
                      children: [
                        PieChart(dataMap: {
                          "Total":double.parse(snapshot.data!.cases!.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                          "Death":double.parse(snapshot.data!.deaths!.toString()),
                        },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                          chartRadius: 170,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left
                          ),

                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReuseableRow(title: 'Death', value:snapshot.data!.deaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder:(context) => CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(

                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),

                            ),
                            child: Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                }),




          ],

        ),
      ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title,  value;
  ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10 , bottom: 5 , top: 10),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(title),
                Text(value),
              ]
          ),
          SizedBox(height: 20,),
          Divider()
        ],
      ),
    );
  }
}
