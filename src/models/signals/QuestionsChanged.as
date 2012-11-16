package models.signals
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class QuestionsChanged extends ModelProperty
	{
		public function QuestionsChanged()
		{
			super(IList, new ArrayCollection());
		}
	}
}