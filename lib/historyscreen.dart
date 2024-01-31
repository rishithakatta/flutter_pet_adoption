import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class AdoptedPetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopted Pets'),
      ),
      body: Consumer<AdoptedPetsProvider>(
        builder: (context, adoptedPetsProvider, child) {
          return 
          adoptedPetsProvider.adoptedPets.isEmpty
          ? const Center(
              child: Text('You haven\'t adopted any pets yet.'),
            )
          :
          ListView.builder(
            itemCount: adoptedPetsProvider.adoptedPets.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(adoptedPetsProvider.adoptedPets[index].name),
                subtitle: Text(adoptedPetsProvider.adoptedPets[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(adoptedPetsProvider.adoptedPets[index].imageUrl),
                ),
              );
            },
          );
        },
      ),
    );
  }
}