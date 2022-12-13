import 'package:flutter/material.dart';

const String kGender = "Gender";
const String kMartial_Statius = "Martial";
const String kAge = "Age";
const String kAddress = "Address";
const String kReligion = "Religion";
const String kCaste = "Caste";
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
const String kHeight = "height";
const String kIncome = "income";
const String kHobbies = "hobby";
const String kMovies = "movies";

Color primarycolor = Color(0xfFf1565A);
Color butoncolor = Color(0XFFFA2A39);
Color secoundrycolor = Color(0XFFF36F21);
Color kinputbgcolor = Color(0XFFD9D9D9);
Color normaltextcolor = Color(0XFF7A7A7A);
Color whitecolor = Color(0XFFFFFFFF);
Color blackcolor = Color(0XFF000000);
Color dividercolor = Color(0XFFC4C4C4);
Color selectedCategoryBackground = Color(0xFFF36F21);
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
    TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white);
TextStyle k12styleblack =
    TextStyle(fontSize: 12, color: Colors.black, fontFamily: "Gilroy-Regular");
TextStyle k14styleblack =
    TextStyle(fontSize: 14, color: Colors.black, fontFamily: "Gilroy-Regular");
TextStyle k16styleblack =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black);
TextStyle k18styleblack =
    TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Gilroy-Bold");
final body4StyleHeight = TextStyle(
  fontFamily: "Gilroy-Regular",
  fontWeight: FontWeight.w500,
  height: 1.5,
  fontSize: 14,
  color: Colors.black,
);
final secondaryFontStyleWeight = TextStyle(
  fontFamily: "Gilroy-Regular",
  fontWeight: FontWeight.w400,
  fontSize: 14,
  color: Colors.black,
);
final unreadStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontFamily: "Gilroy-Regular",
  height: 1.5,
  fontSize: 14,
  color: Colors.black,
);

TextStyle k18stylePrimary = TextStyle(
    fontSize: 18,
    color: butoncolor,
    fontFamily: "Gilroy-Bold",
    fontWeight: FontWeight.w800);
TextStyle k10stylePrimary =
    TextStyle(fontSize: 10, color: butoncolor, fontFamily: "Gilroy-Bold");
TextStyle k10styleWhite =
    TextStyle(fontSize: 10, color: Colors.white, fontFamily: "Gilroy-Bold");
TextStyle k25styleblack =
    TextStyle(fontSize: 23, color: Colors.black, fontFamily: "Gilroy-Bold");
TextStyle k20styleblack =
    TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Gilroy-Bold");
TextStyle k14styleblackBold =
    TextStyle(fontFamily: "Gilroy-Regular", fontSize: 14, color: Colors.black);
TextStyle k12styleblackBold =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black);

List<String>? kIncomeList = [
  "Select income",
  "<10,000",
  "10,000 - 20,000",
  "20,000 - 30,000",
  "40,000 - 50,000",
  "60,000 - 70,000",
  "80,000 - 90,000",
  ">100,000",
];
List<String>? kReligionList = [
  "Select Religion",
  "Islam",
  "Christianity",
  "Judaisim",
  "Hinduism",
  "Prefer not to say",
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
List<String>? ksmokeList = [
  'Do you smoke?',
  "Yes",
  "No",
  "Casually",
  'Prefer not to say',
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
  "Lahore",
  "Karachi",
  "Faisalabad",
  "Rawalpindi",
  "Gujranwala",
  "Peshawar",
  "Multan",
  "Hyderabad",
  "Islamabad",
  "Quetta",
  "Bahawalpur",
  "Sargodha",
  "Sialkot",
  "Sukkur",
  "Larkana",
  "Rahim Yar Khan",
  "Sheikhupura",
  "Jhang",
  "Dera Ghazi Khan",
  "Gujrat",
  "Sahiwal",
  "Wah Cantonment",
  "Mardan",
  "Kasur",
  "Okara",
  "Mingora",
  "Nawabshah",
  "Chiniot",
  "Kotri",
  "Kāmoke",
  "Hafizabad",
  "Sadiqabad",
  "Mirpur Khas",
  "Burewala",
  "Kohat",
  "Khanewal",
  "Dera Ismail Khan",
  "Turbat",
  "Muzaffargarh",
  "Abbotabad",
  "Mandi Bahauddin",
  "Shikarpur",
  "Jacobabad",
  "Jhelum",
  "Khanpur",
  "Khairpur",
  "Khuzdar",
  "Pakpattan",
  "Hub",
  "Daska",
  "Gojra",
  "Dadu",
  "Muridke",
  "Bahawalnagar",
  "Samundri",
  "Tando Allahyar",
  "Tando Adam",
  "Jaranwala",
  "Chishtian",
  "Muzaffarabad",
  "Attock",
  "Vehari",
  "Kot Abdul Malik",
  "Ferozwala",
  "Chakwal",
  "Gujranwala Cantonment",
  "Kamalia",
  "Umerkot",
  "Ahmedpur East",
  "Kot Addu",
  "Wazirabad",
  "Mansehra",
  "Layyah",
  "Mirpur",
  "Swabi",
  "Chaman",
  "Taxila",
  "Nowshera",
  "Khushab",
  "Shahdadkot",
  "Mianwali",
  "Kabal",
  "Lodhran",
  "Hasilpur",
  "Charsadda",
  "Bhakkar",
  "Badin",
  "Arif Wala",
  "Ghotki",
  "Sambrial",
  "Jatoi",
  "Haroonabad",
  "Daharki",
  "Narowal",
  "Tando Muhammad Khan",
  "Kamber Ali Khan",
  "Mirpur Mathelo",
  "Kandhkot",
  "Bhalwal",
  "Gwadar",
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
