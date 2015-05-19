/**
 * SISREHMED_WSServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package control.webservices;

public class SISREHMED_WSServiceLocator extends org.apache.axis.client.Service implements control.webservices.SISREHMED_WSService {

    public SISREHMED_WSServiceLocator() {
    }


    public SISREHMED_WSServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SISREHMED_WSServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SISREHMED_WS
    private java.lang.String SISREHMED_WS_address = "http://localhost:8080/SISREHMED-Business/services/SISREHMED_WS";

    public java.lang.String getSISREHMED_WSAddress() {
        return SISREHMED_WS_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SISREHMED_WSWSDDServiceName = "SISREHMED_WS";

    public java.lang.String getSISREHMED_WSWSDDServiceName() {
        return SISREHMED_WSWSDDServiceName;
    }

    public void setSISREHMED_WSWSDDServiceName(java.lang.String name) {
        SISREHMED_WSWSDDServiceName = name;
    }

    public control.webservices.SISREHMED_WS getSISREHMED_WS() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SISREHMED_WS_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSISREHMED_WS(endpoint);
    }

    public control.webservices.SISREHMED_WS getSISREHMED_WS(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            control.webservices.SISREHMED_WSSoapBindingStub _stub = new control.webservices.SISREHMED_WSSoapBindingStub(portAddress, this);
            _stub.setPortName(getSISREHMED_WSWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSISREHMED_WSEndpointAddress(java.lang.String address) {
        SISREHMED_WS_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (control.webservices.SISREHMED_WS.class.isAssignableFrom(serviceEndpointInterface)) {
                control.webservices.SISREHMED_WSSoapBindingStub _stub = new control.webservices.SISREHMED_WSSoapBindingStub(new java.net.URL(SISREHMED_WS_address), this);
                _stub.setPortName(getSISREHMED_WSWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("SISREHMED_WS".equals(inputPortName)) {
            return getSISREHMED_WS();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://webservices.control", "SISREHMED_WSService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://webservices.control", "SISREHMED_WS"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SISREHMED_WS".equals(portName)) {
            setSISREHMED_WSEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
