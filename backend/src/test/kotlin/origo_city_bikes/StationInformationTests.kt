package origo_city_bikes

import junit.framework.TestCase.assertEquals
import kotlinx.serialization.json.Json
import org.junit.Test
import origo_city_bikes.models.StationInformation


class StationInformationTests {

	@Test
	fun `test deserialization of StationInformation`() {
		val jsonString = """
            {
                "last_updated": 1716131685,
                "ttl": 15,
                "version": "2.3",
                "data": {
                    "stations": [
                        {
                            "station_id": "4683",
                            "name": "Valle Vision",
                            "address": "Valle Vision",
                            "cross_street": "Valle",
                            "lat": 59.9160648366328,
                            "lon": 10.8071776063118,
                            "is_virtual_station": false,
                            "capacity": 21,
                            "station_area": {
                                "type": "MultiPolygon",
                                "coordinates": [
                                    [
                                        [
                                            [10.8069483060232, 59.916136147566],
                                            [10.8069375470888, 59.9160359898528],
                                            [10.8074570499233, 59.915989763114],
                                            [10.8075031596434, 59.916093773186],
                                            [10.8069483060232, 59.916136147566]
                                        ]
                                    ]
                                ]
                            },
                            "rental_uris": {
                                "android": "oslobysykkel://stations/4683",
                                "ios": "oslobysykkel://stations/4683"
                            }
                        }
                    ]
                }
            }
        """.trimIndent()

		val stationInformation = Json.decodeFromString<StationInformation>(jsonString)

		assertEquals(1716131685, stationInformation.lastUpdated)
		assertEquals(15, stationInformation.ttl)
		assertEquals("2.3", stationInformation.version)
		assertEquals(1, stationInformation.data.stations.size)

		val station = stationInformation.data.stations.first()
		assertEquals("4683", station.stationID)
		assertEquals("Valle Vision", station.name)
		assertEquals("Valle Vision", station.address)
		assertEquals("Valle", station.crossStreet)
		assertEquals(59.9160648366328, station.lat)
		assertEquals(10.8071776063118, station.lon)
		assertEquals(false, station.isVirtualStation)
		assertEquals(21, station.capacity)
		assertEquals("MultiPolygon", station.stationArea.type)
		assertEquals(1, station.stationArea.coordinates.size)
		assertEquals(1, station.stationArea.coordinates[0].size)
		assertEquals(5, station.stationArea.coordinates[0][0].size)
		assertEquals("oslobysykkel://stations/4683", station.rentalUris.android)
		assertEquals("oslobysykkel://stations/4683", station.rentalUris.ios)
	}
}