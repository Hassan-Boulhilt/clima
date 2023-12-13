import '../services/location.dart';
import '../services/networking.dart';

class WeatherModel {
  Future<dynamic> getWeatherCity(String city) async {
    const keyApi = 'b734e8d92be34b36870134712231112';
    final Map<String, String> queryParametrs = <String, String>{
      'key': keyApi,
      'q': city,
      'aqi': 'no'
    };
    final url =
        Uri.https('api.weatherapi.com', '/v1/current.json', queryParametrs);
    NetworkingHelper networkHelper = NetworkingHelper(uri: url);

    /// The line `final networkData = await networkHelper.getData();` is making an asynchronous HTTP request
    /// to the specified URL using the `networkHelper` instance. The `getData()` method of the
    /// `NetworkingHelper` class is responsible for sending the HTTP request and returning the response
    /// data.
    final weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    /// `Location location = Location();` is creating an instance of the `Location` class and assigning
    /// it to the variable `location`. This allows you to access the methods and properties of the
    /// `Location` class.
    Location location = Location();
    const keyApi = 'b734e8d92be34b36870134712231112';

    /// `await location.getCurrentLocation();` is awaiting the completion of the `getCurrentLocation()`
    /// method call. This method is responsible for retrieving the current location of the device. By
    /// using the `await` keyword, the code will pause execution at this line until the
    /// `getCurrentLocation()` method completes and returns a value.
    await location.getCurrentLocation();
    final Map<String, String> queryParametrs = <String, String>{
      'key': keyApi,
      'q': '${location.latitude}, ${location.longtitude}',
      'aqi': 'no'
    };

    final url =
        Uri.https('api.weatherapi.com', '/v1/current.json', queryParametrs);

    /// The line `NetworkingHelper networkHelper = NetworkingHelper(url: url);` is creating an instance
    /// of the `NetworkingHelper` class and assigning it to the variable `networkHelper`. The
    /// `NetworkingHelper` class is responsible for making HTTP requests to the specified URL. By
    /// passing the `url` as a parameter when creating the `NetworkingHelper` instance, it sets the URL
    /// that will be used for the HTTP request.
    NetworkingHelper networkHelper = NetworkingHelper(uri: url);

    /// The line `final networkData = await networkHelper.getData();` is making an asynchronous HTTP request
    /// to the specified URL using the `networkHelper` instance. The `getData()` method of the
    /// `NetworkingHelper` class is responsible for sending the HTTP request and returning the response
    /// data.
    final weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
