<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Nuestras Sedes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/gimnasios.css">
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-5">
        <div class="text-center mb-4">
            <h1 style="font-family: 'Anton', sans-serif; font-size: 3.5rem; letter-spacing: 1px;">NUESTRAS <span class="text-warning">SEDES</span></h1>
            <p class="text-secondary">Encuentra el centro GymMax ideal para ti y empieza a entrenar.</p>
        </div>

        <div class="row justify-content-center mb-5">
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/Gimnasios" method="GET" class="input-group">
                    <input type="text" name="txtBuscar" class="form-control bg-black text-white border-secondary shadow-none px-4" 
                           placeholder="Buscar por nombre o distrito (Ej. Miraflores)..." 
                           value="<%= request.getAttribute("busqueda") != null ? request.getAttribute("busqueda") : "" %>" style="border-radius: 8px 0 0 8px;">
                    <button class="btn btn-warning text-dark fw-bold px-4" type="submit" style="border-radius: 0 8px 8px 0;">
                        <i class="fa-solid fa-magnifying-glass"></i> Buscar
                    </button>
                </form>
                <% if(request.getAttribute("busqueda") != null) { %>
                    <div class="text-center mt-2">
                        <a href="${pageContext.request.contextPath}/Gimnasios" class="text-warning small text-decoration-none"><i class="fa-solid fa-arrow-rotate-left"></i> Limpiar búsqueda y ver todos</a>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="row g-4">
            <%
                List<Sede> lista = (List<Sede>) request.getAttribute("sedes");
                
                if (lista == null) {
            %>
                <div class="col-12 text-center py-5">
                    <i class="fa-solid fa-triangle-exclamation fa-3x text-danger mb-3"></i>
                    <p class="text-danger fw-bold">Error en la transferencia de datos. Por favor, usa el menú superior para recargar.</p>
                </div>
            <%
                } else if (lista.isEmpty()) {
            %>
                <div class="col-12 text-center py-5">
                    <i class="fa-solid fa-folder-open fa-3x text-secondary mb-3"></i>
                    <p class="text-secondary">No se encontraron gimnasios que coincidan con tu búsqueda.</p>
                </div>
            <%
                } else {
                    for (Sede s : lista) {
            %>
                <div class="col-md-4">
                    <div class="card bg-black border-secondary text-white h-100 shadow-lg d-flex flex-column" style="border-radius: 15px; overflow: hidden;">
                        
                        <div style="height: 200px; width: 100%; overflow: hidden; background-color: #222;">
                            <img src="<%= s.getImagenUrl() != null ? s.getImagenUrl() : "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600" %>" 
                                 alt="<%= s.getNombre() %>" style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s;" 
                                 onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                        </div>

                        <div class="p-4 d-flex flex-column flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h4 class="fw-bold text-warning mb-0"><%= s.getNombre() %></h4>
                                <span class="badge bg-dark border border-warning text-warning px-2 py-1 small"><%= s.getDistrito() %></span>
                            </div>
                            
                            <p class="text-secondary small flex-grow-1 mb-3">
                                <%= s.getDescripcion() != null && s.getDescripcion().length() > 95 ? s.getDescripcion().substring(0, 95) + "..." : s.getDescripcion() %>
                            </p>
                            
                            <div class="mb-3 small text-light">
                                <div class="mb-1"><i class="fa-solid fa-location-dot text-secondary me-2"></i> <%= s.getDireccion() %></div>
                                <div><i class="fa-solid fa-clock text-secondary me-2"></i> <%= s.getHoraApertura().toString().substring(0, 5) %> AM - <%= s.getHoraCierre().toString().substring(0, 5) %> PM</div>
                            </div>
                            
                            <div class="pt-3 border-top border-secondary d-flex justify-content-between align-items-center">
                                <span class="small text-secondary"><i class="fa-solid fa-users me-1"></i> Capacidad: <%= s.getCapacidad() %></span>
                                <a href="${pageContext.request.contextPath}/SedeDetalle?id=<%= s.getIdSede() %>" class="btn btn-sm btn-outline-warning fw-bold px-3" style="border-radius: 8px;">Ver Detalle</a>
                            </div>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>