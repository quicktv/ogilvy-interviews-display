package services
{
	import models.Question;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import operations.IResponseProcessor;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import qtv.ds.api.IOption;
	import qtv.ds.api.nothing;
	import qtv.ds.api.something;
	
	public class QuestionsResponseProcessor implements IResponseProcessor
	{
		CONFIG::debug {
			private static const logger:ILogger = getLogger(QuestionsResponseProcessor);
		}
		
		public function QuestionsResponseProcessor()
		{
			
		}
		
		public function process(value:*):*
		{
			var resp:XML = new XML(value);
			
			CONFIG::debug {
				logger.debug(resp.toString());
			}
			
			var list:IList = new ArrayCollection();
			
			for each (var questionXML:XML in resp.descendants("models.Question"))
			{
				list.addItem(Question.fromXML(questionXML));
			}
			
			return list;
		}
	}
}