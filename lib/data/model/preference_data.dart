abstract class PreferenceData {}

  class IntData extends PreferenceData {
    final int value;
    IntData(this.value);
  }

  class StringData extends PreferenceData {
    final String value;
    StringData(this.value);
  }

  class BoolData extends PreferenceData {
    final bool value;
    BoolData(this.value);
  }

  class ListData extends PreferenceData {
    final List<String> value;
    ListData(this.value);
  }