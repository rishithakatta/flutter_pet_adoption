import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:petadoptionapp/data.dart';
import 'package:petadoptionapp/historyscreen.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class PetDetails extends StatefulWidget {
  final Pet pet;

  const PetDetails({super.key, required this.pet});

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails>
    with SingleTickerProviderStateMixin {
  late bool isAdopted = false;
  late TransformationController controller;
  TapDownDetails? tapDownDetails;
   late ConfettiController _confettiController;

  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    isAdopted = widget.pet.isAdopted;
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 300))
          ..addListener(() {
            controller.value = animation!.value;
          });
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    animationController.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTapDown: (details) => tapDownDetails = details,
              onDoubleTap: () {
                final position = tapDownDetails!.localPosition;
                final double scale = 3;
                final x = -position.dx * (scale - 1);
                final y = position.dy * (scale - 1);
                final zoomed = Matrix4.identity()
                  ..translate(x)
                  ..scale(scale);
                final end = 
                    controller.value.isIdentity() ? zoomed : Matrix4.identity();

                animation = Matrix4Tween(begin: controller.value, end: end)
                    .animate(CurveTween(curve: Curves.easeOut)
                        .animate(animationController));

                        animationController.forward(from: 0);
                // final value =
                //     controller.value.isIdentity() ? zoomed : Matrix4.identity();
                // controller.value = value;
              },
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                transformationController: controller,
                panEnabled: false,
                scaleEnabled: false,
                child: Stack(
                  children: [
                    Hero(
                      tag: widget.pet.imageUrl,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.pet.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pet.name,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                widget.pet.location,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "(" + widget.pet.distance + "km)",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.pet.favorite
                              ? Colors.red[400]
                              : Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 24,
                          color: widget.pet.favorite
                              ? Colors.white
                              : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      buildPetFeature(widget.pet.age, "Age"),
                      buildPetFeature(widget.pet.color, "Color"),
                      buildPetFeature(widget.pet.weight, "Weight"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Pet Story",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.pet.Story,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, top: 16, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isAdopted) {
                            // Adopt the pet and update the UI
                            Provider.of<AdoptedPetsProvider>(context,
                                    listen: false)
                                .adoptPet(widget.pet);
                            setState(() {
                              isAdopted = true;
                            });
                          
                          Provider.of<AdoptedPetsProvider>(context,
                                  listen: false)
                              .adoptPet(widget.pet);

                          Provider.of<AdoptedPetsProvider>(context, listen: false)
                              .adoptPet(widget.pet);
                           _showAdoptedDialog(context, widget.pet.name);
                    _confettiController.play();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffE0CCBE).withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: isAdopted?Colors.grey:Colors.red[400] ,
                          ),
                          child: Text(
                            isAdopted ? "Adopted" : "Adopt Me",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   void _showAdoptedDialog(BuildContext context, String petName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You have now adopted $petName!'),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  buildPetFeature(String value, String feature) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

