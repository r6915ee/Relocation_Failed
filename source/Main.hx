package;

class Main extends Sprite{
    public function new() {
        super();
        addChild(new FlxGame(0, 0, menu.MainMenu));
    }
}