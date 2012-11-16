package controllers.commands
{
	import models.Question;
	import models.signals.QuestionsChanged;
	
	import mx.collections.IList;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	import org.robotlegs.mvcs.Command;
	
	import qtv.ds.api.IOption;
	import qtv.ds.api.nothing;
	import qtv.ds.api.something;
	import qtv.operations.api.IOperation;
	
	import services.ApplicationService;
	
	public class UpdateAnswersCommand extends Command
	{
		CONFIG::debug {
			private static const logger:ILogger = getLogger(UpdateAnswersCommand);
		}
		
		[Inject] public var service:ApplicationService;
		
		[Inject] public var questionsChanged:QuestionsChanged;
		
		private var _questions:IList;
		
		private function get questions():IList
		{
			return _questions ||= questionsChanged.getValue() as IList;
		}
		
		public function UpdateAnswersCommand()
		{
			super();
		}
		
		public override function execute():void
		{
			service.questions.addCompleteListener(onQuestionsComplete).addErrorListener(onQuestionsError).execute();
		}
		
		private function onQuestionsComplete(o:IOperation):void
		{
			for each (var question:Question in o.result.getValue())
			{
				var oldQuestion:IOption = listHas(question);
				
				if (oldQuestion.isDefined)
				{
					Question(oldQuestion.getValue()).updateCountsFrom(question);
				}
			}
		}
		
		private function onQuestionsError(o:IOperation):void
		{
			
		}
		
		private function listHas(question:Question):IOption
		{
			if (questions.length == 0) return nothing();
			
			for each (var q:Question in questions)
			{
				if (q.id == question.id) return something(q);
			}
			
			return nothing();
		}
	}
}