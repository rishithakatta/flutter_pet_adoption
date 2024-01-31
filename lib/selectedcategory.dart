import 'package:flutter/material.dart';
import 'package:petadoptionapp/pet_widget.dart';
import 'data.dart';

class SelectedCategory extends StatefulWidget {
  final Category category;
  const SelectedCategory({super.key, required this.category});

  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  late TextEditingController _searchController;
  late List<Pet> _filteredPets;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredPets = getPetList().where((pet) => pet.category == widget.category).toList();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPets = getPetList()
          .where((pet) =>
              pet.category == widget.category &&
              (pet.name.toLowerCase().contains(query) ||
                  pet.location.toLowerCase().contains(query)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.category == Category.HAMSTER
            ? "Hamsters"
            : widget.category == Category.BUNNY
                ? "Bunnies"
                : widget.category == Category.CAT
                    ? "Cats"
                    : "Dogs"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
              child: TextField(
                 controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.only(right: 30),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 24),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 24,
                      ),
                    )),
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                childAspectRatio: 1 / 1.55,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                children: _filteredPets.map((pet) {
                  return PetWidget(
                    pet: pet,
                    index:null,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
