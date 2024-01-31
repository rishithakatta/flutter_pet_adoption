import 'package:flutter/material.dart';
import 'package:petadoptionapp/homescreen.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int currentIndex = 0;

  PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  _onpageChanged(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 500,
                      child: Image(
                        image: AssetImage('assets/images/getstarted.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onpageChanged,
                    itemCount: _gettingstartedList.length,
                    itemBuilder: ((context, index) => GettingStartedPageCard(
                          title: _gettingstartedList[index]['title'],
                          subtitle: _gettingstartedList[index]['subtitle'],
                        )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _gettingstartedList.length; i++)
                    if (currentIndex == i)
                      const DotIndicator(isActive: true)
                    else
                      const DotIndicator(isActive: false)
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: ((context) => HomeScreen())));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffE0CCBE),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Change radius here
                          ), // Change background color here
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: isActive ? 18 : 10,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isActive ? Color(0xffE0CCBE) : Colors.grey,
      ),
    );
  }
}

class GettingStartedPageCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const GettingStartedPageCard({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            title.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              subtitle.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}

final List _gettingstartedList = [
  {
    'title': 'Discover the Joy of Pet Adoption',
    'subtitle': 'Where Every Pawprint Tells a Story of Love and Connection!',
  },
  {
    'title': 'Find Love in Every Wag',
    'subtitle':
        'Explore the World of Pet Adoption and Discover True Happiness!',
  },
  {
    'title': 'Create Forever Memories',
    'subtitle': ' Let Pet Adoption Write Your Next Chapter of Love!',
  }
];
