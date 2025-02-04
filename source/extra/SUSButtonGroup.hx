package extra;

import flixel.group.FlxSpriteGroup;

class SUSButtonGroup extends FlxTypedSpriteGroup<SUSButton> {
  public static var lezi:Map<String, SUSButton> = [];

  public override function add(basic:SUSButton, name:String):SUSButton {
    lezi.set(name, basic);
    return super.add(basic);
  }

  public override function remove(basic:SUSButton, name:String, ?splice:Bool = false) {
    lezi.remove(name);
    return super.remove(basic, splice);
  }
}
