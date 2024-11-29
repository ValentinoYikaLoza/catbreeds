import 'package:catbreeds/app/features/home/providers/breed_provider.dart';
import 'package:catbreeds/app/features/home/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final breedState = ref.watch(breedProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          breedState.selectedBreed?.name ?? 'Breed Details',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: breedState.selectedBreed != null
          ? Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      breedState.selectedBreed!.image?.url ??
                          'https://t3.ftcdn.net/jpg/02/61/08/76/240_F_261087622_8eRI0TAwDAyabS1b0Uifx1wKqHzA41r3.jpg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                breedState.selectedBreed!.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colorScheme.onSurface,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Breed Characteristics',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final detail = _details(breedState)[index];
                              return DetailCard(
                                title: detail['title']!,
                                value: detail['value']!,
                              );
                            },
                            childCount: _details(breedState).length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'No Breed Selected',
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  //lista de caracteristicas que se muestran
  List<Map<String, String>> _details(breedState) {
    return [
      {'title': 'Origin', 'value': breedState.selectedBreed!.origin},
      {'title': 'Temperament', 'value': breedState.selectedBreed!.temperament},
      {
        'title': 'Energy Level',
        'value': '${breedState.selectedBreed!.energyLevel}/10'
      },
      {
        'title': 'Affection Level',
        'value': '${breedState.selectedBreed!.affectionLevel}/10'
      },
      {
        'title': 'Life Span',
        'value': "${breedState.selectedBreed!.lifeSpan} years"
      },
      {
        'title': 'Hypoallergenic',
        'value': breedState.selectedBreed!.hypoallergenic == 1 ? 'Yes' : 'No'
      },
      {
        'title': 'Adaptability',
        'value': '${breedState.selectedBreed!.adaptability}/10'
      },
      {
        'title': 'Child Friendly',
        'value': '${breedState.selectedBreed!.childFriendly}/10'
      },
      {
        'title': 'Dog Friendly',
        'value': '${breedState.selectedBreed!.dogFriendly}/10'
      },
      {
        'title': 'Intelligence',
        'value': '${breedState.selectedBreed!.intelligence}/10'
      },
      {
        'title': 'Shedding Level',
        'value': '${breedState.selectedBreed!.sheddingLevel}/10'
      },
      {
        'title': 'Social Needs',
        'value': '${breedState.selectedBreed!.socialNeeds}/10'
      },
      {
        'title': 'Vocalization',
        'value': '${breedState.selectedBreed!.vocalisation}/10'
      },
    ];
  }
}
