package prueba;

import static org.junit.Assert.assertTrue;

import java.rmi.RemoteException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.junit.Test;

import control.webservices.SISREHMED_WS;
import control.webservices.SISREHMED_WSProxy;

public class PruebasJUnit {

	@Test
	public void test() throws RemoteException {
		SISREHMED_WS ws = new SISREHMED_WSProxy();
		String respuesta = ws.obtenerEspecialidades();
		Object obj=JSONValue.parse(respuesta);
		JSONObject jo = (JSONObject)obj;
		JSONArray array = (JSONArray)jo.get("especialidades");
		JSONObject actual = (JSONObject)array.get(0);
		System.out.println(actual.get("nombre"));
		assertTrue(respuesta!=null);
	}

}
