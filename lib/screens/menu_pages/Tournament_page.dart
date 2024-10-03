import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccerably/controller/Tournament_provider.dart';
import 'package:soccerably/screens/menu_pages/participation_page.dart';

import '../../app_textfieldformfield.dart';
import '../../const.dart';

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  TournamentProvider data = TournamentProvider();

  @override
  void initState() {
    data = context.read<TournamentProvider>();
    load();
    super.initState();
  }

  load() async {
    await data.fetchTournaments();
  }

  void searchByAlphabet(String query, BuildContext context) {
    if (query.isEmpty) {
      data.filteredTournament = List.from(data.originalTournament);
    } else {
      data.filteredTournament = data.originalTournament.where((data) {
        String lowercaseTournament = data.lists.toString().toLowerCase();
        String lowercaseSearchQuery = query.toLowerCase();
        return lowercaseSearchQuery
            .split('')
            .every((letter) => lowercaseTournament.contains(letter));
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlackColor,
      appBar: AppBarWidget(title: "Tournaments", backButton: false),
      body: Consumer<TournamentProvider>(builder: (context, provider, child) {
        return Padding(
          padding: mainPadding,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              AppTextFormField(
                appController: provider.searchController,
                height: 40,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                maxLengthLine: 1,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black45,
                ),
                hintText: "Search",
                onChanged: (query) {
                  setState(() {
                    searchByAlphabet(query!, context);
                  });

                  return;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: LoaderWidget())
                    : provider.filteredTournament.isEmpty
                        ? const Center(
                            child: Text("No Records",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: screenHeight(context) * 0.69,
                              width: double.infinity,
                              child: MainContainer(
                                child: ListView.builder(
                                  itemCount: provider.filteredTournament.length,
                                  itemBuilder: (context, index) {
                                    final tournament =
                                        provider.filteredTournament[index];
                                    return CellContainer(
                                      child: ListTile(
                                        onTap: () {
                                          nextPage(
                                              context,
                                              CountryTournamentPage(
                                                  tour: tournament.lists!));
                                          // showDialog(
                                          //     barrierDismissible: false,
                                          //     context: context,
                                          //     builder: (BuildContext context) =>
                                          //         CustomAlert(
                                          //           dialogueWidget:
                                          //               tournamentPopup(
                                          //             data: tournament,
                                          //           ),
                                          //         ));
                                        },
                                        title: Text('${tournament.lists}'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
              )
            ],
          ),
        );
      }),
    );
  }
}
