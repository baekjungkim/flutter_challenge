import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://movies-api.nomadcoders.workers.dev';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Challenge',
      home: MoviesScreen(),
    );
  }
}

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          PopularMovieList(),
          NowMovieList(),
          ComingSoonMoVieList(),
        ]),
      ),
    );
  }
}

Future<List<MovieModel>> fetchMovies({required String path}) async {
  List<MovieModel> movies = [];
  final url = Uri.parse('$baseUrl/$path');
  final response = await http.get(url);
  if (response.statusCode != 200) throw Error();
  final decoded = jsonDecode(response.body);
  for (var movie in decoded['results']) {
    movies.add(MovieModel.fromJson(movie));
  }
  return movies;
}

class PopularMovieList extends StatelessWidget {
  PopularMovieList({super.key});

  final Future<List<MovieModel>> _list = fetchMovies(path: 'popular');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _list,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Popular Movies',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final id = movies[index].id;
                  final thumb = movies[index].getFullPosterPath();
                  return MovieCard(
                    prefix: 'popular',
                    id: id,
                    thumb: thumb,
                    height: 180,
                    width: 250,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class NowMovieList extends StatelessWidget {
  NowMovieList({super.key});

  final Future<List<MovieModel>> _list = fetchMovies(path: 'now-playing');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _list,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Now in Cinemas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final id = movies[index].id;
                  final thumb = movies[index].getFullPosterPath();
                  final title = movies[index].title;
                  return MovieCard(
                    prefix: 'now',
                    id: id,
                    thumb: thumb,
                    title: title,
                    height: 130,
                    width: 160,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ComingSoonMoVieList extends StatelessWidget {
  ComingSoonMoVieList({super.key});

  final Future<List<MovieModel>> _list = fetchMovies(path: 'coming-soon');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _list,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comming soon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final id = movies[index].id;
                  final thumb = movies[index].getFullPosterPath();
                  final title = movies[index].title;
                  return MovieCard(
                    prefix: 'comming',
                    id: id,
                    thumb: thumb,
                    title: title,
                    height: 130,
                    width: 160,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.id,
    required this.thumb,
    required this.height,
    required this.width,
    required this.prefix,
    this.title = '',
  });

  final int id;
  final String thumb;
  final String title;
  final double height;
  final double width;
  final String prefix;

  void _onMovieTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(id: id, prefix: prefix),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onMovieTap(context),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Hero(
                tag: '$prefix $id',
                child: Image.network(
                  thumb,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (title.isNotEmpty)
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

Future<MovieDetailModel> fetchMovie({required int id}) async {
  final url = Uri.parse('$baseUrl/movie?id=$id');
  final response = await http.get(url);
  if (response.statusCode != 200) throw Error();
  final movie = jsonDecode(response.body);
  return MovieDetailModel.fromJson(movie);
}

String minutesToHour(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0]}h ${parts[1]}min';
}

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.id,
    required this.prefix,
  });

  final int id;
  final String prefix;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = fetchMovie(id: widget.id);
  }

  void _onBackTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movie,
      builder: (context, snapshot) {
        final size = MediaQuery.of(context).size;
        if (!snapshot.hasData) {
          return SizedBox(
            height: size.height,
            width: size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final movie = snapshot.data!;
        const maxAverage = 5;
        final voteAverage = (movie.voteAverage / 2).round();
        final runtime = minutesToHour(movie.runtime);
        final genres = movie.genres.map((genre) => genre.name).toList();
        return Scaffold(
          body: Stack(children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Hero(
                tag: '${widget.prefix} ${widget.id}',
                child: Image.network(
                  movie.getFullBackdropPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: size.height,
              width: size.width,
              color: Colors.black54,
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(14),
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _onBackTap,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Back to list',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          for (int i = 1; i <= maxAverage; i++)
                            Icon(
                              Icons.star,
                              color: voteAverage >= i
                                  ? Colors.amber
                                  : Colors.grey.shade500,
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$runtime | ${genres.join(' ')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Storyline',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width - 100,
                        child: Text(
                          movie.overview,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SafeArea(
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Buy ticket',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel(
      this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  String getFullPosterPath() {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String getFullBackdropPath() {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        json['adult'] as bool,
        json['backdrop_path'] as String?,
        (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
        json['id'] as int,
        json['original_language'] as String,
        json['original_title'] as String,
        json['overview'] as String,
        (json['popularity'] as num).toDouble(),
        json['poster_path'] as String,
        json['release_date'] as String,
        json['title'] as String,
        json['video'] as bool,
        (json['vote_average'] as num).toDouble(),
        json['vote_count'] as int,
      );

  Map<String, dynamic> toJson(MovieModel instance) => {
        'adult': instance.adult,
        'backdrop_path': instance.backdropPath,
        'genre_ids': instance.genreIds,
        'id': instance.id,
        'original_language': instance.originalLanguage,
        'original_title': instance.originalTitle,
        'overview': instance.overview,
        'popularity': instance.popularity,
        'poster_path': instance.posterPath,
        'release_date': instance.releaseDate,
        'title': instance.title,
        'video': instance.video,
        'vote_average': instance.voteAverage,
        'vote_count': instance.voteCount,
      };
}

class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final BelongToCollection? belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel(
      this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  String get getFullPosterPath {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String get getFullBackdropPath {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailModel(
        json['adult'] as bool,
        json['backdrop_path'] as String,
        json['belongs_to_collection'] == null
            ? null
            : BelongToCollection.fromJson(
                json['belongs_to_collection'] as Map<String, dynamic>),
        json['budget'] as int,
        (json['genres'] as List<dynamic>)
            .map((e) => Genres.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['homepage'] as String,
        json['id'] as int,
        json['imdb_id'] as String,
        json['original_language'] as String,
        json['original_title'] as String,
        json['overview'] as String,
        (json['popularity'] as num).toDouble(),
        json['poster_path'] as String,
        (json['production_companies'] as List<dynamic>)
            .map((e) => ProductionCompanies.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json['production_countries'] as List<dynamic>)
            .map((e) => ProductionCountries.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['release_date'] as String,
        json['revenue'] as int,
        json['runtime'] as int,
        (json['spoken_languages'] as List<dynamic>)
            .map((e) => SpokenLanguages.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['status'] as String,
        json['tagline'] as String,
        json['title'] as String,
        json['video'] as bool,
        (json['vote_average'] as num).toDouble(),
        json['vote_count'] as int,
      );

  Map<String, dynamic> toJson(MovieDetailModel instance) => {
        'adult': instance.adult,
        'backdrop_path': instance.backdropPath,
        'belongs_to_collection': instance.belongsToCollection,
        'budget': instance.budget,
        'genres': instance.genres,
        'homepage': instance.homepage,
        'id': instance.id,
        'imdb_id': instance.imdbId,
        'original_language': instance.originalLanguage,
        'original_title': instance.originalTitle,
        'overview': instance.overview,
        'popularity': instance.popularity,
        'poster_path': instance.posterPath,
        'production_companies': instance.productionCompanies,
        'production_countries': instance.productionCountries,
        'release_date': instance.releaseDate,
        'revenue': instance.revenue,
        'runtime': instance.runtime,
        'spoken_languages': instance.spokenLanguages,
        'status': instance.status,
        'tagline': instance.tagline,
        'title': instance.title,
        'video': instance.video,
        'vote_average': instance.voteAverage,
        'vote_count': instance.voteCount,
      };
}

class BelongToCollection {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  BelongToCollection(this.id, this.name, this.posterPath, this.backdropPath);

  factory BelongToCollection.fromJson(Map<String, dynamic> json) =>
      BelongToCollection(
        json['id'] as int,
        json['name'] as String,
        json['poster_path'] as String?,
        json['backdrop_path'] as String?,
      );

  Map<String, dynamic> toJson(BelongToCollection instance) => {
        'id': instance.id,
        'name': instance.name,
        'poster_path': instance.posterPath,
        'backdrop_path': instance.backdropPath,
      };
}

class Genres {
  final int id;
  final String name;

  Genres(this.id, this.name);

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        json['id'] as int,
        json['name'] as String,
      );

  Map<String, dynamic> toJson(Genres instance) => {
        'id': instance.id,
        'name': instance.name,
      };
}

class ProductionCompanies {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompanies(this.id, this.logoPath, this.name, this.originCountry);

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      ProductionCompanies(
        json['id'] as int,
        json['logo_path'] as String?,
        json['name'] as String,
        json['origin_country'] as String,
      );
  Map<String, dynamic> toJson(ProductionCompanies instance) => {
        'id': instance.id,
        'logo_path': instance.logoPath,
        'name': instance.name,
        'origin_country': instance.originCountry,
      };
}

class ProductionCountries {
  final String iso31661;
  final String name;

  ProductionCountries(this.iso31661, this.name);

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      ProductionCountries(
        json['iso_3166_1'] as String,
        json['name'] as String,
      );
  Map<String, dynamic> toJson(ProductionCountries instance) => {
        'iso_3166_1': instance.iso31661,
        'name': instance.name,
      };
}

class SpokenLanguages {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguages(this.englishName, this.iso6391, this.name);

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      SpokenLanguages(
        json['english_name'] as String,
        json['iso_639_1'] as String,
        json['name'] as String,
      );
  Map<String, dynamic> toJson(SpokenLanguages instance) => {
        'english_name': instance.englishName,
        'iso_639_1': instance.iso6391,
        'name': instance.name,
      };
}
