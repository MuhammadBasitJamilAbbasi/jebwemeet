import 'package:flutter/material.dart';

class InterestModel {
  String? image;
  String? title;

  InterestModel({
    required this.title,
    required this.image,
  });
  InterestModel.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    title = map['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': image,
      'title': title,
    };
  }
  @override
  String toString() {
    return '{title: $title, image: $image,}';
  }
}

List<InterestModel>? topicContents = [
  InterestModel(
    image: '🎨',
    title: 'Art',
  ),
  InterestModel(
    image: '🏀',
    title: 'Basketball',
  ),
  InterestModel(
    image: '🥔',
    title: 'Baking',
    
  ),
  InterestModel(
    image: '🏎',
    title: 'Cars',
    
  ),
  InterestModel(
    image: '🍳',
    title: 'Cooking',
    
  ),
  InterestModel(
    image: '💰',
    title: 'Crypto',
    
  ),
  InterestModel(
    image: '🏕️',
    title: 'Camping & Hiking',
    
  ),
  InterestModel(
    image: '👪',
    title: 'Family',
    
  ),
  InterestModel(
    image: '🍔',
    title: 'Food',
    
  ),
  InterestModel(
    image: '💪',
    title: 'Fitness',
    
  ),
  InterestModel(
    image: '🕹',
    title: 'Gaming',
    
  ),
  InterestModel(
    image: '🧑‍🌾',
    title: 'Gradening',
    
  ),
  InterestModel(
    image: '🥒',
    title: 'Healthy',
    
  ),
  InterestModel(
    image: '🏺',
    title: 'History',
    
  ),
  InterestModel(
    image: '💄',
    title: 'Makeup',
    
  ),
  InterestModel(
    image: '😂',
    title: 'Memes',
    
  ),
  InterestModel(
    image: '🌱',
    title: 'Nature',
    
  ),
  InterestModel(
    image: '⚽',
    title: 'Football',
    
  ),
  InterestModel(
    image: '🎾',
    title: 'Tennis',
    
  ),
];
//
// class TopicModel {
//   String image;
//   String title;
//
//   TopicModel({
//     required this.title,
//     required this.image,
//   });
// }
//
// List<TopicModel> topicsList = [
//   TopicModel(
//     image: '🎨',
//     title: 'Art',
//   ),
//   TopicModel(
//     image: '🏀',
//     title: 'Basketball',
//   ),
//   TopicModel(
//     image: '🥔',
//     title: 'Baking',
//   ),
//   TopicModel(
//     image: '🏎',
//     title: 'Cars',
//   ),
//   TopicModel(
//     image: '🍳',
//     title: 'Cooking',
//   ),
//   TopicModel(
//     image: '🏕️',
//     title: 'Climbing',
//   ),
//   TopicModel(
//     image: '💰',
//     title: 'Crypto',
//   ),
//   TopicModel(
//     image: '🏕️',
//     title: 'Camping & Hiking',
//   ),
//   TopicModel(
//     image: '👪',
//     title: 'Family',
//   ),
//   TopicModel(
//     image: '🍔',
//     title: 'Food',
//   ),
//   TopicModel(
//     image: '💪',
//     title: 'Fitness',
//   ),
//   TopicModel(
//     image: '🕹',
//     title: 'Gaming',
//   ),
//   TopicModel(
//     image: '🧑‍🌾',
//     title: 'Gradening',
//   ),
//   TopicModel(
//     image: '🥒',
//     title: 'Healthy',
//   ),
//   TopicModel(
//     image: '🏺',
//     title: 'History',
//   ),
//   TopicModel(
//     image: '💄',
//     title: 'Makeup',
//   ),
//   TopicModel(
//     image: '😂',
//     title: 'Memes',
//   ),
//   TopicModel(
//     image: '🌱',
//     title: 'Nature',
//   ),
//   TopicModel(
//     image: '🎾',
//     title: 'Tennis',
//   ),
// ];
