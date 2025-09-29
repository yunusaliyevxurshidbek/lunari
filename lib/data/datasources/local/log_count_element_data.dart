final allSymptoms = [
  {
    'key': 'Headaches',
    'image': 'assets/images/headaches.png',
    'title': 'Headaches',
  },
  {
    'key': 'Insomnia',
    'image': 'assets/images/insomnia.png',
    'title': 'Insomnia',
  },
  {
    'key': 'Breast-Tend',
    'image': 'assets/images/breast_tenderness.png',
    'title': 'Breast-Tend',
  },
  {
    'key': 'Mood-Change',
    'image': 'assets/images/mood_change.png',
    'title': 'Mood Change',
  },
  {
    'key': 'Hot Flashes',
    'image': 'assets/images/hot_flashes.png',
    'title': 'Hot Flashes',
  },
  {
    'key': 'Vaginal Dryness',
    'image': 'assets/images/vaginal_dryness.png',
    'title': 'Vaginal Dryness',
  },
  {
    'key': 'Night Sweats',
    'image': 'assets/images/night_sweats.png',
    'title': 'Night Sweats',
  },
  {
    'key': 'Thinning Hair',
    'image': 'assets/images/thinning_hair.png',
    'title': 'Thinning Hair',
  },
  {
    'key': 'Wight Gain',
    'image': 'assets/images/weight_gain.png',
    'title': 'Weight Gain',
  },
  {
    'key': 'Irregular Period',
    'image': 'assets/images/irregular.png',
    'title': 'Irregular Period',
  },
  {
    'key': 'Memory Problem',
    'image': 'assets/images/memory.png',
    'title': 'Memory Problem',
  },
  {
    'key': 'Joint Pain',
    'image': 'assets/images/joint_pain.png',
    'title': 'Joint Pain',
  },
];

final allMoods = [
  {
    'key': 'Normal',
    'image': 'assets/images/normal.png',
    'title': 'Normal',
  },
  {
    'key': 'Anxious',
    'image': 'assets/images/anxious.png',
    'title': 'Anxious',
  },
  {
    'key': 'Sad',
    'image': 'assets/images/sad.png',
    'title': 'Sad',
  },
  {
    'key': 'Exhausted',
    'image': 'assets/images/exhausted.png',
    'title': 'Exhausted',
  },
  {
    'key': 'Happy',
    'image': 'assets/images/happy.png',
    'title': 'Happy',
  },
  {
    'key': 'Angry',
    'image': 'assets/images/angry.png',
    'title': 'Angry',
  },
  {
    'key': 'Depressed',
    'image': 'assets/images/depressed.png',
    'title': 'Depressed',
  },
  {
    'key': 'Bored',
    'image': 'assets/images/bored.png',
    'title': 'Bored',
  },
  {
    'key': 'In Love',
    'image': 'assets/images/happy.png',
    'title': 'In Love',
  },
  {
    'key': 'Confident',
    'image': 'assets/images/happy.png',
    'title': 'Confident',
  },
  {
    'key': 'Excited',
    'image': 'assets/images/happy.png',
    'title': 'Excited',
  },
  {
    'key': 'Relaxed',
    'image': 'assets/images/happy.png',
    'title': 'Relaxed',
  },
];

final allMedicines = [
  {
    'key': 'Condom',
    'image': 'assets/images/condom.png',
    'title': 'Condom',
  },
  {
    'key': 'Spermicide',
    'image': 'assets/images/spermicide.png',
    'title': 'Spermicide',
  },
  {
    'key': 'Ring',
    'image': 'assets/images/ring.png',
    'title': 'Ring',
  },
  {
    'key': 'Pill',
    'image': 'assets/images/pill.png',
    'title': 'Pill',
  },
  {
    'key': 'IUD',
    'image': 'assets/images/IUD.png',
    'title': 'IUD',
  },
  {
    'key': 'Shot',
    'image': 'assets/images/shot.png',
    'title': 'Shot',
  },
  {
    'key': 'Implant',
    'image': 'assets/images/implant.png',
    'title': 'Implant',
  },
  {
    'key': 'Patch',
    'image': 'assets/images/patch.png',
    'title': 'Patch',
  },
];

Map<String, int> flowCounts = {
  'Light': 0,
  'Medium': 0,
  'Heavy': 0,
  'Disaster': 0,
};

Map<String, int> symptomCounts = {
  'Headaches': 0,
  'Insomnia': 0,
  'Breast-Tend': 0,
  'Mood-Change': 0,
  'Hot Flashes': 0,
  'Vaginal Dryness': 0,
  'Night Sweats': 0,
  'Thinning Hair': 0,
  // ... other symptoms
};

Map<String, int> moodCounts = {
  'Normal': 0,
  'Angry': 0,
  'Happy': 0,
  'Sad': 0,
  'Exhausted': 0,
  'Anxious': 0,
  'Depressed': 0,
  'In Love': 0,
  'Bored': 0,
  // ... other moods
};

Map<String, int> medicineCounts = {
  'Condom': 0,
  'Pill': 0,
  'Spermicide': 0,
  'Ring': 0,
  'IUD': 0,
  'Shot': 0,
  'Implant': 0,
  'Patch': 0,
};