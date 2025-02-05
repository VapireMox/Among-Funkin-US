package extra;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;
import flixel.FlxG;

class SUSButton extends FlxSprite {
  public static var groupName:Array<String> = [""];

  public var defaultScale:FlxPoint = FlxPoint.get(1, 1);

  public var clickCallback:Dynamic = null;

  private var callEffect:CallEffect;

  private var scaleNB:Float = 0.04;
  private var overed:Bool = true;
  private var outed:Bool = false;
  
  public function new(?x:Float = 0, ?y:Float = 0, graphic:FlxGraphicAsset, ?callEffect:CallEffect = NORMAL) {
    super(x, y);

    loadGraphic(graphic);
    this.callEffect = callEffect;
  }

  public override function updateHitbox() {
    defaultScale.set(this.scale.x, this.scale.y);
    super.updateHitbox();
  }

  override function update(elapsed:Float) {
    super.update(elapsed);

    if(overlapFromMouse()) {
      outed = true;
      if(FlxG.mouse.justPressed) {
        onMouseDown(this);
      }
      if(overed) {
        onMouseOver(this);
        overed = false;
      }
    }else {
      overed = true;
      if(outed) {
        onMouseOut(this);
        outed = false;
      }
    }
  }

  private function overlapFromMouse():Bool {
    return (this.x < FlxG.mouse.screenX && this.x + this.width > FlxG.mouse.screenX &&
    this.y < FlxG.mouse.screenY && this.y + this.height > FlxG.mouse.screenY);
  }

  private function onMouseDown(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: defaultScale.x - scaleNB, y: defaultScale.y - scaleNB}, 0.08, {ease: FlxEase.quadIn, onComplete: huiTang});
    }
  }

  private function onMouseOver(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: defaultScale.x + scaleNB, y: defaultScale.y + scaleNB}, 0.12, {ease: FlxEase.circIn});
    }
  }

  private function onMouseOut(obj:FlxSprite) {
    switch(this.callEffect) {
        case NORMAL:
          FlxTween.tween(scale, {x: defaultScale.x, y: defaultScale.y}, 0.12, {ease: FlxEase.circOut});
    }
  }

  private function huiTang(tween:FlxTween) {
    FlxTween.tween(scale, {x: defaultScale.x, y: defaultScale.y}, 0.08, {ease: FlxEase.quadOut, onComplete: clickCallback});
  }
}

enum CallEffect {
  NORMAL;
}
