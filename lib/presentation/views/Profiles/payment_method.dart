import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/data/models/card_model.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:ecom_mvvm/services/cards/cards.dart';
import 'package:flutter/material.dart';

class ShowCardScreen extends StatefulWidget {
  const ShowCardScreen({super.key});

  @override
  _ShowCardScreenState createState() => _ShowCardScreenState();
}

class _ShowCardScreenState extends State<ShowCardScreen> {
  late Future<List<CardModel>> cards;
  int? selectedCardId;

  @override
  void initState() {
    super.initState();
    cards = CardService().loadCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const AppText(
            text: "Saved Card",
            size: 20,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              ))),
      body: FutureBuilder<List<CardModel>>(
        future: cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cards available'));
          } else {
            final cards = snapshot.data!;
            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCardId = card.id;
                    });
                  },
                  child: Card(
                    color:
                        selectedCardId == card.id ? primaryColor : Colors.white,
                    child: ListTile(
                      leading: Image.asset(card.logoUrl),
                      title: AppText(
                        text: card.cardNumber,
                        size: 16,
                        color: selectedCardId == card.id
                            ? Colors.white
                            : primaryColor,
                      ),
                      subtitle: AppText(
                        text: '${card.cardHolder}\nExpiry: ${card.expiryDate}',
                        size: 14,
                        color: selectedCardId == card.id
                            ? Colors.white
                            : primaryColor,
                      ),
                      trailing: selectedCardId == card.id
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
