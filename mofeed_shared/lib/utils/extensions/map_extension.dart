extension MapSearch on Map {
  bool multiLangSearch(String q) =>
      (this['ar'] ?? "")
          .toString()
          .trim()
          .toLowerCase()
          .contains(q.trim().toLowerCase()) ||
      (this['en'] ?? "")
          .toString()
          .trim()
          .toLowerCase()
          .contains(q.trim().toLowerCase());
}
