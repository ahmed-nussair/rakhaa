import 'package:http/http.dart' as http;

final List categories = [
  {
    "name": "مياه",
    "imageUrl": "https://i.ibb.co/2tsPfCS/water.jpg",
  },
  {
    "name": "فوط",
    "imageUrl": "https://i.ibb.co/Y3CksPc/towels.jpg",
  },
  {
    "name": "عصائر",
    "imageUrl":
        "https://i.ibb.co/q1SsdbG/Isolated-juices-Glasses-of-fresh-juice-and-pile-of-fruits-and-berries-isolated-on-white-background-w.jpg",
  },
  {
    "name": "أعشاب",
    "imageUrl": "https://i.ibb.co/4Pq4Vnp/herbs.jpg",
  },
  {
    "name": "منظفات",
    "imageUrl": "https://i.ibb.co/255FtsT/cleaners.jpg",
  },
  {
    "name": "بسكويت",
    "imageUrl": "https://i.ibb.co/Zm6Z7cy/biscuits.jpg",
  },
];

Future<bool> getImage(String url) async {
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
