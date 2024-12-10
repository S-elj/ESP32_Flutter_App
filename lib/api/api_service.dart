import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
// URL de l'API de ton ESP32
final String baseUrl = 'http://adresse_de_ton_esp32/api_route';

// Fonction pour récupérer des données depuis l'API
Future<Map<String, dynamic>> fetchData() async {
  try {
    // Envoie de la requête GET
    final response = await http.get(Uri.parse(baseUrl));

    // Vérifie si la requête a réussi
    if (response.statusCode == 200) {
      // Décoder la réponse JSON
      return jsonDecode(response.body);
    } else {
      throw Exception('Échec de la récupération des données');
    }
  } catch (e) {
    throw Exception('Erreur: $e');
  }
}
}