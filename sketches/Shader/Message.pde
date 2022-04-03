class Message {
  float cps;
  float cycle;
  float delta;
  float n;
  int orbit;
  String s;
  float gain;
  float djf;
  int mode;
  float shift;
  
  Message() {
    cps = 0;
    cycle = 0;
    delta = 0;
    n = 0;
    orbit = 0;
    s = "";
    gain = 0;
    djf = 0;
    mode = 0;
    shift = 0;
  }

  Message(OscMessage m) {
    int i;

    for(i = 0; i < m.typetag().length(); ++i) {
      String name = m.get(i).stringValue();
      switch(name) {
        case "cps":
          cps = m.get(i+1).floatValue();
          break;
        case "cycle":
          cycle = m.get(i+1).floatValue();
          break;
        case "delta":
          delta = m.get(i+1).floatValue();
          break;
        case "n":
          n = m.get(i+1).floatValue();
          break;
        case "orbit":
          orbit = m.get(i+1).intValue();
          break;
        case "s":
          s = m.get(i+1).stringValue();
          break;
        case "gain":
          gain = m.get(i+1).floatValue();
          break;
        case "djf":
          djf = m.get(i+1).floatValue();
          break;
        case "mode":
          mode = m.get(i+1).intValue();
          break;
        case "shift":
          shift = m.get(i+1).floatValue();
          break;
      }
      ++i;
    }
  }
}
