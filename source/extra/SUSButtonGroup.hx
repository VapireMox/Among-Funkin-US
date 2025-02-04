package extra;

import flixel.group.FlxSpriteGroup;

class SUSButtonGroup extends FlxTypedSpriteGroup<SUSButton> {
  public static var lezi:Map<String, SUSButton> = [];

  public override function add(basic:SUSButton, name:String):SUSButton {
    lezi.set(name, basic);
    super.add(basic);
  }
}
