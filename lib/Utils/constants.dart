import 'package:flutter/material.dart';

/*
* Stripe Keys
*/
// const String stripePublishableKey =
//     "pk_test_51MGihjD3Scdf0T5Z5IcwzY5iDcctn9PLPpbFmaVILWbEuwCO9abpsquVT4wWx30jlukayLPoFvJXgLc4ALqyG5Nx00i6peP7xI";
// const String stripeSecretKey =
//     "sk_test_51MGihjD3Scdf0T5ZEyCyXNxl4NChF32t4zVhwjBESX5iZqVHA9BIZ2Y9JX9yuEjOFxxZKNZhoqmjmfr6Yex9Erpq00WIpfEtnZ";
const String kGender = "Gender";
const String kMartial_Statius = "Martial";
const String kchildern = "childern";
const String kReligiousPractice = "rpractice";
const String kAge = "Age";
const String kAddress = "Address";
const String kReligion = "Religion";
const String kCaste = "Caste";
const String kLanguage = "language";
const String kFull_name = "full_name";
const String kStar_sign = "star_sign";
const String kCreativity = "creativity";
const String kSmoke = "smoke";
const String kEmail = "Email";
const String kPhone = "phone";
const String kPassword = "Password";
const String kEducation = "education";
const String kWork = "work";
const String kImageUrl = "imageUrl";
const String kSports = "sports";
const String kAbout = "about";
const String kJobTitle = "about";
const String kIndustry = "about";
const String kHeight = "height";
const String kIncome = "income";
const String kHobbies = "hobby";
const String kMovies = "movies";

Color primarycolor = Color(0xfFE94057);
Color textcolor = Color(0xfFE94057);
Color butoncolor = Color(0xfFE94057);
Color secoundrycolor = Color(0XFFF36F21);
Color kinputbgcolor = Color(0XFFD9D9D9);
Color normaltextcolor = Color(0XFF7A7A7A);
Color whitecolor = Color(0XFFFFFFFF);
Color blackcolor = Color(0XFF000000);
Color dividercolor = Color(0XFFC4C4C4);
Color selectedCategoryBackground = Color(0xFFFA2A39);
const Color kBaseGrey = Color(0XFFEBEBF0);

TextStyle k14styleWhite =
    TextStyle(fontSize: 14, color: Colors.white, fontFamily: "Gilroy-Bold");
TextStyle k16styleWhiteBold =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.white);
TextStyle k12styleWhite =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white);

TextStyle k16styleWhite =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);
TextStyle k18styleWhite =
    TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.white);
TextStyle k12styleblack =
    TextStyle(fontSize: 12, color: Colors.black,);
TextStyle k14styleblack =
    TextStyle(fontSize: 14, color: Colors.black,);
TextStyle k16styleblack =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);
TextStyle k18styleblack =
    TextStyle(fontSize: 18, color: Colors.black,);
final body4StyleHeight = TextStyle(
  fontWeight: FontWeight.w500,
  height: 1.5,
  fontSize: 14,
  color: Colors.black,
);
final secondaryFontStyleWeight = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.black,
);
final unreadStyle = TextStyle(
  fontWeight: FontWeight.w600,
  height: 1.5,
  fontSize: 14,
  color: Colors.black,
);

TextStyle k18stylePrimary = TextStyle(
    fontSize: 18,
    color: butoncolor,
    fontWeight: FontWeight.w800);
TextStyle k14stylePrimary = TextStyle(
    fontSize: 14,
    color: butoncolor,
    fontWeight: FontWeight.w500);
TextStyle k10stylePrimary =
    TextStyle(fontSize: 10, color: butoncolor, );
TextStyle k10styleWhite =
    TextStyle(fontSize: 10, color: Colors.white,);
TextStyle k25styleblack =
    TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.bold);
TextStyle k20styleblack =
    TextStyle(fontSize: 18, color: Colors.black,);
TextStyle k14styleblackBold =
    TextStyle( fontSize: 14, color: Colors.black);
TextStyle k12styleblackBold =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black);
TextStyle kboldStyleHeading=TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 30,
);
List<String>? kIncomeList = [
  "Select income",
  "<10,000",
  "10,000 - 20,000",
  "20,000 - 30,000",
  "40,000 - 50,000",
  "60,000 - 70,000",
  "80,000 - 90,000",
  "+100,000",
];
List<String>? kChildernList = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "More than 10",
];
List<String>? kReligionList = [
  "Select Religion",
  "Shia",
  "Sunni",
  "Christian",
  "Ahmadi",
  "Hindu",
  "Sikh",
];
List<String>? kSportsList = [
  "Select Sports",
  "Football",
  "Netball",
  "Cricket",
  "Hockey",
  "Table Tennis",
  "Tennis",
  "Squash",
  "Badminton",
  "Running",
  "Athletics",
];
List<String>? kPractisingList=[
  "Select Practising",
  "Very Practising",
  "Practising",
  "Moderately Practising",
  "Not Practising",
];
List<String>? kWorkList = [
  "Select Occupation Sector",
  "Accountancy, banking and finance",
  "Business, consulting and nanagement",
  "Charity and volutary work",
  "Creative arts and design",
  "Energy and utilities",
  "Engineering and manufacturing",
  "Environment and agriculture",
  "Healthcare",
  "Hospitality and events management",
  "Information Technology",
  "Legal",
  "Leisure, sport and tourism",
  "Marketing, advertising and PR",
  "Media and internet",
  "Property and construction",
  "Recruitment and HR",
  "Retail",
  "Sales",
  "Science and pharmaceuticals",
  "Social care",
  "Teacher training and education",
  "Transport and logistics",
];

List<String>? kheightList = [
  "Select height",
  "4'1",
  "4'2",
  "4'3",
  "4'4",
  "4'5",
  "4'6",
  "4'7",
  "4'8",
  "4'9",
  "4'10",
  "4'11",
  "5'0",
  "5'1",
  "5'2",
  "5'3",
  "5'4",
  "5'5",
  "5'6",
  "5'7",
  "5'8",
  "5'9",
  "5'10",
  "5'11",
  "6'0",
  "6'1",
  "6'2",
  "6'3",
  "6'4",
  "6'5",
  "6'6",
  "6'7",
  "6'8",
  "6'9",
  "6'10",
  "6'11"
];
List<String>? kcreativityList = [
  "Select Creativity",
  "Creativity	Art",
  'Design',
  'Make-up',
  'Photography',
  'Writing',
  'Singing',
  'Dancing',
  'Crafts',
  'Board Games',
  'Puzzles',
  'Reading'
];
List<String>? kstarList = [
  "Select Star",
  "Aries",
  "Tauras",
  "Gemini",
  "Cancer",
  "Leo",
  "Virgo",
  "Libra",
  "Scorpiun",
  "Capricornus",
  "Aquarius",
  "Pisces",
];
List<String>? kMartial_StatusList = [
  "Select Status",
  "Never Married",
  "Divorced",
  "Widowed",
  "Prefer not to say",
];
List<String>? kCityList = [
  "Select City",
  "Islamabad",
  "Lahore",
  "Karachi",
  "Peshawar",
  "Quetta",
  "Multan",
  "Faisalabad",
  "Rawalpindi",
  "Abbotabad",
  "Arif Wala",
  "Attock",
  "Azad Kashmir",
  "Ahmedpur East",
  "Badin",
  "Bahawalpur",
  "Bahawalnagar",
  "Bhalwal",
  "Bhakkar",
  "Bhimber",
  "Burewala",
  "Chaman",
  "Charsadda",
  "Chakwal",
  "Chishtian",
  "Chiniot",
  "Dadu",
  "Daska",
  "Dera Ismail Khan",
  "Dera Ghazi Khan",
  "Daharki",
  "Ferozwala",
  "Gilgit Baltistan",
  "Ghotki",
  "Gojra",
  "Gujrat",
  "Gujranwala",
  "Gujranwala Cantonment",
  "Gwadar",
  "Hafizabad",
  "Hasilpur",
  "Haroonabad",
  "Hub",
  "Hyderabad",
  "Jatoi",
  "Jaranwala",
  "Jacobabad",
  "Jhang",
  "Jhelum",
  "Kasur",
  "Kabal",
  "Kamber Ali Khan",
  "Kandhkot",
  "Kot Abdul Malik",
  "Kamalia",
  "Kāmoke",
  "Khanpur",
  "Khairpur",
  "Khuzdar",
  "Kot Addu",
  "Kotri",
  "Khushab",
  "Kohat",
  "Khanewal",
  "Lodhran",
  "Layyah",
  "Larkana",
  "Muzaffarabad",
  "Mirpur",
  "Mirpur Mathelo",
  "Mianwali",
  "Mansehra",
  "Muridke",
  "Muzaffargarh",
  "Mandi Bahauddin",
  "Mingora",
  "Mardan",
  "Mirpur Khas",
  "Nawabshah",
  "Nowshera",
  "Narowal",
  "Okara",
  "Pakpattan",
  "Rahim Yar Khan",
  "Rawalakot",
  "Sargodha",
  "Sialkot",
  "Sukkur",
  "Sheikhupura",
  "Sahiwal",
  "Sadiqabad",
  "Shikarpur",
  "Swabi",
  "Shahdadkot",
  "Sambrial",
  "Samundri",
  "Tando Allahyar",
  "Tando Adam",
  "Tando Muhammad Khan",
  "Turbat",
  "Taxila",
  "Umerkot",
  "Vehari",
  "Wazirabad",
  "Wah Cantonment",
];
List<String>? kAgeList = [
  "Select Age",
  "18",
  "19",
  "20",
  "21",
  "22",
  "23",
  "24",
  "25",
  "26",
  "27",
  "28",
  "29",
  "30",
  "31",
  "32",
  "33",
  "34",
  "35",
  "36",
  "37",
  "38",
  "39",
  "40",
  "41",
  "42",
  "47",
  "44",
  "45",
  "46",
  "47",
  "48",
  "49",
  "50",
  "51",
  "52",
  "47",
  "54",
  "55",
  "56",
  "57",
  "58",
  "59",
  "60",
  "61",
  "62",
  "63",
  "64",
  "65",
  "66",
  "67",
  "68",
  "69",
  "70",
  "71",
  "72",
  "73",
  "74",
  "75",
  "76",
  "77",
  "78",
  "79",
  "80",
];
List<String>? kLanguageList = [
  "Urdu",
  "English",
  "Punjabi",
  "Saraiki",
  "Pashto",
  "Hindko",
  "Balochi",
  "Potohari",
];
List<String>? kcasteList = [
  "Select Caste",
  "Arain",
  "Aulakh",
  "Ansari",
  "Awan",
  "Bahmani",
  "Bajwa",
  "Bangial",
  "Basra",
  "Baig",
  "Bhabra",
  "Batwal",
  "Bhati",
  "Barsar",
  "Buttar",
  "Chaudhry",
  "Chatha",
  "Chauhan",
  "Chughtai",
  "Derawal",
  "Dhariwal",
  "Dhillon",
  "Dogar",
  "Duggal",
  "Gakhar",
  "Gill",
  "Gujjar",
  "Gurmani",
  "Ibrahim",
  "Indra",
  "Iqbal",
  "Janjua",
  "Jatt",
  "Jutt",
  "Johiya",
  "Kathia",
  "Kahloon",
  "Khara",
  "Khan",
  "Khandowa",
  "Kharal",
  "Khokhar",
  "Kamboh",
  "Kirmani",
  "Sahni",
  "Khawaja",
  "Langra",
  "Langrial",
  "Lau",
  "Leel",
  "Longi",
  "Machi",
  "Mahar",
  "Mahtam",
  "Makhdoom",
  "Malik",
  "Meghwar",
  "Meo",
  "Mirza",
  "Mian",
  "Mighiana",
  "Minhas",
  "Mughal",
  "Muslim Khatris",
  "Rajput",
  "Nanda",
  "Naqvi",
  "Paracha",
  "Parihar",
  "Passi",
  "Patel",
  "Sheikh (Punjabi)",
  "Qureshi",
  "Raja",
  "Ranjha",
  "Roy",
  "Sahi clan",
  "Sangha",
  "Sanghera",
  "Satti",
  "sehgal",
  "sukhera",
  "Sethi",
  "Sirki",
  "Sangha",
  "sheikh",
  "Shanzay",
  "Sial",
  "Siddiqui",
  "Singh",
  "Sidhu",
  "Sandhu",
  "Shah",
  "Tiwana",
  "Tarar",
  "Uzair",
  "Virk",
  "Warraich",
];
