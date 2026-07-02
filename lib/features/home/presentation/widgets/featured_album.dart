import 'package:flutter/material.dart';

class FeaturedAlbum extends StatelessWidget {
  const FeaturedAlbum({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: "featured_album",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.network(
                "https://picsum.photos/700",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "Blinding Lights",
          style: Theme.of(context)
              .textTheme
              .headlineMedium,
        ),

        const SizedBox(height: 6),

        Text(
          "The Weeknd",
          style: Theme.of(context)
              .textTheme
              .bodyMedium,
        ),

        const SizedBox(height: 24),

        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text("Play Now"),
        ),

      ],
    );
  }
}