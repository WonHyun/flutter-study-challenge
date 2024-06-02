enum MovieListType {
  popular,
  nowPlaying,
  comingSoon,
}

enum Endpoint { popular, nowPlaying, comingSoon, movieInfo }

const Map<Endpoint, String> endpointValues = {
  Endpoint.popular: "popular",
  Endpoint.nowPlaying: "now-playing",
  Endpoint.comingSoon: "coming-soon",
  Endpoint.movieInfo: "movie",
};
