import 'package:catalog/controllers/moviesController.dart';
import 'package:catalog/screens/InfoMovie.dart';
import 'package:catalog/screens/addmovie.dart';
import 'package:catalog/screens/editmovie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ctrl = Get.find<Moviescontroller>();

class ListMovie extends StatelessWidget {
  const ListMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("List of Movies"),
        actions: [
          GetBuilder<Moviescontroller>(
            builder: (_) {
              return ctrl.movies.isNotEmpty
                  ? const ShowDeleteAll()
                  : const SizedBox();
            },
          ),
        ],
      ),
      body: GetBuilder<Moviescontroller>(
        id: "listOfMovies",
        builder: (ctrl2) {

          return ctrl2.movies.isNotEmpty
              ? ListView.builder(
                      itemBuilder: (context, index) {
                        return CardInfoFilm(
                          index: index,
                        );
                      },
                      itemCount: ctrl2.movies.length,
                    )
              : const Center(
                  child: Text("No Movies"),
                );
        },
      ),
      floatingActionButton: const AddMovieBtn(),
    );
  }
}

class CardInfoFilm extends StatelessWidget {
  final int index;
  const CardInfoFilm({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final movie = ctrl.movies[index];
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: index %2 == 0 ? 6 : 0),
        child: Card(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.name),
                    Text(movie.year),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(movie.rating)
                      ],
                    )
                  ],
                ),
                ActionsPerFilm(index),
              ],
            ),
          ),
        ),
      ),
      onTap: () => Get.to(() => InfoMovie(movie)),
    );
  }
}

class ShowDeleteAll extends StatelessWidget {
  const ShowDeleteAll({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.delete_forever),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content:
                    const Text("Are you sure you wanna delete all the films?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      ctrl.clearItems();
                      ctrl.update();
                      Navigator.pop(context);
                    },
                    child: const Text("Delete"),
                  ),
                ],
              );
            });
      },
    );
  }
}

class AddMovieBtn extends StatelessWidget {
  const AddMovieBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => AddMovie(
              moviesCtrl: ctrl,
            ));
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}

class ActionsPerFilm extends StatelessWidget {
  final int index;
  const ActionsPerFilm(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: const Icon(Icons.delete),
          onTap: () {
            ctrl.removeMovie(ctrl.movies[index]);
            ctrl.update();
          },
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          child: const Icon(Icons.edit),
          onTap: () {
            Get.to(
              () => EditMovie(
                moviesCtrl: ctrl,
                oldMovie: ctrl.movies[index],
                index: index,
              ),
            );
          },
        ),
      ],
    );
  }
}
