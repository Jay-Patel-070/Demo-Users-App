import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/screens/weather/bloc/weather_bloc.dart';
import 'package:demo_users_app/screens/weather/bloc/weather_event.dart';
import 'package:demo_users_app/screens/weather/bloc/weather_state.dart';
import 'package:demo_users_app/screens/weather/data/weather_datarepository.dart';
import 'package:demo_users_app/screens/weather/data/weather_datasource.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_users_app/screens/auth/bloc/auth_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc =
        WeatherBloc(WeatherDatarepository(WeatherDatasource()));
    weatherBloc.add(FetchWeatherDataEvent());
  }

  @override
  void dispose() {
    weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        builder: (context, state) {
          if (state.weatherapicallstate == ApiCallState.busy) {
            return Center(child: Cm.showLoader());
          }
          if (state.weatherapicallstate == ApiCallState.failure) {
            return Center(
              child: Text(state.error ?? 'Something went wrong'),
            );
          }
          if (state.weatherapicallstate == ApiCallState.success) {
            print('inscreensuccess');
            final temps =
                state.weatherModel?.daily?.temperature2mMax;
            final dates =
                state.weatherModel?.daily?.time;

            if (temps == null || dates == null || temps.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Weather Reports',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  sb(20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: BarChart(
                      BarChartData(
                        maxY: 50,
                        barGroups: List.generate(temps.length, (index) {
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: temps[index].toDouble(),
                                width: 26,
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text('${value.toInt()}°');
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 || index >= dates.length) {
                                  return const SizedBox();
                                }

                                final date =
                                DateTime.parse(dates[index]);
                                const days = [
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat',
                                  'Sun'
                                ];

                                return Padding(
                                  padding:
                                  EdgeInsets.only(top: 8),
                                  child: Text(
                                    days[date.weekday - 1],
                                    style:
                                    TextStyle(fontSize: 12),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData:
                        FlBorderData(show: false),
                        gridData:
                        FlGridData(show: true),
                      ),
                      swapAnimationDuration:
                      const Duration(milliseconds: 600),
                      swapAnimationCurve:
                      Curves.easeOutCubic,
                    ),
                  ),
                ],
              ).withPadding(
                padding:
                EdgeInsets.symmetric(horizontal: AppPadding.md),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
