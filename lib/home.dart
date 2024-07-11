import 'package:flutter/material.dart';
import 'package:travel_hub/Popular.dart';
import 'package:travel_hub/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<PopularPlaces> allSearch = []
    ..addAll(mountain)
    ..addAll(city)
    ..addAll(countryHouse)
    ..addAll(kol)
    ..addAll(tarix)
    ..addAll(popPlaces);
  List<PopularPlaces> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;
  bool loading = true;
  int smth = 0;
  String categoryName = "Barchasi";

  @override
  void initState() {
    super.initState();
    filteredItems = allSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  void _filterItems(String query) {
    filteredItems = allSearch.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {});
  }

  final List<PopularPlaces> allPlaces = []
    ..addAll(mountain)
    ..addAll(city)
    ..addAll(countryHouse)
    ..addAll(kol)
    ..addAll(tarix);

  List<PopularPlaces> getCurrentList() {
    switch (smth) {
      case 0:
        return allPlaces;
      case 1:
        return mountain;
      case 2:
        return countryHouse;
      case 3:
        return city;

      case 4:
        return kol;
      default:
        return tarix;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xFF031F2B);
    Color secColor = Color(0xFF5EDFFF);
    Color searchColor = Color(0xFF263238);

    List<PopularPlaces> curList = getCurrentList();
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Sayohat",
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: searchColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.transparent)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: _searchController,
                     onChanged:  (String query) => _filterItems(query),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white24, fontSize: 20),
                          hintText: 'Qidirish...',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white24,
                          ),
                          border: InputBorder.none),

                      //onChanged:

                      style: TextStyle(color: Colors.white24, fontSize: 20)),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 38,
              child: ListView.separated (
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final String category = categoryList[index];
                  final bool isSelected = index == _selectedIndex;
                  final Color containerColor =
                      isSelected ? secColor : searchColor;
                  final Color textColor = isSelected ? mainColor : Colors.white;
                  return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          smth = index;
                          categoryName = category;
                        });
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: Text(
                            "$category",
                            style: TextStyle(color: textColor, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
              ),
            ),

            SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Mashxur joylar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            SizedBox(height: 16),

            //popular places
            SizedBox(
              height: 240.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popPlaces.length,
                itemBuilder: (context, index) {
                  PopularPlaces place = popPlaces[index];
                  final String imageUrl = place.imageUrl;
                  final String name = place.name;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Detail(selectedItem: place),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Container(
                        width: 130.0,
                        height: 240.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child:
                                Image.asset(place.imageUrl, fit: BoxFit.cover)),
                      ),
                      Positioned(
                          bottom: 16.0,
                          left: 8.0,
                          child: Text(
                            place.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                      Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          child: Text(
                            place.location,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ))
                    ]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 18,
                  );
                },
              ),
            ),

            SizedBox(height: 32.0),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                categoryName,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: curList.length,
                itemBuilder: (context, index) {
                  PopularPlaces place = curList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Detail(selectedItem: place),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                place.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 8.0,
                            bottom: 24.0,
                            child: Text(
                              place.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                            left: 8.0,
                            bottom: 8.0,
                            child: Text(
                              place.location,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                        Positioned(
                            bottom: 8.0,
                            right: 48.0,
                            child: Text(
                              place.rate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                            bottom: 10.0,
                            right: 16.0,
                            child: Image.asset(
                              'assets/images/star.png',
                              width: 24.0,
                              height: 24.0,
                            ))
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 16.0,
                  );
                },
              ),
            ),

            SizedBox(
              height: 32.0,
            )
          ],
        ),
      ),
    );
  }
}







List<String> categoryList = [
  "Barchasi",
  "Tog'lar",
  "Dachalar",
  "Shaharlar",
  "Ko'l",
  "Tarixiy inshootlar"
];
final List<PopularPlaces> popPlaces = [
  PopularPlaces(
      rate: '4.5',
      imageUrl: 'assets/images/zomin.png',
      name: 'Zomin',
      location: 'Jizzax',
      description: '''
Zomin haqida ma'lumot:
Joylashuvi:

O'zbekistonning Jizzax viloyatida joylashgan.
Tashkil etilgan yili: 1926-yil.
Maydoni: 2,87 ming km².
Aholisi: 150 ming kishi (2010).
Ma'muriy markazi: Zomin shahri.
Boshqa yirik aholi punktlari: Dashtobod shaharcha, Yom qishlog'i.
Tabiati:

Zomin tumanining shimoliy, markaziy va sharqiy qismi pasttekislik, janubiy-g'arbiy qismi qir-adir va tog'lardan iborat.
Yer yuzasi shimoldan janubga tomon ko'tarilib boradi.
Iqlimi keskin kontinental, yozi issiq, quruq, qishi bir oz sovuq.
Eng baland nuqtasi: Shavkartog' (4044 m).
Tarixi:

Zomin tumani qadim tarixga ega.
Hududda arxeologik qazuvlar natijasida paleolit, neolit, bronza va temir davrlariga oid yodgorliklar topilgan.
O'rta asrlarda Zomin tumani Movarounnahr tarkibiga kirgan.
19-asrda Turkiston general-gubernatorligining bir qismi bo'lgan.
Sovet davrida Zomin tumani Jizzax viloyatining tarkibiga kirgan.
Aholisi:

Zomin tumanida turli millatlar yashaydi, asosan o'zbeklar.
Aholisi asosan qishloq joylarda yashaydi.
Iqtisodiyot:

Qishloq xo'jaligi tuman iqtisodiyotining asosiy tarmog'idir.
Yetakchi ekinlar: g'alla, paxta, sabzavot, meva.
Chorvachilik ham rivojlangan.
Tuman hududida konchilik, o'rmonchilik va turizm sohalari ham mavjud.
Diqqatga sazovor joylar:

Zomin milliy bog'i: O'zbekistonning eng yirik milliy bog'laridan biri. Bog'da noyob o'simlik va hayvonot turlari yashaydi.
"Zomin" sihatgohi: Tog'li havoda shifo topish uchun mo'ljallangan.
Parpi Oyim majmuasi: 16-asrga oid meʼmoriy yodgorlik.
Qizil o'toqsoy dalasi: Tabiiy go'zalliklarga boy joy.
Boboyong'oq: 700 yoshli yong'oq daraxti.
Zomin tumani O'zbekistonning eng go'zal va ma'mur tumanlaridan biri.

Zomindan nima olib kelish mumkin:

Yong'oq: Zomin yong'oqlari o'zining ta'mi va sifatliligi bilan mashhur.
Quritilgan meva: O'rik, shaftolli, qaysi va boshqalar.
Shira: Zomin shirasi o'zining xushbo'yligi va mazasi bilan ajralib turadi.
Asal: Zomin asal tabiiy va foydali mahsulot.
Suvenirlar: Milliy liboslar, kulolchilik buyumlari, zargarlik buyumlari.
Zomin tumaniga qanday borish mumkin:

Toshkentdan avtobus yoki poyezd bilan borish mumkin.
Jizzaxdan avtobus yoki taksi bilan borish mumkin.
Zominda qayerda turish mumkin:

Tumanda bir necha mehmonxona va dam olish uylari mavjud.
Sihatgohlarda ham turish mumkin.'''),
  PopularPlaces(
      rate: '5.0',
      imageUrl: 'assets/images/tosh.png',
      name: 'Toshkent shahri',
      location: 'Toshkent Viloyati',
      description:
          '''Toshkent O'zbekistonning poytaxti va Markaziy Osiyodagi eng katta shaharlardan biridir.  Bu shahar  uzun va boy tarixga ega bo'lib, bir necha asrlar davomida madaniyat va savdo markazi sifatida faoliyat yuritgan.  Toshkent zamonaviy metropolitenga aylanib ulgurgan bo'lsa-da,  o'zining  qadimiy jozibasini ham saqlab qolgan.

Toshkentning jozibali tomonlari:

Tarixiy yodgorliklar: Toshkentda ko'plab tarixiy yodgorliklar, jumladan:
Hazrat Imom maydoni: Bu maydonda masjidlar, madrasalar va maqbaralar kabi muqaddas joylar joylashgan.
Chorsu bazori: An'anaviy uslubdagi yirik bozor bo'lib, mahsulotlar va suvenirlar sotib olish uchun ajoyib joy.
Koon masjidi: Toshkentning eng qadimgi masjidlaridan biri.
Muzeylar: Toshkentda bir qancha qiziqarli muzeylar mavjud, jumladan:
O'zbekiston Milliy tarix muzeyi
Amir Temur muzeyi
Sovet Ittifoqi muzeyi
Parklar va bog'lar: Toshkentda ko'plab go'zal parklar va bog'lar bor, masalan:
Bog'i Bobur: Bobur tomonidan asos solingan bog'
Milliy istirohat bog'i: Dam olish va sayr qilish uchun ajoyib joy
Zamonaviy binolar: Toshkentda zamonaviy binolar va ko'ngilochar majmualari ham bor..'''),
  PopularPlaces(
      rate: '8.0',
      imageUrl: 'assets/images/kokand.png',
      name: "Qo'qon",
      location: "Farg'ona viloyati",
      description:
          '''Qoʻqon Xudoyorxon muzeyi Fargʻona vodiysi madaniyatining boy tarixini aks ettiruvchi Oʻzbekistondagi muhim muzeylardan biri hisoblanadi.  U 1871-yilda  soʻnggi Qoʻqon xoni  Xudoyorxon tomonidan asos solingan  Kenegas saroyi binosida joylashgan.

Muzey ekspozitsiyalari:

Muzeyda Fargʻona vodiysi tarixini qamrab oluvchi bir nechta doimiy koʻrgazmalar mavjud.  Bulardan baʼzilari:

Qoʻqon xonligi tarixi: Xonlikning tashkil topilishi, rivoji va tanazzulga yuzurishi haqida soʻhbat etiladi. Muzeyda xonalarning interyeri, qirgʻoq aslahalari, tangalari va hujjatlari kabi eksponatlar mavjud.
Arxeologiya boʻlimi: Vodiyning turli davrlariga oid arxeologik topilmalar, jumladan soʻnggi paleolit davridan tutuib oʻrta asrlarga oid buyumlar koʻrsatilgan.
Hunarmandchilik va amaliy sanʼat: Fargʻona vodiysiga xos hunarmandchilik buyumlari, jumladan shoyi toʻqimachilik, mushakavorlik, metall buyumlar va zargarlik buyumlari koʻrgazmada taqdim etilgan.
Milliy liboslar: Fargʻona vodiysi xalqining anʼanaviy kiyimlari va zargarlik buyumlari koʻrsatilgan..'''),
  PopularPlaces(
      rate: '9.0',
      imageUrl: 'assets/images/mirzo.png',
      name: "M.Ulug'bek rasadxonasi",
      location: "Samarqand viloyati",
      description:
          '''Mirzo Ulug'bek rasadxonasi, 15-asrda temuriylar davri astronomi Ulug'bek tomonidan barpo etilgan ko'hna astronomik kuzatuv muassasasi.  Bu Samarqanddagi 15-asr me'morchiligining nodir namunalaridan biri hisoblanadi va UNESCO Jahon merosi ro'yxatiga kiritilgan.

Rasadxonaning qurilishi:

Qurilishga 1420-yillarda boshlangan va 1428-1429-yillarda yakunlangan.
Ulug'bek o'z davrining mashhur olimlari - astronom, matematik, me'morlar jalb qilingan.
Rasadxona balandligi 30,4 m dan iborat 3 qavatli qilib qurilgan.
Unda o'ndan ortiq turli astronomik qurilma va asboblar bo'lgan.
Rasadxonaning ahamiyati:

Ulug'bek rasadxonasi o'z davrining eng ilg'or astronomik muassasalaridan biri edi.
Bu yerda bir qator muhim astronomik kashfiyotlar qilingan, jumladan:
Yulduzlar jadvali - 1018 ta yulduz tavsifidan iborat bebaho asar.
Quyosh yilining davomiyligini aniqlash.
Yulduzlar harakatining qonuniyatlarini o'rganish.
Ulug'bek rasadxonasi astronomiya fanining rivojlanishiga katta hissa qo'shgan.'''),
];

final List<PopularPlaces> mountain = [
  PopularPlaces(
      rate: '3.2',
      imageUrl: 'assets/images/hazrat.png',
      name: 'Hazrati Sulton',
      location: 'Qoraqolpogiston',
      description:
          '''Hazrati Sulton togʻi Oʻzbekistondagi eng baland nuqta boʻlib, Gʻissar tizmasida, Tojikiston bilan chegarada joylashgan. Bu togʻ oʻzining ajoyib manzaralari, qiyin chiqishi va boy tarixi bilan mashhur.

Ajoyibligi:

Eng baland nuqta: Oʻzbekistonda choʻqqisi eng baland boʻlgan togʻ hisoblanadi. Choʻqqiga chiqish muvaffaqiyatli boʻlgan alpinistlar uchun bu unutilmas tajriba boʻladi.
Koʻrkam koʻrinish: Hazrati Sulton togʻining choʻqqisidan Gʻissar tizmasi va atrofdagi ajoyib manzaralar koʻrinib turadi.
Tabiiy goʻzallik: Togʻ yonbagʻirlari turli oʻsimliklar bilan qoplangan va bu hudud yovvoyi tabiat severlar uchun idealdir.
Qiyin chiqish:

Tajribali alpinistlar uchun: Hazrati Sulton togʻiga chiqish qiyin va faqat tajribali alpinistlar uchun tavsiya etiladi.
Maxsus jihozlar va jismoniy tayyorgarlik talab qilinadi.'''),
  PopularPlaces(
      rate: '3.2',
      imageUrl: 'assets/images/chim.png',
      name: 'Chimyon',
      location: 'Toshkent viloyati',
      description:
          ''' Oʻzbekistonning mashhur sayyohlik joylaridan biri boʻlib,  Tyan Shan togʻ tizmasining gʻarbiy qismida joylashgan. Toshkent shahridan taxminan 85 kilometr uzoqlikda joylashgan bu togʻlar "Oʻzbekistonning Shveytsariyasi" deb nomlanadi.

Chimyon togʻlarining jozibali tomonlari:

Tabiiy goʻzallik: Chimyon togʻlari baland qaragʻayzorlar, munjur oʻrmonlari, toza togʻ havosi va soʻl qoʻrgʻonlar bilan mashhur.
Dam olish imkoniyatlari: Chimyon togʻlari yil boʻyi davomida sayyohlarni oʻziga tortadi. Siz bu yerda quyidagi tadbirlar bilan shugʻullanishingiz mumkin:
Yoyda: Piyoda yurish, togʻ velosipi yurish, lager qurish, rock-climbing, ot minish va boshqalar.
Qishda: changʻi sporti, snoubord, telemark va xizmat koʻrsatadigan koʻplab dam olish maskanlari mavjud.
Sogʻlomlashtirish imkoniyati: Toza togʻ havosi va mineral suvlar Chimyon togʻlarini sogʻlomlashtirish uchun ideal joyga aylantiradi.
Tarixiy yodgorliklar: Chimyon togʻlarida bir necha tarixiy yodgorliklar, jumladan Chorvoq suv ombori va Booda togʻ haykali kabi joylar mavjud.
Chimyon togʻlariga borishdan oldin quyidagilarni eslab o'ting:

Ob-havo sharoitlari bilan tanishib chiqing, chunki togʻlarda ob-havo tez oʻzgarishi mumkin.
Kerakli jihozlar, jumladan poyabzal, issiq kiyim va quyoshdan himoya vositalarini olib boring.
Agar siz tajribali sayyoh boʻlmasangiz, togʻlarda yoʻldan ozish tavsiya etilmaydi.
Chimyon togʻlarida joylashgan milliy parklar va qoʻriqxonalarning qoidalariga rioya qiling.'''),
];

final List<PopularPlaces> countryHouse = [
  PopularPlaces(
      rate: '5.1',
      imageUrl: 'assets/images/amirsoy.png',
      name: 'Amir Soy',
      location: 'Toshkent',
      description:
          '''Amirsoy Resort O'zbekistonda tog' тури va dam olish uchun mashhur joylardan biri hisoblanadi. Toshkent viloyatining Boʻstonliq tumanida, Chatqol tizmasining shimoliy yonbagʻrida, Toshkent shahridan taxminan 65 kilometr uzoqlikda joylashgan.

Amirsoy quyidagilar bilan mashhur:

Tog' chang'i sporti imkoniyatlari: Amirsoy chang'i mavsumida chang'i sporti bilan shug'ullanish uchun ajoyib imkoniyatlarni taklif etadi. Turli qiyinchilikdagi chang'i yo'llari mavjud bo'lib, tajribali chang'ichilar ham, yangi boshlanuvchilar ham chang'idan zavqlanishlari mumkin.
Dam olish maskani: Amirsoyda turli xil mehmonxonalar, villalar va dam olish uylari mavjud bo'lib, mehmonlarga qulaylik va komfortli muhit yaratadi.
Koʻngilochar tadbirlar: Dam olish maskanida restoranlar, kafelar, diskotekalar kabi koʻngilochar joylar mavjud. Bundan tashqari, bilard, sauna va boshqa imkoniyatlar ham mavjud.
Tabiiy goʻzallik: Amirsoy goʻzal togʻ manzaralari, toza havosi va sokinat muhiti bilan mashhur. Atrofda sayr qilish, piknik qilish yoki shunchaki dam olib, togʻ havosidan zavqlanish uchun ajoyib joy.
Amirsoyga borish uchun Toshkent shahridan avtomobil yoki avtobus bilan borish mumkin. Dam olish maskani yil davomida ochiq boʻlib, har bir fasl oʻziga xos goʻzalligi bilan ajralib turadi.''')
];

final List<PopularPlaces> city = [
  PopularPlaces(
      rate: '10.0',
      imageUrl: 'assets/images/andijan.png',
      name: 'Andijon',
      location: 'Andijon viloyati',
      description:
          '''Andijon shahri Fargʻona vodiysining sharqiy qismida, Qirgʻiziston bilan chegaradosh joylashgan Oʻzbekistonning eng qadim va goʻzal shaharlaridan biridir. Bu shahar oʻzining boy tarixi, noyob meʼmorchiligi, madaniyati va tabiiy goʻzalligi bilan mashhur.

Andijonning afzalliklari quyidagilardan iborat:

Tarixiy ahamiyati:

Qadim shahar: Andijon miloddan avvalgi 7-asrga oid arxeologik topilmalar asosida juda qadim shahar hisoblanadi.
Muhim savdo markazi: Buyuk ipak yoʻli davrida Andijon muhim savdo markazi boʻlib xizmat qilgan.
Boy madaniyat merosi: Shaharda bir qancha masjidlar, madrasalar, maqbaralar va muzeylar kabi tarixiy yodgorliklar saqlanib qolgan.
Meʼmorchiligi va madaniyati:

Noyob meʼmorchiligi: Andijonda islom meʼmorchiligi namunalari, jumladan, Jami masjid, Xonaqoh masjid va Bogʻdodxon bobo maqbarasi kabi goʻzal inshootlar mavjud.
Hunarmandchilik anʼanalari: Andijon shoyi, askiya va seramika buyumlari bilan mashhur. Hunarmandchilik anʼanalari avloddan avlodga oʻtib kelgan.
Rangbarang madaniyati: Andijonda Oʻzbekistonning boy madaniyati va urf-odatlari, jumladan, anʼanaviy musiqa, raqs va oʻyinlar bilan tanishish imkoniyati mavjud.
Tabiiy goʻzalligi:

Fargʻona vodiysi manzaralari: Andijon Fargʻona vodiysining ajoyib togʻlari va vodiylari bilan oʻralgan.
Sayr qilish va dam olish uchun ajoyib maskan.
Mineral buloqlar: Andijon atrofida shifobaxsh taʼsiri bilan mashhur mineral buloqlar mavjud.''')
];

final List<PopularPlaces> tarix = [
  PopularPlaces(
      imageUrl: 'assets/images/samarqand.png',
      name: 'Registon',
      location: 'Samarqand viloyati',
      description:
          '''Registon maydoni (Registan Square) - bu Samarqandning markaziy maydoni bo'lib, u Timuriylar davrida ilm va savdo markazi vazifasini o'tagan. Registonning nomi forscha "maydon" yoki "cho'l" degan ma'noni anglatadi.

Maydon uchta ulug'vor madrasalar bilan o'ralgan:

Ulug'bek madrasasi (1417-1420): Ulug'bek tomonidan qurilgan bu madrasa astronomiya va matematika sohalarida ta'lim berish bilan mashhur edi. Undagi mozaiklar va naqshlar o'zining go'zalligi bilan ajralib turadi.
Tilla-Kori madrasasi (1646-1660): Bu madrasa o'zining "oltinli" gumbazi bilan mashhur. Madrasa devorlari naqsh va bezaklar bilan ziynatli bo'lib, ilm va bilim maskani sifatida tanilgan.
Sherdor madrasasi (1619-1636): Sherdor madrasasi yo'lbars tasvirlangan portaliga ko'ra o'z nomini olgan. U fiqh va huquq bo'yicha ta'lim berish bilan mashhur bo'lgan.
Registon maydoni nafaqat me'moriy yodgorlik, balki Samarqand shahrining ramzi ham hisoblanadi. Bugungi kunda maydon sayyoh va mehmonlar uchun ochiq bo'lib, uning atrofida hunarmandchilik buyumlari sotiladigan do'konlar va kafelar joylashgan.''',
      rate: '9.1'),
  PopularPlaces(
      imageUrl: 'assets/images/arkbux.png',
      name: 'Buxoro Ark',
      location: 'Buxoro shahri',
      description:
          ''' (Buxoro qalʼasi deb ham ataladi) Buxoro shahrining eng qadimgi qismidir. Taxminan 5-asrda qurilgan bu ulug'vor qalʼa shahar atrofidagi balandlikda joylashgan bo'lib, ilgari shaharning markazi hisoblanardi.

Ibratli tarixi:

Ark bir necha asrlar davomida Buxoro amirlarining turmush joyi, maʼmuriy markazi va mudofaa istehkomi boʻlib xizmat qilgan.
U bir necha bor vayron boʻlib, qayta tiklangan.
Minglab ishchilar qoʻli bilan qurilgan Ark oʻzining mustahkam devorlari va darvozalar bilan mashhur boʻlgan.
Bugungi kunda:

Ark endi muzey majmuasiga aylangan bo'lib, Buxoro tarixini aks ettiruvchi ko'rgazmalarni o'z ichiga oladi.
Ark hududida xazina muzeyi, amirlar saroyi qoldiqlari, jome masjid va boshqa qiziqarli joylar mavjud.
Arkning tepasiga chiqib Buxoro panoramasini tomosha qilish mumkin.

''',
      rate: '5.8')
];

final List<PopularPlaces> kol = [
  PopularPlaces(
      rate: '5.0',
      imageUrl: 'assets/images/nefrit.png',
      name: 'Nefrit koli',
      location: 'Toshkent',
      description:
          '''Nefrit koʻli (shuningdek, Urungoch koʻli deb ham ataladi) – bu Toshkent viloyati, Boʻstonliq tumani, Ugom-Chatqol milliy bogʻida joylashgan bir-biriga tutash ikkita togʻ koʻli. Koʻllar oʻzining ajoyib turkuz rangli suvlari bilan mashhur boʻlib, mashhur sayyohlik maskani hisoblanadi.

Nomi:

"Nefrit koʻli" nomi oʻzbekcha "nefrit" soʻzidan kelib chiqqan boʻlib, koʻlning jozibali zumrad yashil rangini eslatadi.  Ikkinchi nomi "Urungoch koʻli" esa uygʻur tilidan kelib chiqqan boʻlib, "yorqin nefrit koʻli" degan maʼnoni anglatadi.

Joylashuvi va xususiyatlari:

Ugom-Chatqol togʻlarining jozibali joyida joylashgan Nefrit koʻli ikkita alohida koʻldan iborat:

Yuqori Urungoch: Dengiz sathidan taxminan 2200 metr balandlikda joylashgan Yuqori Urungoch ikki koʻldan kattaroq va mashhurroqdir. Uning shفاف suvlari atrofidagi yashil oʻtlar bilan birga ajoyib manzarani taqdim etadi.

Pastki Urungoch: Yuqori Urungochdan bir oz pastda joylashgan Pastki Urungoch mayda va kamroq ziyora qilinadi. Uning suvlari, ayniqsa, yoz oylarida oʻzining jonli turkuz rangi bilan mashhur.'''),
  PopularPlaces(
      rate: '4.8',
      imageUrl: 'assets/images/orol.png',
      name: 'Orol dengizi',
      location: 'Qoraqolpogiston',
      description:
          '''Orol dengizi, ilgari Qozogʻiston va Oʻzbekiston oʻrtasida joylashgan ulkan shoʻr suv havzasi boʻlib, 1960-yillarda dunyoda toʻrtinchi oʻrinda turardi. Biroq, uning taqdiri katta miqyosdagi sugʻorish loyihalari uchun uning toʻydigan daryolari Sirdaryo va Amudaryoning suvlari olib ketilishi sababli keskin oʻzgardi.

      Shundan beri Orol dengizi oʻzining asl oʻlchamidan bir qismini tashkil etadi, hozirda esa bir necha alohida suv havzalari qoldi. Ushbu ekologik falokat jiddiy oqibatlarga olib keldi:

  Bioxilma-xillikning yoʻqolishi: Koʻpgina baliq turlari yoʻqolib ketdi va umumiy yovvoyi tabiat sezilarli darajada kamaydi.
  Shoʻrlanish: Suv sathiyasi pasayish bilan qolgan suv yanada shoʻr boʻlib, koʻpchilik suv hayotini buzdi.
  Chang boʻronlari: Endilikdagi shoʻrxoʻl boʻlgan ochiq koʻl tubi chang boʻronlarining manbaiga aylanib, u tuz va zaharli kimyoviy moddalarni olib yuradi, bu havo sifatiga va sogʻliqqa taʼsir qiladi.
      Iqtisodiy taʼsir: Baliqchilik sohasi qulab tushdi va mintaqaning iqtisodiyoti zarar koʻrdi.
  Orol dengizini tiklash uchun harakatlar qilinmoqda, lekin muammolar juda katta. Ushbu ekologik falokatning uzoq muddatli oqibatlari kelgusi oʻnlab yillar davomida sezilaveradi.

      '''),
  PopularPlaces(
      imageUrl: 'assets/images/chorvoq.png',
      name: 'Chorvoq',
      location: 'Toshkent viloyati',
      description:
          '''Toshkent viloyatining Bo'stonliq tumanida joylashgan sun'oiy ko'ldir. U 1960-yillarda gidroelektr stantsiyasi loyihasi doirasida qurilgan va o'shandan beri mahalliy aholi hamda xorijiy turistlar uchun mashhur dam olish maskaniga aylangan.

Quyidagi faktlar Charvoq ko'lini diqqatga sazovor joyga aylantiradi:

Tabiiy go'zallik va dam olish imkoniyatlari: Ko'l atrofidagi tog'lar Charvoq ko'liga ajoyib ko'rinish beradi. Suv sporti, piyoda yurish, yovvoyi tabiatni tomosha qilish va madaniy sayohatlar bu yerda mashhur turizm turlaridir.
Dam olish maskanlari: Ko'l bo'yida ko'plab dam olish maskanlari, mehmonxonalar va restoranlar mavjud bo'lib, ular sizga qulay va yoqimli dam olish imkoniyatini yaratadi.
Toshkentga yaqinligi: Toshkent shahridan Charvoq ko'ligacha bo'lgan masofa taxminan 80 kilometr. Bu esa poytaxt aholisi uchun ajoyib hafta oxiri dam olish joyiga aylantiradi.
Eslatma: Charvoq ko'liga borishdan oldin ob-havo sharoitlari bilan tanishib chiqing va kerakli jihozlar bilan ta'minlangan bo'ling.''',
      rate: '6.8')
];
