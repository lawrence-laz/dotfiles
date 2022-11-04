# Clean BDD test with events


public class BeerShipmentTest : AggregateTest<BeerShipment>
{
    [Fact]
    void WhenBoxIsComplete_ShipmentCanSend()
    {
        var shipmentId = Guid.NewGuid();

        Given(
            new ShipmentCreated(shipmentId),
            new BeerAdded("Some beer"),
            new ShipmentLabelAdded("Trackingnumber123")
        );

        When(new SendBeers());

        Expect(new BeerSent(shipmentId));
    }
}
