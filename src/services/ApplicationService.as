package services
{
	import flash.net.URLVariables;
	
	import operations.HttpOperation;
	
	import qtv.operations.api.IOperation;

	public class ApplicationService
	{
		public function ApplicationService()
		{
		}
		
		public function get questions():IOperation
		{
			return new HttpOperation(new QuestionsResponseProcessor(), "http://localhost:9000/questions/listXML", new URLVariables());
		}
	}
}