import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Userlist extends StatefulWidget {
  @override
  State<Userlist> createState() => _Userlist();
}

class _Userlist extends State<Userlist> {
  List<Map<String, dynamic>> userDataList = [
    {
      "userName": "John Doe",
      "city": "New York",
      "email": "john.doe@example.com",
      "age": 35,
      "isFav": false,
      "extraDetails":
      "John Doe is a software engineer based in New York. He specializes in mobile app development and has a passion for creating intuitive user experiences. In his free time, John enjoys hiking, photography, and exploring the city's diverse culinary scene. He is also a volunteer at local coding bootcamps, mentoring young programmers. John values meaningful connections and is a firm believer in lifelong learning. He enjoys reading about technology trends and traveling to broaden his perspectives. His optimistic and collaborative nature makes him a favorite among his peers. John is driven by a desire to create innovative solutions."
    },
    {
      "userName": "Jane Smith",
      "city": "Los Angeles",
      "email": "jane.smith@example.com",
      "age": 31,
      "isFav": false,
      "extraDetails":
      "Jane Smith is a marketing manager from Los Angeles with a flair for creativity and innovation. She is skilled in brand strategy and digital campaigns, helping businesses grow their online presence. Jane loves art and often visits local galleries to find inspiration for her work. Outside of her profession, she is an avid runner and has completed multiple marathons. Jane is known for her dedication to her goals and her ability to inspire others. She volunteers at animal shelters on weekends and is passionate about sustainability. Her warm personality and leadership qualities make her a valued team member."
    },
    {
      "userName": "Michael Johnson",
      "city": "Chicago",
      "email": "michael.johnson@example.com",
      "age": 39,
      "isFav": false,
      "extraDetails":
      "Michael Johnson is a financial analyst from Chicago who specializes in investment strategies and portfolio management. He has a strong analytical mind and enjoys solving complex financial challenges. Michael is a fitness enthusiast who spends his mornings at the gym and weekends cycling along Lake Michigan. He is also a jazz music aficionado and frequently attends live performances. Michael is a mentor for aspiring financial professionals, sharing his knowledge and experience. He is admired for his strategic thinking and calm demeanor. A family-oriented individual, Michael values spending quality time with loved ones and cherishes his community connections."
    },
    {
      "userName": "Emily Davis",
      "city": "San Francisco",
      "email": "emily.davis@example.com",
      "age": 29,
      "isFav": false,
      "extraDetails":
      "Emily Davis is a graphic designer from San Francisco with a keen eye for detail and creativity. She specializes in user interface design and works with tech startups to enhance their visual branding. Emily loves exploring the city's vibrant art scene and is a member of a local photography club. She is passionate about environmental causes and actively participates in beach clean-up drives. Emily is known for her innovative designs and collaborative work ethic. She enjoys reading fiction and experimenting with new cooking recipes. Her positivity and artistic talent make her a beloved colleague and friend to many."
    },
    {
      "userName": "David Wilson",
      "city": "Seattle",
      "email": "david.wilson@example.com",
      "age": 36,
      "isFav": false,
      "extraDetails":
      "David Wilson is a project manager from Seattle with extensive experience in technology projects. He is a natural problem-solver and excels in coordinating teams to achieve their goals. David enjoys the outdoors and often goes camping in the Pacific Northwest. He is an amateur photographer and loves capturing scenic landscapes. He is actively involved in his community, organizing workshops on time management and leadership skills. David is also a music enthusiast and plays the guitar in his free time. His dedication, strategic mindset, and sense of humor make him a respected professional and a great friend."
    },
    {
      "userName": "Sophia Martinez",
      "city": "Miami",
      "email": "sophia.martinez@example.com",
      "age": 26,
      "isFav": true,
      "extraDetails":
      "Sophia Martinez is a fashion designer from Miami with a passion for sustainable fashion. She creates unique designs that blend modern trends with eco-friendly materials. Sophia enjoys attending fashion shows and collaborating with local artists. In her spare time, she practices yoga and explores new cuisines. She is an advocate for mental health awareness and frequently volunteers at community events. Sophia is admired for her creativity, empathy, and entrepreneurial spirit. She dreams of launching her own fashion brand that promotes ethical practices. Her innovative approach and cheerful personality inspire those around her to think differently and embrace individuality."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profiles Awaiting Marriage Confirmation",
            style: GoogleFonts.b612(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(13, 24, 33, 1),
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(13, 24, 33, 1),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Show Bottom Sheet with Full Info
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: const Color(0xFF1E2A38),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Name
                            Center(
                              child: Text(
                                userDataList[index]["userName"] ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(color: Colors.grey[600], thickness: 1),
                            const SizedBox(height: 10),
                            // Extra Details
                            Text(
                              userDataList[index]["extraDetails"] ?? "No details available.",
                              style: const TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            const SizedBox(height: 20),
                            Divider(color: Colors.grey[600], thickness: 1),
                            const SizedBox(height: 10),
                            // City
                            ListTile(
                              leading: const Icon(Icons.location_city, color: Colors.blueAccent),
                              title: const Text("City", style: TextStyle(color: Colors.grey)),
                              subtitle: Text(
                                userDataList[index]["city"] ?? "N/A",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            // Email
                            ListTile(
                              leading: const Icon(Icons.email, color: Colors.orangeAccent),
                              title: const Text("Email", style: TextStyle(color: Colors.grey)),
                              subtitle: Text(
                                userDataList[index]["email"] ?? "N/A",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            // Age
                            ListTile(
                              leading: const Icon(Icons.timeline, color: Colors.purpleAccent),
                              title: const Text("Age", style: TextStyle(color: Colors.grey)),
                              subtitle: Text(
                                "${userDataList[index]["age"] ?? "N/A"}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            // Favorite Status
                            ListTile(
                              leading: const Icon(Icons.favorite, color: Colors.redAccent),
                              title: const Text("Favorite", style: TextStyle(color: Colors.grey)),
                              subtitle: Text(
                                userDataList[index]["isFav"] ? "Yes" : "No",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Close", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Card(
                        color: const Color(0xFF1E2A38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row for Name and Favorite Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userDataList[index]["userName"] ?? "N/A",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      userDataList[index]["isFav"]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        userDataList[index]["isFav"] =
                                        !userDataList[index]["isFav"];
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Second Row for City, Email, and Age
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // City
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "City",
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          userDataList[index]["city"] ?? "N/A",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Email
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Email",
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          userDataList[index]["email"] ?? "N/A",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Age
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Age",
                                          style: TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                          "${userDataList[index]["age"] ?? "N/A"}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: userDataList.length,
          )

        ],
      ),
    );
  }
}
