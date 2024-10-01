import 'package:catalog/model/movie.dart';
import 'package:flutter/material.dart';

class InfoMovie extends StatelessWidget {
  final Movie movie;
  const InfoMovie(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(movie.name),
      ),
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.all(16),
            child: ShowInfo(
              movie: movie,
            )),
      ),
    );
  }
}

class ShowInfo extends StatelessWidget {
  Movie movie;
  ShowInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextStyle(
          title: "Name: ",
          subtitle: movie.name,
        ),
        const SizedBox(
          height: 12,
        ),
        RichTextStyle(
          title: "Year: ",
          subtitle: movie.year,
        ),
        const SizedBox(
          height: 12,
        ),
        RowRating(text: movie.rating),
        const SizedBox(
          height: 12,
        ),
        RichTextStyle(
          title: "Description: ",
          subtitle: movie.description,
        ),
        const SizedBox(
          height: 12,
        ),
        RichTextStyle(
          title: "Cast: ",
          subtitle: movie.cast,
        ),
        const SizedBox(
          height: 12,
        ),
        RichTextStyle(
          title: "Duration: ",
          subtitle: movie.duration,
        ),
        const SizedBox(
          height: 12,
        ),
        RichTextStyle(
          title: "Genre: ",
          subtitle: movie.genre,
        ),
      ],
    );
  }
}

class RichTextStyle extends StatelessWidget {
  final String title;
  final String subtitle;
  const RichTextStyle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      selectionColor: const Color.fromARGB(255, 10, 9, 5),
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextSpan(
            text: subtitle,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class RowRating extends StatelessWidget {
  final String text;
  const RowRating({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichTextStyle(
          title: "Rating: ",
          subtitle: text,
        ),
        const Icon(
          Icons.star,
          color: Colors.yellow,
        )
      ],
    );
  }
}
