import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class CitySearchModal extends StatefulWidget {
  final Function(String) onCitySearched; // Add the callback here

  CitySearchModal({required this.onCitySearched});

  @override
  _CitySearchModalState createState() => _CitySearchModalState();
}

class _CitySearchModalState extends State<CitySearchModal> {
  final TextEditingController _cityController = TextEditingController();
  rive.SMIInput<bool>? isSearching;
  rive.SMIInput<bool>? isChecking;
  rive.SMIInput<bool>? trigFail;
  rive.SMIInput<bool>? trigSuccess;
  late rive.StateMachineController? stateMachineController;
  String errorMessage = '';

  // Method to trigger searching animation in Rive
  void isCheckField() {
    if (isSearching != null) {
      isSearching?.change(true);
    }
  }

  // Method to reset searching animation
  void resetSearchAnimation() {
    if (isSearching != null) {
      isSearching?.change(false);
    }
  }

  // Triggering Rive animation based on text input changes
  void onTextChanged(String value) {
    if (value.isEmpty) {
      if (isChecking != null) isChecking?.change(true); // Checking input
      if (trigFail != null) trigFail?.change(true); // Fail state for empty input
      if (trigSuccess != null) trigSuccess?.change(false); // No success
    } else {
      if (isChecking != null) isChecking?.change(false); // Stop checking
      if (trigFail != null) trigFail?.change(false); // Reset fail state
      if (trigSuccess != null) trigSuccess?.change(true); // Success when typing
    }

    // Validate the city name as user types
    setState(() {
      errorMessage = isValidCity(value) ? '' : 'Invalid city name';
    });
  }

  // Simple city name validation (you can replace this with a real API check)
  bool isValidCity(String cityName) {
    // Basic check: city name should be at least 3 characters long
    return cityName.length > 2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3, // Adjust height to 30% of screen height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: rive.RiveAnimation.asset(
                          "assets/character.riv", // Replace with your own Rive animation
                          stateMachines: const ["Login Machine"], // State machine name from Rive
                          onInit: (artBoard) {
                            stateMachineController = rive.StateMachineController.fromArtboard(
                                artBoard, "Login Machine");
                            if (stateMachineController == null) return;
                            artBoard.addController(stateMachineController!);
                            isSearching = stateMachineController?.findInput("isSearching");
                            isChecking = stateMachineController?.findInput("isChecking");
                            trigFail = stateMachineController?.findInput("trigFail");
                            trigSuccess = stateMachineController?.findInput("trigSuccess");
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _cityController,
                              onChanged: onTextChanged, // Call this method when typing
                              decoration: InputDecoration(
                                hintText: 'Enter City Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Show error message immediately as user types
                            if (errorMessage.isNotEmpty)
                              Text(
                                errorMessage,
                                style: TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final cityName = _cityController.text.trim();
                                if (cityName.isEmpty) {
                                  setState(() {
                                    errorMessage = 'Please enter a city name';
                                  });
                                } else if (!isValidCity(cityName)) {
                                  setState(() {
                                    errorMessage = 'Invalid city name';
                                  });
                                } else {
                                  print('Searching for: $cityName');
                                  widget.onCitySearched(cityName); // Pass the city name to callback
                                  resetSearchAnimation();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Search'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
