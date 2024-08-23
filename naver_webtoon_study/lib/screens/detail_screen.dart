import 'package:flutter/material.dart';
import 'package:naver_webtoon_study/services/api_service.dart';

import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 200,
                  height: 350,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        color: Colors.amber.withOpacity(1),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 200,
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                    ),
                    child: Text(widget.thumb),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          getWebtoonDetailInfo(),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          FutureBuilder(
            future: episodes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].date),
                      );
                    },
                  ),
                );
              }
              return const Text("...");
            },
          )
        ],
      ),
    );
  }

  FutureBuilder<WebtoonDetailModel> getWebtoonDetailInfo() {
    return FutureBuilder(
      future: webtoon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${snapshot.data!.genre} / ${snapshot.data!.age}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  snapshot.data!.about,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        return const Text("...");
      },
    );
  }
}
