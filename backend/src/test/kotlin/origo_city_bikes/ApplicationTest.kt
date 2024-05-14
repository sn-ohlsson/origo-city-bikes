package origo_city_bikes

import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.server.testing.*
import junit.framework.Assert.assertEquals
import org.junit.Test
import origo_city_bikes.plugins.configureRouting

class ApplicationTest {
	@Test
	fun testRoot() = testApplication {
		application {
			configureRouting()
		}
		client.get("/").apply {
			assertEquals(HttpStatusCode.OK, status)
			assertEquals("Hello World!", bodyAsText())
		}
	}
}
