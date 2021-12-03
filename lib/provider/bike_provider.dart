import 'package:flutter/cupertino.dart';
import 'package:unibike/api/api_service.dart';
import 'package:unibike/model/bike_model.dart';

enum ResultState { Loading, NoData, HasData, Error }

class BikeProvider extends ChangeNotifier {
  final ApiService apiService;

  BikeProvider({required this.apiService}) {
    _fetchAllBikes();
  }

  BikeProvider getBikes() {
    _fetchAllBikes();
    return this;
  }

  late BikeResult _bikeResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  BikeResult get result => _bikeResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllBikes() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final bike = await apiService.listBikes();
      if (bike.bikes.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        _bikeResult = bike;
        notifyListeners();
        return _bikeResult = bike;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
