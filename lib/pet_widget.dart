import 'package:flutter/material.dart';
import 'package:petadoptionapp/petdetils.dart';
import 'data.dart';

class PetWidget extends StatelessWidget {
  final Pet pet;
  final int? index;
  const PetWidget({super.key, required this.pet, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PetDetails(pet: pet)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            )),
        width: 220,
        margin: EdgeInsets.only(
            right: index != null ? 16 : 0, left: index == 0 ? 16 : 0, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Stack(
              children: [
                Hero(
                    tag: pet.imageUrl,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(pet.imageUrl), fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pet.favorite ? Colors.red[400] : Colors.white),
                        child: Icon(Icons.favorite,
                            size: 16,
                            color:
                                pet.favorite ? Colors.white : Colors.grey[300])),
                  ),
                )
              ],
            )),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: pet.condition == "Adoption"
                            ? Colors.orange[100]
                            : pet.condition == "Lost"
                                ? Colors.red[100]
                                : Colors.blue[100],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      pet.condition,
                      style: TextStyle(
                          color: pet.condition == "Adoption"
                              ? Colors.orange
                              : pet.condition == "Lost"
                                  ? Colors.red
                                  : Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    pet.name,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        pet.location,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4),
                      Text(
                       "("+ pet.distance+")",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
