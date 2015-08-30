/**
 * SISREHMED_WS.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package control.webservices;

public interface SISREHMED_WS extends java.rmi.Remote {
    public java.lang.String login(java.lang.String usuario, java.lang.String pass) throws java.rmi.RemoteException;
    public java.lang.String obtenerPacientesQueMasReservan(java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public java.lang.String obtenerMedicosMasSolicitados(java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public int obtenerPorcentajeOcupacionBox(int idBox, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public int obtenerPorcentajeOcupacionMedico(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public java.lang.String buscarHoraAPSPorEspecialidad(int idEspecialidad, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public java.lang.String obtenerNombreDeBox(int idBox) throws java.rmi.RemoteException;
    public java.lang.String obtenerNombreDeMedico(int idMedico) throws java.rmi.RemoteException;
    public java.lang.String crearCupo(java.lang.String fecha, java.lang.String hora, java.lang.String aps, java.lang.String idMedico, java.lang.String idBox) throws java.rmi.RemoteException;
    public java.lang.String loginPacienteFacebook(java.lang.String datos) throws java.rmi.RemoteException;
    public java.lang.String obtenerBoxes() throws java.rmi.RemoteException;
    public java.lang.String reservarHoraControl(java.lang.String idshorasMedicas, int idPaciente) throws java.rmi.RemoteException;
    public java.lang.String reservarHoraAPS(int idHoraMedica, int idPaciente) throws java.rmi.RemoteException;
    public java.lang.String buscarSusHorasMedicas(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public java.lang.String buscarHoraAPSPorMedico(int idMedico, java.lang.String fechaIn, java.lang.String fechaFin) throws java.rmi.RemoteException;
    public java.lang.String obtenerTodosLosPacientes() throws java.rmi.RemoteException;
    public java.lang.String obtenerEspecialidades() throws java.rmi.RemoteException;
    public java.lang.String obtenerTodosLosMedicos() throws java.rmi.RemoteException;
}
