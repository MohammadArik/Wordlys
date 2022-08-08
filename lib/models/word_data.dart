// State of the
enum DataState { Empty, Loading, Ready, NotFound, Error }

class WordData {
  DataState state = DataState.Empty;
  List<dynamic> meaningBlocksData = <dynamic>[];
  List<dynamic> sources = <dynamic>[];
}
