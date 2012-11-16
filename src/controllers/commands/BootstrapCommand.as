package controllers.commands
{
	import models.signals.QuestionsChanged;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import qtv.operations.api.IOperation;
	
	import services.ApplicationService;
	
	public class BootstrapCommand extends Command
	{
		[Inject] public var questionsChanged:QuestionsChanged;
		
		[Inject] public var service:ApplicationService;
		
		public function BootstrapCommand()
		{
			super();
		}
		
		public override function execute():void
		{
			service.questions.addCompleteListener(onQuestionsComplete).addErrorListener(onQuestionsError).execute();
		}
		
		private function onQuestionsComplete(o:IOperation):void
		{
			questionsChanged.setValue(o.result.getOrElse(new ArrayCollection()));
		}
		
		private function onQuestionsError(o:IOperation):void
		{
			
		}
	}
}