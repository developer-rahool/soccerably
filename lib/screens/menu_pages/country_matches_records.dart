import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:soccerably/controller/team_provider.dart';

import '../../app_textfieldformfield.dart';
import '../../const.dart';
import '../../popup/custom_alert.dart';
import '../../popup/country_popup.dart';
import '../../popup/details_page.dart';

class CountryRecordPage extends StatefulWidget {
  String? countryName;
  CountryRecordPage({super.key, this.countryName});

  @override
  State<CountryRecordPage> createState() => _CountryRecordPageState();
}

class _CountryRecordPageState extends State<CountryRecordPage> {
  TeamProvider data = TeamProvider();

  @override
  void initState() {
    data = context.read<TeamProvider>();
    load();
    super.initState();
  }

  load() async {
    data.fetchTeamStatistics(widget.countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlackColor,
      appBar: AppBarWidget(title: "Country Record"),
      body: Consumer<TeamProvider>(builder: (context, provider, child) {
        return Padding(
          padding: mainPadding,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              AppTextFormField(
                appController: provider.searchController,
                height: 40,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                maxLengthLine: 1,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    provider.onPress();
                  },
                ),
                onEditingComplete: () {
                  provider.onPress();
                },
                hintText: "Search by country",
                // onChanged: (query) {
                //   provider.onChanged(query!);

                //   return;
                // },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(' Country: ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(provider.currentTeam,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(' Total Match: ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Text("${provider.totalMatches} ",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: LoaderWidget())
                    : provider.filteredTeam.isEmpty
                        ? const Center(
                            child: Text("No Records",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: screenHeight(context) * 0.68,
                              width: double.infinity,
                              child: MainContainer(
                                child: ListView.builder(
                                  itemCount: provider.filteredTeam.length,
                                  itemBuilder: (context, index) {
                                    var tournament = provider.filteredTeam[index];
                                    return CellContainer(
                                      child: ListTile(
                                        onTap: () {
                                          var text =
                                              "Winning Matches: ${tournament.winningMatches.toString()}, Matches Played: ${tournament.matchesPlayed.toString()}, Tournament: ${tournament.tournament.toString()}";
                                
                                          nextPage(
                                              context,
                                              DetailPage(
                                                child: TeamsPopup(
                                                  data: tournament,
                                                ),
                                                copyWidget: copyText(text),
                                                sharePressed: () {
                                                  Share.share(text);
                                                },
                                              ));
                                        },
                                        title: Text(
                                            'Winning Matches: ${tournament.winningMatches.toString()}\nPlayed Matches: ${tournament.matchesPlayed.toString()}'),
                                        subtitle: Text(
                                            tournament.tournament.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
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
