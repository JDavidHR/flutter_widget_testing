// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:uuid/uuid.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Autocomplete Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AutocompletePage(),
//     );
//   }
// }

// class AutocompletePage extends StatefulWidget {
//   const AutocompletePage({super.key});

//   @override
//   AutocompletePageState createState() => AutocompletePageState();
// }

// class AutocompletePageState extends State<AutocompletePage> {
//   final _textController = TextEditingController();
//   List<Prediction> _predictions = [];
//   final String apiKey = "AIzaSyCa3e4C6K-nj_ktXlLtXBLmU1cr6bLiGKY";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Autocomplete Demo'),
//       ),
//       body: Column(
//         children: <Widget>[
//           TextField(
//             controller: _textController,
//             decoration: const InputDecoration(
//               hintText: 'Escribe una dirección',
//             ),
//             onTap: () async {
//               // Muestra la vista de búsqueda de lugares
//               Prediction? prediction = await PlacesAutocomplete.show(
//                 context: context,
//                 apiKey: apiKey,
//                 language: 'es',
//                 mode: Mode.overlay,
//                 types: [],
//                 strictbounds: false,
//                 components: [
//                   Component(Component.country, "es"),
//                   Component(Component.country, "co"),
//                 ],
//               );

//               // Si se seleccionó una predicción, actualiza el texto del campo de texto y las predicciones
//               if (prediction != null) {
//                 setState(() {
//                   _textController.text = prediction.description ?? "";
//                   _predictions = [];
//                 });
//               }
//             },
//             onChanged: (value) async {
//               // Realiza una búsqueda de lugares cada vez que se cambia el texto del TextField
//               PlacesAutocompleteResponse response =
//                   (await _getPlacesAutocompleteResponse(value))
//                       as PlacesAutocompleteResponse;

//               // Si la respuesta es válida, actualiza las predicciones
//               if (response.isOkay) {
//                 setState(() {
//                   _predictions = response.predictions;
//                 });
//               }
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _predictions.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_predictions[index].description ?? ""),
//                   onTap: () {
//                     setState(() {
//                       _textController.text =
//                           _predictions[index].description ?? "";
//                       _predictions = [];
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Realiza una búsqueda de lugares y devuelve la respuesta
//   Future<Prediction?> _getPlacesAutocompleteResponse(String value) async {
//     return await PlacesAutocomplete.show(
//       context: context,
//       apiKey: apiKey,
//       language: 'es',
//       mode: Mode.overlay,
//       types: [],
//       strictbounds: false,
//       components: [
//         Component(Component.country, "es"),
//         Component(Component.country, "co"),
//       ],
//       sessionToken: const Uuid().v4(),
//       location: null,
//       radius: 1000,
//       hint: value,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({super.key});

  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  TextEditingController _searchController = TextEditingController();

  double _listTop = 0.0;

  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyCa3e4C6K-nj_ktXlLtXBLmU1cr6bLiGKY');
  List<Prediction> _predictions = [];

  void _onSearchTextChanged(String query) async {
    if (query.isNotEmpty) {
      PlacesAutocompleteResponse response =
          await _places.autocomplete(query, language: "es", types: []);

      setState(() {
        _predictions = response.predictions;

        // Calcula la posición superior de la lista
        _listTop = 64.0 + MediaQuery.of(context).padding.top;
      });
    } else {
      setState(() {
        _predictions = [];

        // Oculta la lista
        _listTop = MediaQuery.of(context).size.height;
      });
    }
  }

  void _onPredictionSelected(Prediction prediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId ?? "");

    // Aquí puedes realizar acciones con la dirección seleccionada, como guardarla en una variable o mostrarla en otro lugar de tu aplicación.
    String selectedAddress = detail.result.formattedAddress ?? "";

    // código postal.
    String postalCode = _getPostalCode(detail.result);

    // ciudad.
    String city = _getCity(detail.result);

    setState(() {
      _searchController.text = "$selectedAddress, $postalCode, $city";
      _predictions = [];
      _listTop = MediaQuery.of(context).size.height;
    });

    debugPrint("Dirección seleccionada: $selectedAddress");
    debugPrint("Código Postal: $postalCode");
    debugPrint("Dirección: ${detail.result.name}");
    debugPrint("Ciudad: $city");
  }

  String _getPostalCode(PlaceDetails result) {
    for (var i = 0; i < result.addressComponents.length; i++) {
      for (var j = 0; j < result.addressComponents[i].types.length; j++) {
        if (result.addressComponents[i].types[j] == "postal_code") {
          return result.addressComponents[i].longName;
        }
      }
    }
    return "";
  }

  String _getCity(PlaceDetails result) {
    for (var i = 0; i < result.addressComponents.length; i++) {
      for (var j = 0; j < result.addressComponents[i].types.length; j++) {
        if (result.addressComponents[i].types[j] == "locality") {
          return result.addressComponents[i].longName;
        }
      }
    }
    return "";
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
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - _listTop,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: _predictions.length,
                    itemBuilder: (BuildContext context, int index) {
                      Prediction prediction = _predictions[index];
                      return ListTile(
                        title: Text(prediction.description ?? ""),
                        subtitle: FutureBuilder(
                          future: _getPostalCodeFromPrediction(prediction),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!);
                            } else {
                              return Text('');
                            }
                          },
                        ),
                        onTap: () {
                          _onPredictionSelected(prediction);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }

  Future<String> _getPostalCodeFromPrediction(Prediction prediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId ?? "");
    return _getPostalCode(detail.result);
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
