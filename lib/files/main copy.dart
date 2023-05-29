// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Google Places Demo',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final places =
//       GoogleMapsPlaces(apiKey: 'AIzaSyCa3e4C6K-nj_ktXlLtXBLmU1cr6bLiGKY');

//   final TextEditingController _controller = TextEditingController();
//   List<Prediction> _predictions = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_onTextChanged);
//   }

//   void _onTextChanged() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     if (_controller.text.isNotEmpty) {
//       final response = await places
//         ..searchNearbyWithRadius(
//           //_controller.text,
//           Location(
//             lat: position.latitude,
//             lng: position.longitude,
//           ), // San Francisco, CA
//           10000,
//           language: 'es',
//           type: '(cities)',
//         );

//       // setState(() {
//       //   _predictions = response.predictions;
//       // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Places Demo'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: _controller,
//             decoration: const InputDecoration(
//               hintText: 'Buscar lugar',
//               contentPadding: EdgeInsets.all(16),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _predictions.length,
//               itemBuilder: (context, index) {
//                 final prediction = _predictions[index];
//                 return ListTile(
//                   title: Text(prediction.description ?? ""),
//                   onTap: () async {
//                     final details = await places
//                         .getDetailsByPlaceId(prediction.placeId ?? "");
//                     debugPrint(details.result.name);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
