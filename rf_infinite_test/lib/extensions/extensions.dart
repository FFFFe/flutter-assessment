extension Contact on List {
  void sortContact() {
    sort((a, b) => '${a.firstName} ${a.lastName}'
        .toLowerCase()
        .compareTo('${b.firstName} ${b.lastName}'.toLowerCase()));
  }
}
