package menu;

import menu.intro.Star;
import backend.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import backend.Functions;
import backend.Button;

class MainMenu extends FlxState {
    var Title:FlxText;
    var Title2:FlxText;
    var Suffix:FlxText;

    var versiontext:FlxText;
    var platformText:FlxText;
    var curPlatform:String;

    var Button_Play:Button;
    var BP_text:Txt;
    var Button_Settings:Button;

    var stars:Array<Star> = [];
    var shipCam:FlxCamera;
    var starCam:FlxCamera;
    var ship:FlxSprite;
    var shipGlow:FlxSprite;

    override public function create() {
        starCam = new FlxCamera(0, 0, 1280, 720, 1);
        starCam.bgColor = 0x00000000;
        FlxG.cameras.add(starCam, false);
        shipCam = new FlxCamera(0, 0, 1280, 720, 1);
        shipCam.bgColor = 0x00000000;
        FlxG.cameras.add(shipCam);

        shipCam.flash();
        if (!FlxG.sound.music.playing)
            FlxG.sound.playMusic(Assets.sound('MENU.ogg'));
        //background
        ship = new FlxSprite(0, 0, 'assets/ship.png');
        ship.setGraphicSize(1280, 720);
        ship.updateHitbox();
        ship.antialiasing = false;
        ship.camera = shipCam;
        add(ship);

        //menu title stuff.
        Title2 = new FlxText(0, 170, 0, "", 8, true);
        Title2.setFormat(null, 48, FlxColor.RED, CENTER, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
        Title2.text = "FAILED";
        Title2.screenCenter(X);
        Title2.x = Title2.x + 35;
        Title2.camera = shipCam;
        Title2.antialiasing = false;
        add(Title2);
        
        Title = new FlxText(0, 150, 0, "", 8, true);
        Title.setFormat(null, 48, FlxColor.BLUE, CENTER, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
        Title.text = "RELOCATION";
        Title.screenCenter(X);
        Title.x = Title.x + 35;
        Title.camera = shipCam;
        Title.antialiasing = false;
        add(Title);

        Suffix = new FlxText(0, 0, 0, "", 8, true);
        Suffix.setFormat(null, 24, FlxColor.YELLOW, CENTER, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
        Suffix.text = "TESTING VERSION";
        Suffix.camera = shipCam;
        Suffix.setPosition(Title.x + 250, Title.y - 10);
        Suffix.antialiasing = false;
        add(Suffix);

        //button handling
        Button_Play = new Button('Play!', 560, 280, Assets.image('ButtonTEST'), ()->{ FlxG.switchState(new Playstate()); }, 1, false);
        Button_Play.DaButton.updateHitbox();
        Button_Play.updateTextPosition();
        Button_Play.camera = shipCam;
        add(Button_Play);

        Button_Settings = new Button('Settings', Button_Play.DaButton.x, Button_Play.DaButton.y + 85, Assets.image('ButtonTEST'), 
        ()->{ FlxG.switchState(new menu.Settings()); }, 1, false);
        Button_Settings.DaButton.updateHitbox();
        Button_Settings.updateTextPosition();
        Button_Settings.camera = shipCam;
        add(Button_Settings);

        shipGlow = new FlxSprite(0, 0, 'assets/ship-glow.png');
        shipGlow.setGraphicSize(1280, 720);
        shipGlow.updateHitbox();
        shipGlow.antialiasing = false;
        shipGlow.camera = shipCam;
        add(shipGlow);

        var vingette = new FlxSprite(0, 0, 'assets/Vingette.png');
        vingette.alpha = 0.4;
        vingette.camera = shipCam;
        add(vingette);

        platformText = new FlxText(0, 690, 0, "", 8, true);
        platformText.setFormat(null, 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
        platformText.text = Functions.GetPlatform();
        platformText.camera = shipCam;
        platformText.antialiasing = false;
        add(platformText);

        versiontext = new FlxText(0, 665, 0, "", 8, true);
        versiontext.setFormat(null, 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.NONE, FlxColor.TRANSPARENT, true);
        versiontext.text = "V " + Application.current.meta.get('version');
        versiontext.antialiasing = false;
        versiontext.camera = shipCam;
        add(versiontext);
    }

    override public function update(elapsed:Float) {
            super.update(elapsed);
            shipCam.shake(0.001, 1);
            var star:Star = cast new Star(Std.int(FlxG.width/2), Std.int(FlxG.height/2) - 30, null, false, 0.5).makeGraphic(10, 10);
            star.cameras = [starCam];
            stars.push(star);
            add(star);
            #if !mobile
            if(FlxG.mouse.overlaps(Button_Play))
                {
                    FlxTween.cancelTweensOf(Button_Play.DaButton);
                    FlxTween.cancelTweensOf(Button_Play.DaText);
                    Button_Play.Hover = true;
                    Button_Play.DaButton.updateHitbox();
                    Button_Play.updateTextPosition();
                    FlxTween.tween(Button_Play.DaButton, {"scale.x": 0.8, "scale.y": 0.8, x: FlxG.width/2 - Button_Play.DaButton.width / 2 + 20}, 0.5, {
                        ease: FlxEase.circOut
                    });
                    FlxTween.tween(Button_Play.DaText, {"scale.x": 0.8, "scale.y": 0.8}, 0.5, {
                        ease: FlxEase.circOut
                    });
                }
            else
                {
                    FlxTween.cancelTweensOf(Button_Play.DaButton);
                    FlxTween.cancelTweensOf(Button_Play.DaText);
                    Button_Play.Hover = false;
                    Button_Play.DaButton.updateHitbox();
                    Button_Play.updateTextPosition();
                    FlxTween.tween(Button_Play.DaButton, {"scale.x": 0.6, "scale.y": 0.6, x: FlxG.width/2 - Button_Play.DaButton.width / 2 + 20}, 0.5, {
                        ease: FlxEase.circOut
                    });
                    FlxTween.tween(Button_Play.DaText, {"scale.x": 0.6, "scale.y": 0.6}, 0.5, {
                        ease: FlxEase.circOut
                    });
                }

            if(FlxG.mouse.overlaps(Button_Settings))
                {
                    FlxTween.cancelTweensOf(Button_Settings.DaButton);
                    FlxTween.cancelTweensOf(Button_Settings.DaText);
                    Button_Settings.Hover = true;
                    FlxTween.tween(Button_Settings.DaButton, {"scale.x": 0.6, "scale.y": 0.6, x: FlxG.width/2 - Button_Settings.DaButton.width / 2 + 20}, 0.5, {
                        ease: FlxEase.circOut
                    });
                    Button_Settings.DaButton.updateHitbox();
                    Button_Settings.updateTextPosition();
                    FlxTween.tween(Button_Settings.DaText, {"scale.x": 0.6, "scale.y": 0.6}, 0.5, {
                        ease: FlxEase.circOut
                    });
                }
            else
                {
                    FlxTween.cancelTweensOf(Button_Settings.DaButton);
                    FlxTween.cancelTweensOf(Button_Settings.DaText);
                    Button_Settings.Hover = false;
                    Button_Settings.DaButton.updateHitbox();
                    Button_Settings.updateTextPosition();
                    FlxTween.tween(Button_Settings.DaButton, {"scale.x": 0.5, "scale.y": 0.5, x: FlxG.width/2 - Button_Settings.DaButton.width / 2 + 20}, 0.5, {
                        ease: FlxEase.circOut
                    });
                    FlxTween.tween(Button_Settings.DaText, {"scale.x": 0.5, "scale.y": 0.5}, 0.5, {
                        ease: FlxEase.circOut
                    });
                }
            #end
    }
}