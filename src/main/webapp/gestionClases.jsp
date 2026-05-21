<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Clase"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
    if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Gestión de Clases</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container-fluid py-5 mt-5 px-lg-5">
        <div class="row g-4">
            
            <div class="col-md-2">
                <div class="bg-black p-3 rounded-4 border border-secondary h-100 shadow-lg">
                    <h5 class="text-warning fw-bold mb-4 text-center" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">PANEL ADMIN</h5>
                    <ul class="nav flex-column gap-2 admin-nav">
                        <li class="nav-item">
                            <a href="#" class="nav-link text-white rounded px-3 py-2 btn-outline-secondary text-start"><i class="fa-solid fa-chart-line me-2"></i> Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/GestionSocios" class="nav-link text-white rounded px-3 py-2 btn-outline-secondary text-start"><i class="fa-solid fa-users me-2"></i> Socios</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/GestionClases" class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-md-10">
                
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <a href="javascript:history.back()" class="text-warning text-decoration-none me-3 fs-3" style="transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="fa-solid fa-circle-arrow-left"></i>
                        </a>
                        <h2 style="font-family: 'Anton', sans-serif; letter-spacing: 1px; margin-bottom: 0;">GESTIÓN DE <span class="text-warning">CLASES</span></h2>
                    </div>
                    <button class="btn btn-warning text-dark fw-bold mt-3 mt-md-0 shadow"><i class="fa-solid fa-plus me-2"></i> Nueva Clase</button>
                </div>

                <div class="card bg-black border-secondary shadow-lg rounded-4 overflow-hidden">
                    <div class="card-body p-0 table-responsive">
                        
                        <table class="table table-dark table-hover mb-0 align-middle" style="min-width: 900px;">
                            <thead class="table-secondary text-dark">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Sede</th>
                                    <th>Nombre / Disciplina</th>
                                    <th>Instructor</th>
                                    <th>Hora Inicio</th>
                                    <th>Cupo Max.</th>
                                    <th>Estado</th>
                                    <th class="text-center pe-4">Acciones</th>
                                </tr>
                            </thead>
                            
                            <tbody class="small">
                                <%
                                    List<Clase> listaClases = (List<Clase>) request.getAttribute("listaClases");
                                    List<Sede> listaSedes = (List<Sede>) request.getAttribute("listaSedes");
                                    
                                    if (listaClases != null && !listaClases.isEmpty()) {
                                        for (Clase c : listaClases) {
                                            // Buscar el nombre de la sede
                                            String nombreSede = "No asignada";
                                            if (listaSedes != null) {
                                                for (Sede s : listaSedes) {
                                                    if (s.getIdSede() == c.getIdSede()) {
                                                        nombreSede = s.getNombre();
                                                        break;
                                                    }
                                                }
                                            }
                                %>
                                    <tr>
                                        <td class="text-secondary ps-4">C-<%= String.format("%04d", c.getIdClase()) %></td>
                                        <td><span class="badge bg-dark border border-secondary text-light"><i class="fa-solid fa-location-dot me-1 text-warning"></i> <%= nombreSede %></span></td>
                                        <td class="fw-bold"><%= c.getNombre() %> <span class="badge bg-secondary ms-2" style="font-size: 0.65rem;"><%= c.getTipo() %></span></td>
                                        <td><i class="fa-solid fa-user-tie text-secondary me-2"></i><%= c.getInstructor() %></td>
                                        <td class="text-warning fw-bold"><i class="fa-solid fa-clock me-1"></i> <%= c.getHoraInicio().toString().substring(0, 5) %></td>
                                        <td><%= c.getCupoMaximo() %> pax</td>
                                        <td><span class="badge bg-success">Activa</span></td>
                                        <td class="text-center pe-4">
                                            <button class="btn btn-sm btn-outline-warning py-1 px-2 me-1 rounded-3"><i class="fa-solid fa-pen"></i></button>
                                            <button class="btn btn-sm btn-outline-danger py-1 px-2 rounded-3"><i class="fa-solid fa-trash"></i></button>
                                        </td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-secondary">
                                            <i class="fa-solid fa-calendar-xmark fa-3x mb-3 d-block text-muted"></i>
                                            <h5>No hay clases programadas</h5>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                            
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>