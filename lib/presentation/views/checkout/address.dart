import 'dart:async';

import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/presentation/views/checkout/checkout_page.dart';
import 'package:ecom_mvvm/services/database/database_operation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late GoogleMapController _controller;
  LatLng? markerPos;
  LatLng? initPos;
  Set<Marker> markers = {};
  TextEditingController searchPlaceController = TextEditingController();
  bool loadingMap = false;
  bool init = true;
  bool loadingAddressDetails = false;
  String addressTitle = '';
  String locality = '';
  String city = '';
  String state = '';
  String pincode = '';
  String country = '';

  StreamController<LatLng> streamController = StreamController();
  final DatabaseService _databaseService = DatabaseService();

  void fetchAddressDetail(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      setState(() {
        addressTitle = placemarks[0].name ?? '';
        locality = placemarks[0].locality ?? '';
        city = placemarks[0].subLocality ?? '';
        pincode = placemarks[0].postalCode ?? '';
        state = placemarks[0].administrativeArea ?? '';
        country = placemarks[0].country ?? '';
      });
    }
  }

  Future<void> getCurrentLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are not enabled, prompt the user to enable them.
      bool? openSettings = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Services Disabled'),
            content: const Text(
                'Location services are disabled. Please enable them in your device settings.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  context.pop();
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      if (openSettings == true) {
        await Geolocator.openLocationSettings();
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        initPos = LatLng(position.latitude, position.longitude);
        loadingMap = false;
      });
      streamController.add(initPos!);
    } catch (e) {
      return Future.error('Failed to get current location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadingMap = true;
    getCurrentLoc();
  }

  @override
  void dispose() {
    _controller.dispose();
    streamController.close();
    searchPlaceController.dispose();
    super.dispose();
  }

  Widget renderMap() {
    // late GoogleMapController controller;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: loadingMap
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              buildingsEnabled: true,
              indoorViewEnabled: true,
              markers: markers.toSet(),
              zoomGesturesEnabled: true,
              onMapCreated: (controller) {
                _controller = controller;
                fetchAddressDetail(initPos!);
              },
              onCameraMove: (CameraPosition pos) {
                streamController.add(pos.target);
              },
              initialCameraPosition: CameraPosition(
                target: initPos!,
                zoom: 15.0,
              ),
              mapType: MapType.satellite,
            ),
    );
  }

  Widget backButton() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.black87,
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget searchBox() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black87, width: 0.1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: TextFormField(
          controller: searchPlaceController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(8),
            border: InputBorder.none,
            hintText: "Search Places...",
            labelStyle: TextStyle(color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget addressDetailsCard() {
    return Card(
      color: secondaryColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "$addressTitle, $city",
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "$locality, $state",
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          text: "$pincode, $country",
                          color: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // side: const BorderSide(color: primaryColor),
                ),
              ),
              onPressed: () async {
                final existingAddresses = await _databaseService.getAddresses();

                if (existingAddresses.isNotEmpty) {
                  // Address already exists, update it
                  await _databaseService.updateAddress({
                    'id': existingAddresses.first['id'],
                    'addressTitle': addressTitle,
                    'locality': locality,
                    'city': city,
                    'state': state,
                    'pincode': pincode,
                    'country': country,
                  });
                } else {
                  // Address does not exist, insert it
                  await _databaseService.insertAddress({
                    'addressTitle': addressTitle,
                    'locality': locality,
                    'city': city,
                    'state': state,
                    'pincode': pincode,
                    'country': country,
                  });
                }

                Helper.toast('Address Saved');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()),
                );
              },
              child: const AppText(
                text: 'Save Address',
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        leading: backButton(),
        title: const AppText(
          text: "Select Address",
          color: primaryColor,
          size: 24,
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              renderMap(),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  'assets/pin.png',
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Address Details",
                    size: 20,
                    color: primaryColor,
                  ),
                  addressDetailsCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
