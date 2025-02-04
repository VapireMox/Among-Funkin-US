package;

import extra.SUSButton;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3-special";
  
  //星空
  var starrySky:FlxBackdrop;
  var panelBG:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var logo:FlxSprite;

  var buttons:SUSButtonGroup;
  var asChars:Array<FlxSprite>;
  
  override function create() {
    super.create();

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

    blank = new FlxSprite(50, 100).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    add(blank);

    buttons = new FlxTypedSpriteGroup(blank.x, blank.y);
    blank.scrollFactor.set();
    createButtons();
    add(buttons);

    charTopState = new FlxSprite().loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    add(charTopState);

    logo = new FlxSprite().loadGraphic(Paths.image("mainmenu/MainLOGO"));
    logo.scrollFactor.set();

    logo.x = FlxG.width - logo.width;
    add(logo);
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }

  private function createButtons() {
    var buttonNames:Array<String> = ["SM", "FP", "SP"];
    var jiange:Float = 0;

    for(buttonName in buttonNames) {
      var button:SUSButton = new SUSButton(0, 0, Paths.image('mainmenu/${buttonName}Button'));
      button.scrollFactor.set();
      buttons.add(button);
    }
  }
}
