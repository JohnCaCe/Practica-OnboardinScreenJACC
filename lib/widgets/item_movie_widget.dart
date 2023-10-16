import 'package:app1flutter/models/popular_model.dart';
import 'package:flutter/material.dart';

Widget itemMovieWidget(PopularModel movie, context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
    child: FadeInImage(
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 500),
        placeholder: const AssetImage('assets/loadingCA.gif'),
        image: NetworkImage(
            'https://image.tmdb.org/t/p/w500/${movie.posterPath}')),
  );
}
