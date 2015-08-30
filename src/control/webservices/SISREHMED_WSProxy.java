package control.webservices;

public class SISREHMED_WSProxy implements control.webservices.SISREHMED_WS {
  private String _endpoint = null;
  private control.webservices.SISREHMED_WS sISREHMED_WS = null;
  
  public SISREHMED_WSProxy() {
    _initSISREHMED_WSProxy();
  }
  
  public SISREHMED_WSProxy(String endpoint) {
    _endpoint = endpoint;
    _initSISREHMED_WSProxy();
  }
  
  private void _initSISREHMED_WSProxy() {
    try {
      sISREHMED_WS = (new control.webservices.SISREHMED_WSServiceLocator()).getSISREHMED_WS();
      if (sISREHMED_WS != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)sISREHMED_WS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)sISREHMED_WS)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (sISREHMED_WS != null)
      ((javax.xml.rpc.Stub)sISREHMED_WS)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public control.webservices.SISREHMED_WS getSISREHMED_WS() {
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS;
  }
  
  public java.lang.String login(java.lang.String usuario, java.lang.String pass) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.login(usuario, pass);
  }
  
  public java.lang.String obtenerPacientesQueMasReservan(java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerPacientesQueMasReservan(fechaIn, fechaFin);
  }
  
  public java.lang.String obtenerMedicosMasSolicitados(java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerMedicosMasSolicitados(fechaIn, fechaFin);
  }
  
  public int obtenerPorcentajeOcupacionBox(int idBox, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerPorcentajeOcupacionBox(idBox, fechaIn, fechaFin);
  }
  
  public int obtenerPorcentajeOcupacionMedico(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerPorcentajeOcupacionMedico(idMedico, fechaIn, fechaFin);
  }
  
  public java.lang.String buscarHoraAPSPorEspecialidad(int idEspecialidad, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.buscarHoraAPSPorEspecialidad(idEspecialidad, fechaIn, fechaFin);
  }
  
  public java.lang.String obtenerNombreDeBox(int idBox) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerNombreDeBox(idBox);
  }
  
  public java.lang.String obtenerNombreDeMedico(int idMedico) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerNombreDeMedico(idMedico);
  }
  
  public java.lang.String crearCupo(java.lang.String fecha, java.lang.String hora, java.lang.String aps, java.lang.String idMedico, java.lang.String idBox) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.crearCupo(fecha, hora, aps, idMedico, idBox);
  }
  
  public java.lang.String loginPacienteFacebook(java.lang.String datos) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.loginPacienteFacebook(datos);
  }
  
  public java.lang.String obtenerBoxes() throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerBoxes();
  }
  
  public java.lang.String reservarHoraControl(java.lang.String idshorasMedicas, int idPaciente) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.reservarHoraControl(idshorasMedicas, idPaciente);
  }
  
  public java.lang.String buscarSusHorasMedicas(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.buscarSusHorasMedicas(idMedico, fechaIn, fechaFin);
  }
  
  public java.lang.String buscarHoraAPSPorMedico(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.buscarHoraAPSPorMedico(idMedico, fechaIn, fechaFin);
  }
  
  public java.lang.String obtenerTodosLosPacientes() throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerTodosLosPacientes();
  }
  
  public java.lang.String obtenerEspecialidades() throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerEspecialidades();
  }
  
  public java.lang.String obtenerTodosLosMedicos() throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.obtenerTodosLosMedicos();
  }
  
  public java.lang.String reservarHoraAPS(int idHoraMedica, int idPaciente) throws java.rmi.RemoteException{
    if (sISREHMED_WS == null)
      _initSISREHMED_WSProxy();
    return sISREHMED_WS.reservarHoraAPS(idHoraMedica, idPaciente);
  }
  
  
}