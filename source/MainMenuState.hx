package;

import extra.SUSButton;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import openfl.utils.Assets;
import openfl.utils.AssetType;

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

    blank = new FlxSprite(-65, 75).loadGraphic(Paths.image("mainmenu/blank"));
    blank.scrollFactor.set();
    blank.scale.set(0.34, 0.34);
    blank.updateHitbox();
    add(blank);

    buttons = new FlxTypedGroup<SUSButton>();
    createButtons();
    add(buttons);

    charTopState = new FlxSprite(-4, -51).loadGraphic(Paths.image("mainmenu/CharTopState"));
    charTopState.scrollFactor.set();
    charTopState.scale.set(0.262, 0.2);
    charTopState.updateHitbox();
    add(charTopState);

    logo = new FlxSprite(0, -40).loadGraphic(Paths.image("mainmenu/MainLOGO"));
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
    var buttonNames:Array<String> = ["SM", "FP", "SP", "PE", "CM", "OS", "CS", "LE"];
    var jiange:Float = -7.5;

    for(num=>buttonName in buttonNames) {
      var susButton:SUSButton = new SUSButton(35, 162, Paths.image('mainmenu/${buttonName}Button'));
      susButton.scale.set(0.33, 0.33);
      susButton.updateHitbox();

      susButton.y += num * (num > 0 ? buttons.members[num - 1].height : 0) + (num != 0 ? jiange : 0);
      if(num >= buttonNames.indexOf("PE")) {
        if(num == buttonNames.indexOf("PE")) susButton.y += 40;
        else susButton.y -= 10;

        if(num >= buttonNames.indexOf("CS")) {
          switch(buttonName) {
              case "CS": susButton.x -= susButton.width / 2;
              case "LE":
                susButton.x += susButton.width / 2;
                susButton.y = buttons.members[num - 1].y;
          }
        }
      }

      buttons.add(susButton);

      susButton.clickCallback = () -> {
        switch(buttonName) {
          case "SM":
            MusicBeatState.switchState(new StoryMenuState());
          case "FP":
            MusicBeatState.switchState(new FreeplayState());
          case "OS":
            MusicBeatState.switchState(new options.OptionsState());
          case "LE":
            MusicBeatState.switchState(new TitleState());
          case "CS":
            MusicBeatState.switchState(new CreditsState());
          default: 
            lime.app.Application.current.window.alert("Feature Not Free", "error");
        }
      };
    }
  }
}
