typedef WordPair = Map<String, String>;

class Dictionary {
  late final WordPair dictionary;

  Dictionary({dictionary}) : 
    dictionary = dictionary ?? {};

  void add(String term, String definition) {
    dictionary[term] = definition;
  }

  String get(String term) {
    return dictionary[term] ?? "Can't find \"$term\" in dictionary";
  }

  void delete(String term) {
    dictionary.remove(term);
  }

  void showAll() {
    dictionary.forEach((key, value) {
      print("$key : $value");
    });
  }

  int count() {
    return dictionary.length;
  }

  void upsert(String term, String definition) {
    add(term, definition);
  }

  bool exists(String term) {
    return dictionary.containsKey(term);
  }

  void bulkAdd(List<WordPair> pairs) {
    pairs.forEach((pair) {
      if (pair["term"] != null && pair["definition"] != null)       {
        upsert(pair["term"]!, pair["definition"]!);
      }

    });
  }

  void bulkDelete(List<String> terms) {
    for (var term in terms) {
      dictionary.remove(term);
    }
  }
}

bool isTestPassed() {
  try {
    Dictionary dictionary = Dictionary();

    dictionary.add("김치", "Kimchi");
    dictionary.add("아파트", "Apartment");
    assert(dictionary.get("김치") == "Kimchi");
    assert(dictionary.get("아파트") == "Apartment");

    dictionary.delete("김치");
    assert(dictionary.get("김치") 
           == "Can't find \"김치\" in dictionary");
    assert(dictionary.exists("김치") == false);
    assert(dictionary.count() == 1);

    dictionary.upsert("저녁", "Dinner");
    assert(dictionary.get("저녁") == "Dinner");
    dictionary.delete("저녁");

    dictionary.upsert("김치", "PaoCai");
    assert(dictionary.exists("김치") == true);
    dictionary.upsert("김치", "Kimchi");
    assert(dictionary.get("김치") == "Kimchi");

    dictionary.bulkAdd([
      {"term": "점심", "definition": "Lunch"},
      {"term": "식당", "definition": "Restaurant"},
    ]);
    dictionary.bulkDelete(["김치", "아파트"]);
    assert(dictionary.count() == 2);
    assert(dictionary.get("점심") == "Lunch");
    assert(dictionary.get("식당") == "Restaurant");
    assert(dictionary.get("아파트") 
           == "Can't find \"아파트\" in dictionary");

    return true;
  }
  catch(err) {
    print(err);
    return false;
  }
}

void main() {
  if(isTestPassed()) {
    Dictionary dictionary = Dictionary();

    dictionary.add("김치", "Kimchi");
    dictionary.add("아파트", "Apartment");
    print(dictionary.get("김치"));
    print(dictionary.get("아파트"));

    dictionary.delete("김치");
    print(dictionary.get("김치"));
    print(dictionary.exists("김치"));
    print(dictionary.count());

    dictionary.upsert("저녁", "Dinner");
    print(dictionary.get("저녁"));
    dictionary.delete("저녁");

    dictionary.upsert("김치", "PaoCai");
    print(dictionary.exists("김치"));
    dictionary.upsert("김치", "Kimchi");
    print(dictionary.get("김치"));

    dictionary.bulkAdd([
      {"term": "점심", "definition": "Lunch"},
      {"term": "식당", "definition": "Restaurant"},
    ]);
    dictionary.bulkDelete(["김치", "아파트"]);
    print(dictionary.count());
    print(dictionary.get("점심"));
    print(dictionary.get("식당"));
    print(dictionary.get("아파트"));
  }
}
