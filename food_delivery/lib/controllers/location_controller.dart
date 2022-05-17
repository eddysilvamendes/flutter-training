import 'dart:convert';

import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

// private Variable Declararion
  bool _location = false;
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAdressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  int _addressTypeIndex = 0;

  //TODO: _getAddress late inicialization error
  late Map<String, dynamic> _getAddress;
  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  // Public Get variable declaration
  List<AddressModel> get addressList => _addressList;
  Map get getAddress => _getAddress;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlacemark;
  List<String> get addressTypeList => _addressTypeList;
  int get addressTypeIndex => _addressTypeIndex;
  GoogleMapController get mapController => _mapController;
  List<AddressModel> get allAddressList => _allAdressList;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
          print("Passou position");
        } else {
          print("dentro do  else");
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }
        //Where we start to talk to the server to get a string of address from google
        if (_changeAddress) {
          String _address = await getAddressfromGeoCode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
        print("Error On TryCatch");
      }
    }
  }

  Future<String> getAddressfromGeoCode(LatLng latLng) async {
    String _address = "Unknown Location Found";

    Response response = await locationRepo.getAddressfromGeoCode(latLng);

    if (response.body["status"] == "OK") {
      print("response body" + response.body.toString());
      _address = response.body["results"][0]['formatted_address'].toString();
    } else {
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //Converting string to map using JsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("Couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAdressList = [];

      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAdressList.add(AddressModel.fromJson(address));
      });
    } else {
      _allAdressList = [];
      _addressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }
}
