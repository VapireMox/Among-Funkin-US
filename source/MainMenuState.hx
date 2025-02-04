package;

import extra.SUSButton;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import openfl.util.Assets;
import openfl.util.AssetType;

import hscript.Interp;
import hscript.Parser;

class MainMenuState extends MusicBeatState {
  public static var psychEngineVersion:String = "0.6.3-special";
  
  //星空
  var starrySky:FlxBackdrop;
  var panelBG:FlxSprite;
  var blank:FlxSprite;
  var charTopState:FlxSprite;
  var logo:FlxSprite;

  var buttons:FlxTypedGroup<SUSButton>;
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

    blank = new FlxSprite(-20, 50).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    blank.scale.set(0.4, 0.4);
    blank.updateHitbox();
    add(blank);

    buttons = new FlxTypedGroup<SUSButton>();
    createButtons();
    add(buttons);

    charTopState = new FlxSprite(-1, -45).loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    charTopState.scale.set(0.3, 0.2);
    charTopState.updateHitbox();
    add(charTopState);

    logo = new FlxSprite(0, -40).loadGraphic(Paths.image("mainmenu/MainLOGO"));
    logo.scrollFactor.set();
    logo.scale.set(0.16, 0.16);
    logo.updateHitbox();
    logo.x = FlxG.width - logo.width;
    add(logo);

    var interp:Interp = new Interp();
    interp.variables.set("blank", blank);
    interp.variables.set("buttons", buttons);
    interp.variables.set("charTopState", charTopState);
    var parser:Parser = new Parser();
    interp.execute(parser.parseString(Assets.getText(Paths.getPath("data/mainmenu.hx", TEXT, null))));
  }

  override function update(elapsed:Float) {
    super.update(elapsed);
  }

  private function createButtons() {
    var buttonNames:Array<String> = ["SM", "FP", "SP"];
    var jiange:Float = 0;

    for(num=>buttonName in buttonNames) {
      var susButton:SUSButton = new SUSButton(25, 150, Paths.image('mainmenu/${buttonName}Button'));
      susButton.scale.set(0.35, 0.35);
      susButton.updateHitbox();

      susButton.y += num * susButton.height + jiange;
      add(susButton);
    }
  }
}
