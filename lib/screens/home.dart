import 'package:assignment/screens/messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var text = "I'm a robust software developer and here is my profiles:";
  var facebookurl = 'https://flutter.io';
  var linkedInUrl = "https://www.linkedin.com/in/harrem-m-jalal-a0a329135/";
  var githubUrl = "https://github.com/Harrem/";
  var instagramUrl = "https://www.instagram.com/harrem_ip.h.c/";

  final Widget githubLogo = SvgPicture.asset(
    'assets/github.svg',
    color: Colors.white,
    width: 25,
  );

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: ClipOval(
                  child: Image.asset(
                    "assets/facebook.png",
                    // "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/129638459/original/a2f7a0cf96e7e8c491b3f1ac4fa7a1588a8273b7/draw-your-profile-picture-with-minimalist-cartoon-style.jpg",
                    width: 150,
                  ),
                ),
              ),
              const Divider(color: Colors.transparent),
              const Text(
                "Harrem",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: GestureDetector(
                  onTap: () => _launchURL(facebookurl),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 43, 146, 255)),
                    child: const ListTile(
                        leading: Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Facebook",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.open_in_new,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              GestureDetector(
                onTap: () => _launchURL(githubUrl),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 61, 61, 61)),
                    child: ListTile(
                        leading: githubLogo,
                        title: const Text(
                          "Github",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.open_in_new,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              GestureDetector(
                onTap: () => _launchURL(linkedInUrl),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 26, 110, 183)),
                    child: const ListTile(
                        leading: Icon(Icons.facebook, color: Colors.white),
                        title: Text("LinkedIn",
                            style: TextStyle(color: Colors.white)),
                        trailing: Icon(Icons.open_in_new, color: Colors.white)),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              GestureDetector(
                onTap: () => _launchURL(instagramUrl),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 255, 88, 177)),
                    child: const ListTile(
                        leading: Icon(Icons.facebook, color: Colors.white),
                        title: Text("Instagram",
                            style: TextStyle(color: Colors.white)),
                        trailing: Icon(Icons.open_in_new, color: Colors.white)),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              const Divider(
                color: Colors.transparent,
              ),
              FractionallySizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.phone, size: 35),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.messenger, size: 35),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MessageScreen()));
                        },
                        icon: const Icon(Icons.message, size: 35),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
