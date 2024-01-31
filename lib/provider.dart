import 'package:flutter/material.dart';
import 'data.dart';

class AdoptedPetsProvider extends ChangeNotifier {
  List<Pet> _adoptedPets = [];

  List<Pet> get adoptedPets => _adoptedPets;

 void adoptPet(Pet pet) {
    pet.isAdopted = true; // Set the adoption status of the pet
    if (!_adoptedPets.contains(pet)) {
      _adoptedPets.add(pet);
      notifyListeners();
    }
  }
}