import 'package:xpert_flutter/src/features/cat/domain/entities/cat_entity.dart';

class CatModel extends CatEntity {
  CatModel({
    required super.id,
    required super.name,
    required super.temperament,
    required super.origin,
    required super.countryCodes,
    required super.countryCode,
    required super.description,
    required super.lifeSpan,
    required super.indoor,
    required super.adaptability,
    required super.affectionLevel,
    required super.childFriendly,
    required super.dogFriendly,
    required super.energyLevel,
    required super.grooming,
    required super.healthIssues,
    required super.intelligence,
    required super.sheddingLevel,
    required super.socialNeeds,
    required super.strangerFriendly,
    required super.vocalisation,
    required super.experimental,
    required super.hairless,
    required super.natural,
    required super.rare,
    required super.rex,
    required super.suppressedTail,
    required super.shortLegs,
    required super.hypoallergenic,
    required super.wikipediaUrl,
    required super.referenceImageId,
    required super.weight,
    super.lap,
    super.altNames,
    super.cfaUrl,
    super.vetstreetUrl,
    super.vcahospitalsUrl,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      name: json['name'],
      temperament: json['temperament'],
      origin: json['origin'],
      countryCodes: json['country_codes'],
      countryCode: json['country_code'],
      description: json['description'],
      lifeSpan: json['life_span'],
      indoor: json['indoor'],
      adaptability: json['adaptability'],
      affectionLevel: json['affection_level'],
      childFriendly: json['child_friendly'],
      dogFriendly: json['dog_friendly'],
      energyLevel: json['energy_level'],
      grooming: json['grooming'],
      healthIssues: json['health_issues'],
      intelligence: json['intelligence'],
      sheddingLevel: json['shedding_level'],
      socialNeeds: json['social_needs'],
      strangerFriendly: json['stranger_friendly'],
      vocalisation: json['vocalisation'],
      experimental: json['experimental'],
      hairless: json['hairless'],
      natural: json['natural'],
      rare: json['rare'],
      rex: json['rex'],
      suppressedTail: json['suppressed_tail'],
      shortLegs: json['short_legs'],
      hypoallergenic: json['hypoallergenic'],
      wikipediaUrl: json['wikipedia_url'] ?? '',
      referenceImageId: json['reference_image_id'] ?? '',
      weight: CatWeightEntity(
        imperial: json['weight']['imperial'],
        metric: json['weight']['metric'],
      ),
      lap: json['lap'],
      altNames: json['alt_names'],
      cfaUrl: json['cfa_url'],
      vetstreetUrl: json['vetstreet_url'],
      vcahospitalsUrl: json['vcahospitals_url'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CatImageModel extends CatImageEntity {
  CatImageModel({
    required super.height,
    required super.id,
    required super.url,
    required super.width,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(
      height: json['height'],
      id: json['id'],
      url: json['url'],
      width: json['width'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
