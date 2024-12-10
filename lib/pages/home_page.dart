import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/api_service.dart';

class MyHomePage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API Example')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            // Affiche les données récupérées
            var data = snapshot.data;
            return Center(child: Text('Données: ${data.toString()}'));
          }
        },
      ),
    );
  }
}