<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page import="com.gymmax.model.Clase"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    // Obtenemos los datos inyectados por el Servlet
    List<Sede> sedes = (List<Sede>) request.getAttribute("sedes");
    List<Clase> clases = (List<Clase>) request.getAttribute("clases");
    Integer cambiosUsados = (Integer) request.getAttribute("cambiosUsados");
    
    if(sedes == null || clases == null) {
        response.sendRedirect("ReservarClase");
        return;
    }
    
    int disponibles = 3 - (cambiosUsados != null ? cambiosUsados : 0);
    boolean limiteAlcanzado = disponibles <= 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>GymMax | Reservar Clase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-4" style="max-width: 600px;">
        
        <div class="d-flex align-items-center mb-4">
            <a href="dashboardSocio.jsp" class="text-white text-decoration-none me-3 fs-5"><i class="fa-solid fa-arrow-left"></i></a>
            <h4 class="mb-0 fw-bold text-warning" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">RESERVAR CLASE</h4>
        </div>

        <% if("limite_sedes".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger bg-transparent border-danger text-danger text-center fw-bold p-2 mb-4" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2"></i> Has alcanzado el límite de 3 reservas en otras sedes por este mes.
            </div>
        <% } %>

        <div class="alert bg-black border <%= limiteAlcanzado ? "border-danger" : "border-warning" %> text-white mb-4 shadow-sm" role="alert">
            <h6 class="fw-bold <%= limiteAlcanzado ? "text-danger" : "text-warning" %> mb-1">
                <i class="fa-solid fa-circle-info me-2"></i> Política de Sedes
            </h6>
            <p class="small mb-2">Tu sede principal es <strong>Lima Centro</strong>. Tienes un límite para tomar clases en otras sedes.</p>
            <div class="d-flex justify-content-between align-items-center bg-dark p-2 rounded">
                <span class="small text-secondary">Cambios disponibles este mes:</span>
                <span class="badge <%= limiteAlcanzado ? "bg-danger" : "bg-warning text-dark" %> fs-6"><%= disponibles %> / 3</span>
            </div>
        </div>

        <h6 class="fw-bold mb-3">Clases disponibles para hoy</h6>
        
        <div class="d-flex flex-column gap-3">
            <% for(Clase c : clases) { 
                boolean esOtraSede = c.getIdSede() != 1;
                boolean bloqueado = esOtraSede && limiteAlcanzado;
                
                // Buscar el nombre de la sede correspondiente
                String nombreSede = "Sede Desconocida";
                for(Sede s : sedes) {
                    if(s.getIdSede() == c.getIdSede()) {
                        nombreSede = s.getNombre();
                        break;
                    }
                }
            %>
                <div class="card bg-black border-secondary clase-card <%= bloqueado ? "opacity-50" : "" %>">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-1">
                                <h6 class="fw-bold mb-0 text-white"><%= c.getNombre() %></h6>
                                <% if(esOtraSede) { %>
                                    <span class="badge bg-secondary" style="font-size: 0.65rem;">Cambio de sede</span>
                                <% } %>
                            </div>
                            <p class="small text-secondary mb-1">
                                <i class="fa-solid fa-clock text-warning me-1"></i> <%= c.getHoraInicio().toString().substring(0, 5) %> 
                                &bull; <i class="fa-solid fa-user-tie text-warning me-1"></i> Prof. <%= c.getInstructor() %>
                            </p>
                            <p class="small text-light mb-1"><i class="fa-solid fa-location-dot text-secondary me-1"></i> <%= nombreSede %></p>
                            <span class="badge bg-success">Cupos: <%= c.getCupoMaximo() %></span>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/ReservarClase" method="POST">
                            <input type="hidden" name="idClase" value="<%= c.getIdClase() %>">
                            <input type="hidden" name="idSedeClase" value="<%= c.getIdSede() %>">
                            <input type="hidden" name="fecha" value="2026-05-21"> <input type="hidden" name="hora" value="<%= c.getHoraInicio() %>">
                            
                            <% if(bloqueado) { %>
                                <button type="button" class="btn btn-danger fw-bold btn-sm px-3 rounded-pill" disabled>Límite superado</button>
                            <% } else { %>
                                <button type="submit" class="btn btn-warning text-dark fw-bold btn-sm px-3 rounded-pill">Reservar</button>
                            <% } %>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>