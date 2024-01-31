import 'package:flutter/material.dart';
import 'package:petadoptionapp/historyscreen.dart';
import 'package:petadoptionapp/pet_widget.dart';
import 'package:petadoptionapp/selectedcategory.dart';
import 'data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = getPetList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.grey[800],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdoptedPetsScreen(), // Navigate to AdoptedPetsScreen
                  ),
                );
              },
              child: Text(
                "History",
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffE0CCBE),
                    child: Stack(children: [
                      Positioned(
                          bottom: 0,
                          right: 20,
                          height: 135,
                          child: Image.asset('assets/images/cat1.png')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Fur-ever Love Awaits.\nAdopt Now.',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffC7B7A3)),
                              child: const Text(
                                'Join Us',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategory(Category.HAMSTER, "32", Colors.orange),
                      buildCategory(Category.CAT, "56", Colors.blue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCategory(Category.DOG, "64", Colors.red),
                      buildCategory(Category.BUNNY, "41", Colors.green)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Popular",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 280,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildPopularPets(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildPopularPets() {
    List<Widget> list = [];
    for (var i = 0; i < pets.length; i++) {
      if (pets[i].popular) {
        list.add(PetWidget(pet: pets[i], index: i));
      }
    }
    return list;
  }

  Widget buildCategory(Category category, String total, Color color) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedCategory(
                      category: category,
                    )));
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.5),
              ),
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    "assets/images/" +
                        (category == Category.HAMSTER
                            ? "hamster"
                            : category == Category.CAT
                                ? "cat"
                                : category == Category.BUNNY
                                    ? "bunny"
                                    : "dog") +
                        ".png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category == Category.HAMSTER
                      ? "Hamsters"
                      : category == Category.CAT
                          ? "Cats"
                          : category == Category.BUNNY
                              ? "Bunnies"
                              : "Dogs",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total of " + total,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
