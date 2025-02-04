package extra;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.math.FlxPoint;

class SUSButton extends FlxSprite {
  public static var groupName:Array<String> = [""];

  public var defaultScale:FlxPoint = FlxPoint.get(1, 1);

  public var clickCallback:Dynamic = null;

  private var callEffect:CallEffect;

  private var scaleNB:Float = 0.04;
  
  public function new(?x:Float = 0, ?y:Float = 0, ?scaleX:Float = 1, ?scaleY:Float = 1, graphic:FlxGraphicAsset, ?callEffect:CallEffect = NORMAL) {
    super(x, y);

    loadGraphic(graphic);
    scale.set(scaleX, scaleY);
    updateHitbox();
    this.callEffect = callEffect;
    FlxMouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut);
  }

  public override function updateHitbox() {
    defaultScale.set(this.scale.x, this.scale.y);
    super.updateHitbox();
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
