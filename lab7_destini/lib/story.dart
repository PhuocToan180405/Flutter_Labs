class Story {
  final String storyTitle;
  final String choice1;
  final String choice2;
  final int nextStory1;
  final int nextStory2;

  Story({
    required this.storyTitle,
    required this.choice1,
    required this.choice2,
    this.nextStory1 = 0,
    this.nextStory2 = 0,
  });
}
