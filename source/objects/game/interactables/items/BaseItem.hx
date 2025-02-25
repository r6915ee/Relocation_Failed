package objects.game.interactables.items;

@:keep
class BaseItem extends FlxBasic {
	public var returnCondition(get, null):Bool;
	public var statusMessage:String = '';
	public var onPickup:() -> Void = () -> {};
	public var parent:Item;
	public var ps:Playstate;
	public var customPickupCallback:() -> Void = null;

	public function new(parent:Item) {
		super();
		this.parent = parent;
		if (parent != null)
			ps = parent.ps;
	}

	public function remove() {
		statusMessage = '';
		onPickup = null;
		customPickupCallback = null;
	}

	function get_returnCondition():Bool
		return true;
}
