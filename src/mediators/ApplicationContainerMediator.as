package mediators
{
	import controllers.signals.Bootstrap;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.ApplicationContainer;
	
	public class ApplicationContainerMediator extends Mediator
	{
		[Inject] public var view:ApplicationContainer;
		
		[Inject] public var bootstrap:Bootstrap;
		
		public function ApplicationContainerMediator()
		{
			super();
		}
		
		public override function onRegister():void
		{
			bootstrap.dispatch();
		}
		
		public override function onRemove():void
		{
			
		}
	}
}