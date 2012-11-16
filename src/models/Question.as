package models
{
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	[Bindable] public class Question
	{
		CONFIG::debug {
			private static const logger:ILogger = getLogger(Question);
		}
		
		public var id:int;
		
		public var question:String = "";
		
		public var yes:int = 0;
		
		public var no:int = 0;
		
		public function Question()
		{
		}
		
		public static function fromXML(xml:XML):Question 
		{
			var question:Question = new Question();
			
			question.id = xml.id;
			question.question = xml.question;
			question.yes = xml.yes;
			question.no = xml.no;
			
			return question;
		}
		
		public function updateCountsFrom(other:Question):void 
		{
			question = other.question;
			yes = other.yes;
			no = other.no;
		}
	}
}