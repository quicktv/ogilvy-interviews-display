package models.signals
{
	import org.osflash.signals.ISlot;
	import org.osflash.signals.Signal;
	
	public class ModelProperty extends Signal
	{
		private var _value:*;
		
		public function getValue():* 
		{
			return _value;	
		}
		public function setValue(value:*):void
		{
			dispatch(_value = value);
		}
		
		public function ModelProperty(valueClass:Class, defaultValue:*)
		{
			super(valueClass);
			
			_value = defaultValue;
		}
		
		public override function add(listener:Function):ISlot
		{
			listener(_value);
			
			return super.add(listener);
		}
	}
}