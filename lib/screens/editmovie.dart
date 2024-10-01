
import 'package:catalog/controllers/moviesController.dart';
import 'package:catalog/model/movie.dart';
import 'package:catalog/screens/list.dart';
import 'package:flutter/material.dart';


class EditMovie extends StatefulWidget {
  final Moviescontroller? moviesCtrl;
  final Movie? oldMovie;
  final int? index;
  const EditMovie({super.key, this.moviesCtrl, this.oldMovie, this.index});

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  final _formEditMovieKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController genreCtrl = TextEditingController();
  TextEditingController ratingCtrl = TextEditingController();
  TextEditingController castCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = widget.oldMovie!.name;
    yearCtrl.text = widget.oldMovie!.year;
    descriptionCtrl.text = widget.oldMovie!.description;
    genreCtrl.text = widget.oldMovie!.genre;
    ratingCtrl.text = widget.oldMovie!.rating;
    castCtrl.text = widget.oldMovie!.cast;
    durationCtrl.text = widget.oldMovie!.duration;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _formEditMovieKey,
              child: Column(
                children: [
                 
                  CustomTextFormField(
                    controller: nameCtrl,
                    labelText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insert Name";
                      }
                      return null;
                    }, numberKeyboard: false,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: yearCtrl,
                    numberKeyboard: true,
                    labelText: "Year",
                    validator: (value) {
                      if (value!.isEmpty ||(value.isNotEmpty && getYear(value) == false)) {
                        return "Insert Valid Release Year";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: descriptionCtrl,
                    maxCaracters: 200,
                    labelText: "Description",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insert Description";
                      }
                      return null;
                    }, numberKeyboard: false,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: genreCtrl,
                    labelText: "Genre",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insert Genre";
                      }
                      return null;
                    }, numberKeyboard: false,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: ratingCtrl,
                    labelText: "Rating",
                    validator: (value) {
                      if (value!.isEmpty ||
                          (value.isNotEmpty && between0and10(value) == false)) {
                        return "Insert Rating from 0 to 10";
                      }
                      return null;
                    }, numberKeyboard: true,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: castCtrl,
                    labelText: "Cast",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insert cast";
                      }
                      return null;
                    }, numberKeyboard: false,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTextFormField(
                    controller: durationCtrl,
                    labelText: "Duration in Minutes",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insert Duration";
                      }
                      return null;
                    }, numberKeyboard: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtonSendToEdit(
        formKey: _formEditMovieKey,
        nameCtrl: nameCtrl,
        yearCtrl: yearCtrl,
        descriptionCtrl: descriptionCtrl,
        genreCtrl: genreCtrl,
        ratingCtrl: ratingCtrl,
        castCtrl: castCtrl,
        durationCtrl: durationCtrl,
        oldMovie: widget.oldMovie!,
      ),
    );
  }

  bool between0and10(String value) {
    try {
      double number = double.parse(value);

      return number >= 0.toDouble() && number <= 10.toDouble();
    } catch (exception) {
      return false;
    }
  }
  
  bool getYear(String value) {
    try{
      return int.parse(value) > 1920 && int.parse(value) < DateTime.now().year;
    }catch (exception) {
      return false;
    }
  }
}

class ButtonSendToEdit extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Movie oldMovie;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController genreCtrl = TextEditingController();
  TextEditingController ratingCtrl = TextEditingController();
  TextEditingController castCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();

  ButtonSendToEdit(
      {super.key,
      required this.formKey,
      required this.oldMovie,
      required this.nameCtrl,
      required this.yearCtrl,
      required this.descriptionCtrl,
      required this.genreCtrl,
      required this.ratingCtrl,
      required this.castCtrl,
      required this.durationCtrl});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Movie movie = Movie(
              name: nameCtrl.text,
              year: yearCtrl.text,
              description: descriptionCtrl.text,
              genre: genreCtrl.text,
              rating: ratingCtrl.text,
              cast: castCtrl.text,
              duration: durationCtrl.text);
          ctrl.editMovie(oldMovie, movie);
          ctrl.update();
          Navigator.pop(context);
        }
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.grey.withOpacity(0.5),
        side: const BorderSide(width: 2, color: Colors.red),
      ),
      child: const Text(
        "Edit Movie",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}



class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String labelText;
  final bool numberKeyboard;
  final int? maxCaracters;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.validator,
    required this.labelText,
    required this.numberKeyboard,
    this.maxCaracters,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines: 1,
      keyboardType: numberKeyboard ? TextInputType.number : TextInputType.text,
      maxLength: maxCaracters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(labelText),
      ),
      controller: controller,
    );
  }
}