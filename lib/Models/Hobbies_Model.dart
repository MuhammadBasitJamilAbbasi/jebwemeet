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
    image: '🍔',
    title: 'Food',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🔬',
    title: 'Science',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💪',
    title: 'Fitness',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🍳',
    title: 'Cooking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🥑',
    title: 'Vegaterian food',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🌱',
    title: 'Nature',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🕹',
    title: 'Gaming',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🥒',
    title: 'Healthy',
    isSeleted: false,
  ),
  TopicsModel(
    image: '📖',
    title: 'Learn something',
    isSeleted: false,
  ),
  TopicsModel(
    image: '👽',
    title: 'Space',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏎',
    title: 'Cars & motor vehicles',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🎨',
    title: 'Art',
    isSeleted: false,
  ),
  TopicsModel(
    image: '📰',
    title: 'News',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏺',
    title: 'History',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏺',
    title: 'History',
    isSeleted: false,
  ),
  TopicsModel(
    image: '⚽',
    title: 'Soccer',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🍔',
    title: 'Climbing',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏀',
    title: 'Basketball',
    isSeleted: false,
  ),
  TopicsModel(
    image: '👪',
    title: 'Family',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💰',
    title: 'Crypto',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💰',
    title: 'Crypto',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🧑‍🌾',
    title: 'Gradening',
    isSeleted: false,
  ),
  TopicsModel(
    image: '💄',
    title: 'Makeup',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🥔',
    title: 'Baking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🎾',
    title: 'Tennis',
    isSeleted: false,
  ),
  TopicsModel(
    image: '🏕️',
    title: 'Camping & Hiking',
    isSeleted: false,
  ),
  TopicsModel(
    image: '😂',
    title: 'Memes',
    isSeleted: false,
  ),
];

class TopicModel {
  String image;
  String title;

  TopicModel({
    required this.title,
    required this.image,
  });
}

List<TopicModel> topicsList = [
  TopicModel(
    image: '🍔',
    title: 'Food',
  ),
  TopicModel(
    image: '🔬',
    title: 'Science',
  ),
  TopicModel(
    image: '💪',
    title: 'Fitness',
  ),
  TopicModel(
    image: '🍳',
    title: 'Cooking',
  ),
  TopicModel(
    image: '🥑',
    title: 'Vegaterian food',
  ),
  TopicModel(
    image: '🌱',
    title: 'Nature',
  ),
  TopicModel(
    image: '🕹',
    title: 'Gaming',
  ),
  TopicModel(
    image: '🥒',
    title: 'Healthy',
  ),
  TopicModel(
    image: '📖',
    title: 'Learn something',
  ),
  TopicModel(
    image: '👽',
    title: 'Space',
  ),
  TopicModel(
    image: '🏎',
    title: 'Cars & motor vehicles',
  ),
  TopicModel(
    image: '🎨',
    title: 'Art',
  ),
  TopicModel(
    image: '📰',
    title: 'News',
  ),
  TopicModel(
    image: '🏺',
    title: 'History',
  ),
  TopicModel(
    image: '🏺',
    title: 'History',
  ),
  TopicModel(
    image: '⚽',
    title: 'Soccer',
  ),
  TopicModel(
    image: '🍔',
    title: 'Climbing',
  ),
  TopicModel(
    image: '🏀',
    title: 'Basketball',
  ),
  TopicModel(
    image: '👪',
    title: 'Family',
  ),
  TopicModel(
    image: '💰',
    title: 'Crypto',
  ),
  TopicModel(
    image: '💰',
    title: 'Crypto',
  ),
  TopicModel(
    image: '🧑‍🌾',
    title: 'Gradening',
  ),
  TopicModel(
    image: '💄',
    title: 'Makeup',
  ),
  TopicModel(
    image: '🥔',
    title: 'Baking',
  ),
  TopicModel(
    image: '🎾',
    title: 'Tennis',
  ),
  TopicModel(
    image: '🏕️',
    title: 'Camping & Hiking',
  ),
  TopicModel(
    image: '😂',
    title: 'Memes',
  ),
];
