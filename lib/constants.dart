class Constants {
  //Main
  static const String appTitle = "BotaniCare";
  static const String plantScreenTitle = "Pflanzen";
  static const String roomScreenTitle = "Räume";
  static const String taskScreenTitle = "Aufgaben";
  static const String settingsScreenTitle = "Einstellungen";

  //Task
  static const String noTasks = "Alle Pflanzen sind gegossen 🥳";
  static const String wateredPlantSnackBarMessage = "Du hast {} gegossen 💧";

  //Plant
  static const String noPlantsCreated =
      "Füge deine Pflanzen 🪴 hinzu,\nidem du auf das + unten rechts drückst";

  //Room
  static const String livingroom = "Wohnzimmer";
  static const String livingroomImage = "assets/images/livingroom.jpg";
  static const String bedroom = "Schlafzimmer";
  static const String bedroomImage = "assets/images/bedroom.jpg";
  static const String bathroom = "Badezimmer";
  static const String bathroomImage = "assets/images/bathroom.jpg";
  static const String kitchen = "Küche";
  static const String kitchenImage = "assets/images/kitchen.jpg";
  static const String office = "Büro";
  static const String officeImage = "assets/images/office.jpg";
  static const String balcony = "Balkon";
  static const String balconyImage = "assets/images/balcony.jpg";
  static const String defaultImage = "assets/images/default.jpg";
  static const String emptyRoomMessage = "Sieht ziemlich leer aus hier 🍃";
  static const String noRoomsCreated =
      "Füge einen Raum 🛋️ hinzu,\nindem du auf das + unten rechts drückst";

  //Button Dialog
  static const String saveMessage = "Speichern";
  static const String saveChangesMessage = "Änderungen speichern";

  //Form Dialog
  static const String formTitleUpdating = "{} bearbeiten";
  static const String formTitleAdding = "{} hinzufügen";

  //Alert Dialog
  static const String alertDialogTitle = "{} entfernen";
  static const String alertDialogContent = "Willst du {} wirklich löschen?";
  static const String cancelDeletion = "Abbrechen";
  static const String confirmRoomDeletion = "Raum löschen";
  static const String confirmPlantDeletion = "Pflanze löschen";
  static const String deletionSnackBarMessage = "{} wurde gelöscht 🚮";

  //Api
  static const String baseURL = "https://botanicare.mauricewoike.com:8443";
  static const String apiUrlPlants =
      "https://botanicare.mauricewoike.com:8443/plants";
  static const String apiUrlRooms =
      "https://botanicare.mauricewoike.com:8443/rooms";
}
