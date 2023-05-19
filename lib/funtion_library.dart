import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/models.dart';

List<String> daysOfWeek = [
  "Thứ 2",
  "Thứ 3",
  "Thứ 4",
  "Thứ 5",
  "Thứ 6",
  "Thứ 7",
  "Chủ nhật"
];

Future<String> getImageUrl(String imagePath) async {
  Reference ref = FirebaseStorage.instance.ref().child(imagePath);
  return await ref.getDownloadURL();
}

Stream<List<Genre>> getGenres() =>
    FirebaseFirestore.instance.collection("Genre").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Genre.fromJson(e.data())).toList());

Stream<List<Movie>> getMoviess() =>
    FirebaseFirestore.instance.collection("Movie").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

Stream<List<Movie>> getPlayingMovies() => FirebaseFirestore.instance
    .collection("Movie")
    .where("release_date", isLessThanOrEqualTo: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

Stream<List<Movie>> getUpComingMovies() => FirebaseFirestore.instance
    .collection("Movie")
    .where("release_date", isGreaterThan: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

Future<List<Actor>> getActorOfMovie(String movieId) async {
  CollectionReference actorCollection =
      FirebaseFirestore.instance.collection("Actor");
  CollectionReference movieActorCollection =
      FirebaseFirestore.instance.collection("Movie_Actor");

  QuerySnapshot actorQuerySnapshots = await actorCollection.get();
  QuerySnapshot movieActorQuerySnapshots =
      await movieActorCollection.where("movie", isEqualTo: movieId).get();

  List<MovieActor> movieActors = movieActorQuerySnapshots.docs
      .map((e) => MovieActor.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  List<Actor> actors = actorQuerySnapshots.docs
      .map((e) => Actor.fromJson(e.data() as Map<String, dynamic>))
      .toList();

  List<Actor> actorsInMovie = [];
  if (movieActors.isNotEmpty && actors.isNotEmpty) {
    for (Actor actor in actors) {
      if (checkActorInMovieActorList(actor, movieActors)) {
        actorsInMovie.add(actor);
      }
    }
  }
  return actorsInMovie;
}

Future<List<String>> getAllMovieNames() async {
  List<String> movieNames = [];
  CollectionReference movieCollectionReference =
      FirebaseFirestore.instance.collection("Movie");
  QuerySnapshot movieSnapshots = await movieCollectionReference.get();
  List<Movie> movies = movieSnapshots.docs
      .map((e) => Movie.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  for (Movie tempMovie in movies) {
    movieNames.add(tempMovie.name);
  }
  return movieNames;
}

Future<List<Movie>> getAllMovie() async {
  CollectionReference movieCollectionReference =
      FirebaseFirestore.instance.collection("Movie");
  QuerySnapshot movieSnapshots = await movieCollectionReference.get();
  List<Movie> movies = movieSnapshots.docs
      .map((e) => Movie.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  return movies;
}

bool checkActorInMovieActorList(Actor actor, List<MovieActor> movieActors) {
  if (movieActors.isEmpty) return false;
  for (MovieActor movieActor in movieActors) {
    if (movieActor.actor == actor.id) return true;
  }
  return false;
}

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;
  const ImageFromUrl({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator());
        }
        String url = snapshot.data ?? "default";
        return Image.network(url);
      },
    );
  }
}

Future<List<Screening>> getAllScreeningsOfMovie(String movieId) async {
  List<Screening> screeningsOfMovie = [];
  DateTime today = DateTime.now();

  CollectionReference screeningCollection =
      FirebaseFirestore.instance.collection("Screening");
  QuerySnapshot screeningQuerySnapshots = await screeningCollection.get();
  List<Screening> screenings = screeningQuerySnapshots.docs
      .map((e) => Screening.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  for (Screening tempScreening in screenings) {
    if (tempScreening.filmId == movieId &&
        tempScreening.startTime.isAfter(today)) {
      screeningsOfMovie.add(tempScreening);
    }
  }
  return screeningsOfMovie;
}

Future<List<Screening>> getUniqueScreeningsFromTickets(List<Ticket> tickets) async{
  List<Screening> selectedScreenings = [];

  CollectionReference screeningCollection =
      FirebaseFirestore.instance.collection("Screening");
  QuerySnapshot screeningQuerySnapshots = await screeningCollection.get();
  List<Screening> screenings = screeningQuerySnapshots.docs
      .map((e) => Screening.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  for(Screening tempScreening in screenings)
  {
    if(!selectedScreenings.contains(tempScreening) && checkScreeningInTickets(tickets, tempScreening))
    {
      selectedScreenings.add(tempScreening);
    } 
  }
  return selectedScreenings;
}

bool checkScreeningInTickets(List<Ticket> tickets, Screening screening)
{
  for(Ticket tempTicket in tickets)
  {
    if(tempTicket.screeningId == screening.id) return true;
  }
  return false;
}

Future<List<Movie>> getUniqueMoviesFromScreenings(List<Screening> screenings) async {
  CollectionReference movieCollectionReference =
      FirebaseFirestore.instance.collection("Movie");
  QuerySnapshot movieSnapshots = await movieCollectionReference.get();
  List<Movie> movies = movieSnapshots.docs
      .map((e) => Movie.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  List<Movie> selectedMovies = [];
  for(Movie tempMovie in movies)
  {
    if(!selectedMovies.contains(tempMovie) && checkMovieInScreenings(screenings, tempMovie))
    {
      selectedMovies.add(tempMovie);
    }
  }
  return selectedMovies;
}

bool checkMovieInScreenings(List<Screening> screenings, Movie movie)
{
  for(Screening tempScreeing in screenings)
  {
    if(tempScreeing.filmId == movie.id)
    {
      return true;
    }
  }
  return false;
}

List<DateTime> getUniqueScreeningDates(List<Screening> screenings) {
  List<DateTime> dates = [];
  for (Screening screening in screenings) {
    if (checkUniqueDate(screening.startTime, dates)) {
      dates.add(screening.startTime);
    }
  }
  dates.sort(((a, b) => a.compareTo(b)));
  return dates;
}

bool checkUniqueDate(DateTime date, List<DateTime> dates) {
  if (dates.isEmpty) return true;
  for (DateTime tempDate in dates) {
    if (tempDate.day == date.day) return false;
  }
  return true;
}

List<String> getTheaterUniqueIdsFromScreeningsAndInDate(
    List<Screening> screenings, DateTime date) {
  List<String> theaterUniqueIds = [];
  for (Screening tempScreening in screenings) {
    if (!theaterUniqueIds.contains(tempScreening.theaterId) &&
        tempScreening.startTime.day == date.day) {
      theaterUniqueIds.add(tempScreening.theaterId);
    }
  }
  return theaterUniqueIds;
}

Future<List<Theater>> getAllTheaters() async {
  CollectionReference theatersCollection =
      FirebaseFirestore.instance.collection("Theater");
  QuerySnapshot theatersQuery = await theatersCollection.get();
  List<Theater> theaters = theatersQuery.docs
      .map((e) => Theater.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  return theaters;
}

List<Theater> getTheatersFromIds(List<String> ids, List<Theater> theaters) {
  List<Theater> validTheaters = [];
  for (String id in ids) {
    for (Theater theater in theaters) {
      if (id == theater.id && !validTheaters.contains(theater)) {
        validTheaters.add(theater);
      }
    }
  }
  return validTheaters;
}

Future<List<Ticket>> getAllTicketsOfScreening(String screeningId) async
{
  List<Ticket> tickets = [];

  CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection("Ticket");
  QuerySnapshot ticketQuery = await ticketCollection.where("screening", isEqualTo: screeningId).get();
  tickets = ticketQuery.docs
      .map((e) => Ticket.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  return tickets;
}

Future<List<Ticket>> getUserTickets(String userId) async
{
  List<Ticket> tickets = [];
  CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection("Ticket");
  QuerySnapshot ticketQuery = await ticketCollection.where("user", isEqualTo: userId).get();
  tickets = ticketQuery.docs
      .map((e) => Ticket.fromJson(e.data() as Map<String, dynamic>))
      .toList();
  return tickets;
}