import 'package:flutter/material.dart';

class TopicsModel extends ChangeNotifier {
  String image;
  String title;
  bool isSeleted;

  TopicsModel({
    required this.title,
    required this.image,
    required this.isSeleted,
  });
}

List<TopicsModel> topicContents = [
  TopicsModel(
    image: '🎨',
    title: 'Art',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏀',
    title: 'Basketball',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🥔',
    title: 'Baking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏎',
    title: 'Cars',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🍳',
    title: 'Cooking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💰',
    title: 'Crypto',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏕️',
    title: 'Camping & Hiking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '👪',
    title: 'Family',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🍔',
    title: 'Food',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💪',
    title: 'Fitness',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🕹',
    title: 'Gaming',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🧑‍🌾',
    title: 'Gradening',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🥒',
    title: 'Healthy',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏺',
    title: 'History',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💄',
    title: 'Makeup',
    isSeleted: false,
  ),
  TopicsModel(
    image: '😂',
    title: 'Memes',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🌱',
    title: 'Nature',
    isSeleted: false,
  ),
  TopicsModel(
    image: '⚽',
    title: 'Football',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🎾',
    title: 'Tennis',
    isSeleted: false,
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
