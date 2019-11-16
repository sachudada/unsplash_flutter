library bmi.globals;

enum Gender {
  Male,
  Female,
}
int age = 18;

bool buttonPressed = false;
bool loopActive = false;
int weight = 50;

int heightCal = 170;
double minHeight = 120;
double maxHeight = 220;
bool isCentSelected = true;

Gender selectedGender;
bool isSwitched = false;
dynamic isDarkTheme = false;
String themeLabel = "Dark Mode";

int feetValue = 4;
String inchValue = '8"';
String selectedChoice = "Centimetre";

String aboutBMI =
    "Wallpaper App powered by flutter using unsplash API." +
        "";
String mailTo = '''mailto:skdeveloperstudios@gmail.com?subject=Feedback for Pixcy App''';
