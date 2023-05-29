import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({Key? key}) : super(key: key);

  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  TextEditingController _searchController = TextEditingController();

  double _listTop = 0.0;

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
    String? selectedAddress = detail.result.formattedAddress;

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

  String _getPostalCode(PlaceDetails? result) {
    for (var i = 0; i < result!.addressComponents.length; i++) {
      for (var j = 0; j < result.addressComponents[i].types.length; j++) {
        if (result.addressComponents[i].types[j] == "postal_code") {
          return result.addressComponents[i].longName;
        }
      }
    }
    return "";
  }

  String _getCity(PlaceDetails? result) {
    for (var i = 0; i < result!.addressComponents.length; i++) {
      for (var j = 0; j < result.addressComponents[i].types.length; j++) {
        if (result.addressComponents[i].types[j] == "locality") {
          return result.addressComponents[i].longName;
        }
      }
    }
    return "";
  }

  Future<void> _showAddressDialog() async {
    String? selectedAddress = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingrese una dirección'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchTextChanged,
                  decoration: const InputDecoration(
                    labelText: 'Dirección',
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    //shrinkWrap: true,
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
                              return const Text('');
                            }
                          },
                        ),
                        onTap: () {
                          _onPredictionSelected(prediction);
                          Navigator.of(context).pop(prediction.description);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedAddress != null) {
      setState(() {
        _searchController.text = selectedAddress;
        _predictions = [];
      });
    }
  }

  Future<String> _getPostalCodeFromPrediction(Prediction prediction) async {
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId ?? "");
    return _getPostalCode(detail.result);
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
            child: GestureDetector(
              onTap: _showAddressDialog,
              child: AbsorbPointer(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese una dirección',
                  ),
                ),
              ),
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
