package org.osflash.signals
{
	import asunit.asserts.*;
	import org.osflash.signals.error.AmbiguousRelationshipError;

	public class AmbiguousRelationshipTest
	{
		private var target:Object;
		
		private var instance:ISignal;

		override protected function setUp():void
		{
			target = {};
			instance = new Signal(target);
		}

		override protected function tearDown():void
		{
			instance = null;
		}
		
		[Test]
		public function add_then_addOnce_throws_error():void
		{
			instance.add(failIfCalled);
			assertThrows(AmbiguousRelationshipError, function():void { instance.addOnce(failIfCalled); });
		}
		
		[Test]
		public function addOnce_then_add_should_throw_error():void
		{
			instance.addOnce(failIfCalled);
			assertThrows(AmbiguousRelationshipError, function():void { instance.add(failIfCalled); });
		}
		
		[Test]
		public function add_then_add_should_not_throw_error():void
		{
			instance.add(failIfCalled);
			instance.add(failIfCalled);
			assertEquals(1, instance.numListeners);
		}
		
		[Test]
		public function addOnce_then_addOnce_should_not_throw_error():void
		{
			instance.addOnce(failIfCalled);
			instance.addOnce(failIfCalled);
			assertEquals(1, instance.numListeners);
		}
		
		private function failIfCalled():void
		{
			fail("if this listener is called, something horrible is going on");
		}
		
	}
}
