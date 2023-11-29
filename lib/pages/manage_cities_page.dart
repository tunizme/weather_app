import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/pages/home_page.dart';

const Duration fakeAPIDuration = Duration(seconds: 1);
const Duration debounceDuration = Duration(milliseconds: 500);

class ManageCitiesPage extends StatefulWidget {
  const ManageCitiesPage({super.key});
  @override
  State<ManageCitiesPage> createState() => _ManageCitiesPage();
}

class _ManageCitiesPage extends State<ManageCitiesPage> {
  List<City> cities = [];
  @override
  void initState() {
    super.initState();
    cities = City.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 20.0),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Manage Cities')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _AsyncSearchAnchor(),
            const SizedBox(height: 20),
            SizedBox(
                height: 360,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: cities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors
                              .lightBlue[100], // Light blue background color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cities[index].cityData.name,
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            const Icon(Icons.location_on),
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

class _AsyncSearchAnchor extends StatefulWidget {
  const _AsyncSearchAnchor();

  @override
  State<_AsyncSearchAnchor> createState() => _AsyncSearchAnchorState();
}

class _AsyncSearchAnchorState extends State<_AsyncSearchAnchor> {
  // The query currently being searched for. If null, there is no pending
  // request.

  var _cityData = {};
  String searchLocationUrl = 'https://api.api-ninjas.com/v1/city?name=';
  String apiKey = '&X-Api-Key=pvSax68ltIWGgb0jk/U8KQ==3uvUS3LCofTLulG2';
  Future<Iterable<String>> getLocation(String query) async {
    List<String> options = <String>[];
    if (query == '') {
      return const Iterable<String>.empty();
    }
    var searchResult =
        await http.get(Uri.parse(searchLocationUrl + query + apiKey));
    if (searchResult.statusCode == 200) {
      var result = json.decode(searchResult.body);
      if (result.length == 0) return const Iterable<String>.empty();
      var resultData = result[0];
      setState(() {
        if (mounted) {
          _cityData = resultData;
          options.add(_cityData['name'].toString());
        }
      });
      return options;
    } else {
      return const Iterable<String>.empty();
    }
  }

  String? _currentQuery;

  // The most recent suggestions received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  // Calls the "remote" API to search with the given query. Returns null when
  // the call has been made obsolete.

  Future<Iterable<String>?> _search(String query) async {
    _currentQuery = query;

    // In a real application, there should be some error handling here.
    final Iterable<String> options = await getLocation(_currentQuery!);

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: SearchController(),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          onTap: () {
            controller.openView();
          },
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          hintText: 'Enter location',
        );
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
        final List<String>? options =
            (await _debouncedSearch(controller.text))?.toList();
        if (options == null) {
          return _lastOptions;
        }
        _lastOptions = List<ListTile>.generate(options.length, (int index) {
          final String item = options[index];
          return ListTile(
            titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
            title: Text(item),
            onTap: () {
              setState(() {
                City.addCity(CityData(
                    name: _cityData['name'],
                    lat: _cityData['latitude'],
                    lon: _cityData['longitude']));
                cities = City.getCities();
                controller.closeView(item);
                Navigator.pop(context);
              });
            },
          );
        });

        return _lastOptions;
      },
    );
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}

// class LocationWidget extends StatefulWidget {
//   const LocationWidget({super.key});
//   @override
//   State<LocationWidget> createState() => _LocationWidget();
// }

// class _LocationWidget extends State<LocationWidget> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
