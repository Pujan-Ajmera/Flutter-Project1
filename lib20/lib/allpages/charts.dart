import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Charts',style: TextStyle(color: Colors.white),),backgroundColor: const Color.fromRGBO(13, 24, 33, 1),),
      backgroundColor: const Color.fromRGBO(13, 24, 33, 1),
      body: FutureBuilder(
          future: getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Has some errors! check it out',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Has no data!',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final users = snapshot.data!;
              int maleCount = users.where((user) => user['gender'] == 'Male').length;
              int femaleCount = users.where((user) => user['gender'] == 'Female').length;
              Map<String, double> dataMap = {
                "Male": maleCount.toDouble(),
                "Female": femaleCount.toDouble(),
              };
              int favouriteCount = users.where((user) => user['isFav'] == 1).length;
              int notFavouriteCount = users.where((user) => user['isFav'] == 0).length;
              Map<String, double> dataMap2 = {
                "isFav": favouriteCount.toDouble(),
                "isNotFav": notFavouriteCount.toDouble(),
              };
              return ListView(
                children: [
                  Card(
                    color: const Color.fromRGBO(31, 41, 55, 1),
                    margin: const EdgeInsets.all(16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Gender Distribution',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          PieChart(
                            dataMap: dataMap,
                            animationDuration: const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            colorList: const [Colors.blue, Colors.pink],
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: 'Gender',
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildLegendItem(Colors.blue, 'Male: $maleCount'),
                              _buildLegendItem(Colors.pink, 'Female: $femaleCount'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    color: const Color.fromRGBO(31, 41, 55, 1),
                    margin: const EdgeInsets.all(16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Favourite Distribution',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          PieChart(
                            dataMap: dataMap2,
                            animationDuration: const Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            colorList: const [Colors.blue, Colors.pink],
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: 'Favourites',
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              legendShape: BoxShape.circle,
                              legendTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildLegendItem(Colors.blue, 'IsFav: $favouriteCount'),
                              _buildLegendItem(Colors.pink, 'NotFavourite: $notFavouriteCount'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildAgeDistributionChart(context ,users),
                ],
              );
            }
          }),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final url = Uri.parse("https://66f274a771c84d80587551d2.mockapi.io/users");
    final response = await http.get(url);
    List<Map<String, dynamic>> data =
    List<Map<String, dynamic>>.from(jsonDecode(response.body));
    return data;
  }

  Widget _buildFavoritesPieChart(BuildContext context, List<Map<String, dynamic>> allUsers, List<Map<String, dynamic>> favoriteUsers) {
    int favoriteCount = favoriteUsers.length;
    int notFavoriteCount = allUsers.length - favoriteCount;

    Map<String, double> dataMap = {
      "Favorites": favoriteCount.toDouble(),
      "Other": notFavoriteCount.toDouble(),
    };

    return Card(
      color: const Color.fromRGBO(31, 41, 55, 1),
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Favorites Distribution',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: const [Colors.redAccent, Colors.grey],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: 'Favorites',
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(Colors.redAccent, 'Favorites: $favoriteCount'),
                _buildLegendItem(Colors.grey, 'Other: $notFavoriteCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildAgeDistributionChart(BuildContext context, List<Map<String, dynamic>> users) {
    // Group users by age range (e.g., 18-25, 26-35, etc.)
    Map<String, int> ageRangesMap = {};
    for (var user in users) {
      int age = user['age'] ?? 0; // Provide a default age if null
      String ageRange;
      if (age >= 18 && age <= 25) {
        ageRange = '18-25';
      } else if (age >= 26 && age <= 35) {
        ageRange = '26-35';
      } else if (age >= 36 && age <= 45) {
        ageRange = '36-45';
      } else {
        ageRange = '46+';
      }
      ageRangesMap[ageRange] = (ageRangesMap[ageRange] ?? 0) + 1;
    }

    // Convert age ranges map to dataMap for PieChart
    Map<String, double> dataMap = ageRangesMap.map((range, count) => MapEntry(range, count.toDouble()));

    return Card(
      color: const Color.fromRGBO(31, 41, 55, 1),
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Age Distribution',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: const [ // Customize colors
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.red,
              ],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: 'Age',
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
            const SizedBox(height: 16),
            Wrap( // Use Wrap widget
              alignment: WrapAlignment.spaceEvenly,
              children: [
                _buildLegendItem(Colors.blue, '18-25: ${ageRangesMap['18-25'] ?? 0} '),
                _buildLegendItem(Colors.green, '26-35: ${ageRangesMap['26-35'] ?? 0} '),
                _buildLegendItem(Colors.yellow, '36-45: ${ageRangesMap['36-45'] ?? 0} '),
                _buildLegendItem(Colors.red, '46+: ${ageRangesMap['46+'] ?? 0} '),
              ],
            ),
          ],
        ),
      ),
    );
  }
}