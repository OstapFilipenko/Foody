class Language {
  final double id;
  final String langCode;

  const Language(this.id, this.langCode);

  @override
  String toString() {
    return "Language: id-" + this.id.toString() + "; langCode-" + this.langCode;
  }
}

const List<Language> languages = <Language>[
  Language(1.0, "en"),
  Language(2.0, "de")
];
