package;

import extra.SUSButton;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import openfl.Assets;

class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3-special";
  
  //星空
  var starrySky:FlxBackdrop;
  var panelBG:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var logo:FlxSprite;

  var buttons:FlxTypedSpriteGroup<SUSButton>;
  var asChars:Array<FlxSprite>;
  
  override function create() {
    super.create();

    if(!FlxG.mouse.visible) FlxG.mouse.visible = true;

    starrySky = new FlxBackdrop(Paths.image("mainmenu/StarrySky"));
    starrySky.setGraphicSize(FlxG.width, FlxG.height);
    starrySky.updateHitbox();
    starrySky.scrollFactor.set();
    add(starrySky);

    panelBG = new FlxSprite().loadGraphic(Paths.image("mainmenu/panelBG"));
    panelBG.setGraphicSize(FlxG.width, FlxG.height);
    panelBG.updateHitbox();
    panelBG.scrollFactor.set();
    add(panelBG);

    blank = new FlxSprite(-25, 150).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    blank.scale.set(0.35, 0.35);
    blank.updateHitbox();
    add(blank);

    buttons = new FlxTypedSpriteGroup<SUSButton>(blank.x, blank.y);
    blank.scrollFactor.set();
    createButtons();
    add(buttons);

    charTopState = new FlxSprite(0, -95).loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    charTopState.scale.set(0.25, 0.25);
    charTopState.updateHitbox();
    add(charTopState);

    logo = new FlxSprite(0, -25).loadGraphic(Paths.image("mainmenu/MainLOGO"));
    logo.scrollFactor.set();
    logo.scale.set(0.16, 0.16);
    logo.updateHitbox();
    logo.x = FlxG.width - logo.width;
    add(logo);
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }

  private function createButtons() {
    var buttonNames:Array<String> = ["SM", "FP", "SP"];
    var jiange:Float = 0;

    for(num=>buttonName in buttonNames) {
      var button:SUSButton = new SUSButton(0, 0, Paths.image('mainmenu/${buttonName}Button'));
      button.scale.set(0.3, 0.3);
      //button.defaultScale.set(button.scale.x, button.scale.y);
      button.updateHitbox();
      button.y += num * button.height + (num != 0 ? 1 : 0);
      button.scrollFactor.set();
      buttons.add(button);
    }
  }
}
