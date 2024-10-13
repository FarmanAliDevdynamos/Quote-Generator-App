// lib/screens/homepage.dart
import 'package:flutter/material.dart';
import 'package:auto_quote_generator_app/models/grid_model.dart'; // Import the GridModel
import 'package:auto_quote_generator_app/models/quote_model.dart'; // Import the QuoteModel
import 'categoriespage.dart'; // Ensure this imports the correct CategoryPage
import 'package:animate_do/animate_do.dart'; // Import for animations
import 'package:google_fonts/google_fonts.dart'; // Google Fonts

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<GridModel> _gridList = <GridModel>[
    GridModel(
      title: "Motivational Quotes",
      image: "assets/images/motivation.jpeg",
      cardId: 1,
      quotes: [
        QuoteModel(
            text: "The only way to do great work is to love what you do."),
        QuoteModel(
            text:
                "Success is not the key to happiness. Happiness is the key to success."),
        QuoteModel(
            text:
                "Your time is limited, don't waste it living someone else's life."),
        QuoteModel(text: "Dream big and dare to fail."),
        QuoteModel(
            text:
                "What lies behind us and what lies before us are tiny matters compared to what lies within us."),
      ],
    ),
    GridModel(
      title: "Love Quotes",
      image: "assets/images/love.jpg",
      cardId: 2,
      quotes: [
        QuoteModel(text: "Love all, trust a few, do wrong to none."),
        QuoteModel(text: "Where there is love there is life."),
        QuoteModel(text: "The best thing to hold onto in life is each other."),
        QuoteModel(
            text: "Love is composed of a single soul inhabiting two bodies."),
        QuoteModel(
            text: "To love and be loved is to feel the sun from both sides."),
      ],
    ),
    GridModel(
      title: "Philosophical Quotes",
      image: "assets/images/philosphy.jpg",
      cardId: 3,
      quotes: [
        QuoteModel(text: "The unexamined life is not worth living."),
        QuoteModel(text: "To be is to do."),
        QuoteModel(text: "To do is to be."),
        QuoteModel(
            text:
                "Life can only be understood backwards; but it must be lived forwards."),
        QuoteModel(text: "I think, therefore I am."),
      ],
    ),
    GridModel(
      title: "Birthday Quotes",
      image: "assets/images/birthday.jpg",
      cardId: 4,
      quotes: [
        QuoteModel(
            text:
                "Count your life by smiles, not tears. Count your age by friends, not years."),
        QuoteModel(
            text: "Birthdays are nature’s way of telling us to eat more cake."),
        QuoteModel(
            text:
                "You are never too old to set another goal or to dream a new dream."),
        QuoteModel(
            text:
                "A birthday is just the first day of another 365-day journey around the sun."),
        QuoteModel(
            text:
                "Cheers to a new year and another chance for us to get it right."),
      ],
    ),
    GridModel(
      title: "Friendship Quotes",
      image: "assets/images/friends.jpg",
      cardId: 5,
      quotes: [
        QuoteModel(
            text:
                "A true friend is someone who is there for you when they would rather be anywhere else."),
        QuoteModel(
            text:
                "Friendship is born at that moment when one person says to another, 'What! You too? I thought I was the only one.'"),
        QuoteModel(
            text:
                "Good friends are like stars. You don’t always see them, but you know they’re always there."),
        QuoteModel(
            text:
                "Friendship is the only cement that will ever hold the world together."),
        QuoteModel(
            text:
                "True friendship comes when the silence between two people is comfortable."),
      ],
    ),
    GridModel(
      title: "Life Quotes",
      image: "assets/images/life.jpg",
      cardId: 6,
      quotes: [
        QuoteModel(
            text: "Life is 10% what happens to us and 90% how we react to it."),
        QuoteModel(
            text:
                "Good friends, good books, and a sleepy conscience: this is the ideal life."),
        QuoteModel(
            text:
                "In three words I can sum up everything I've learned about life: it goes on."),
        QuoteModel(
            text:
                "The purpose of life is not to be happy. It is to be useful, honorable, and to be compassionate."),
        QuoteModel(
            text:
                "Life is really simple, but we insist on making it complicated."),
      ],
    ),
    GridModel(
      title: "Wisdom Quotes",
      image: "assets/images/wisdom.jpg",
      cardId: 7,
      quotes: [
        QuoteModel(
            text:
                "Wisdom is not a product of schooling but of the lifelong attempt to acquire it."),
        QuoteModel(
            text: "The only true wisdom is in knowing you know nothing."),
        QuoteModel(text: "Knowledge speaks, but wisdom listens."),
        QuoteModel(
            text:
                "It is the mark of an educated mind to be able to entertain a thought without accepting it."),
        QuoteModel(text: "Wisdom begins in wonder."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 81, 146),
        title: Text(
          'Auto Quote Generator',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          child: Container(
            width: 57,
            height: 57,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Quote Categories',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1, // 2 columns for bigger screens
                childAspectRatio: 0.75, // Aspect ratio to make cards look good
                children: List.generate(_gridList.length, (index) {
                  return ZoomIn(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the category page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              category: _gridList[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 6,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                                child: Image.asset(
                                  _gridList[index].image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                _gridList[index].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
