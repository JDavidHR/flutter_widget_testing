import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({Key? key}) : super(key: key);

  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  TextEditingController _searchController = TextEditingController();

  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyCa3e4C6K-nj_ktXlLtXBLmU1cr6bLiGKY');
  List<Prediction> _predictions = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String query) async {
    if (query.isNotEmpty) {
      PlacesAutocompleteResponse response =
          await _places.autocomplete(query, language: "es", types: []);

      setState(() {
        _predictions = response.predictions;
      });
    } else {
      setState(() {
        _predictions = [];
      });
    }
  }

  void _onPredictionSelected(Prediction prediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId ?? "");

    String selectedAddress = detail.result.formattedAddress ?? "";
    String postalCode = _getPostalCode(detail.result);
    String city = _getCity(detail.result);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dirección seleccionada'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selectedAddress),
              Text('Código Postal: $postalCode'),
              Text('Ciudad: $city'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );

    setState(() {
      _searchController.text = selectedAddress;
      _predictions = [];
    });

    // Cerrar el teclado
    FocusScope.of(context).unfocus();
  }

  String _getPostalCode(PlaceDetails result) {
    for (AddressComponent component in result.addressComponents) {
      for (String type in component.types) {
        if (type == 'postal_code') {
          return component.longName ?? '';
        }
      }
    }
    return '';
  }

  String _getCity(PlaceDetails result) {
    for (AddressComponent component in result.addressComponents) {
      for (String type in component.types) {
        if (type == 'locality') {
          return component.longName ?? '';
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda de Dirección'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchTextChanged,
              decoration: const InputDecoration(
                labelText: 'Ingrese una dirección',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _predictions.length,
              itemBuilder: (BuildContext context, int index) {
                Prediction prediction = _predictions[index];
                return ListTile(
                  title: Text(prediction.description ?? ""),
                  onTap: () {
                    _onPredictionSelected(prediction);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddressSearchScreen(),
    );
  }
}
