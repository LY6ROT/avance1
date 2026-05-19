<%@page import="com.gymmax.model.Usuario"%>
<%
    // Recuperamos al usuario de la sesión del servidor
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
%>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(0, 0, 0, 0.95); border-bottom: 2px solid #FFD700; padding: 10px 0;">
    <div class="container">
        
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
            <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="GymMax Logo" style="height: 50px; transition: transform 0.3s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#menuNavegacion" style="background-color: #FFD700;">
            <i class="fa-solid fa-bars text-dark"></i>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="menuNavegacion">
            <ul class="navbar-nav align-items-center gap-2 gap-lg-4">
                
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/gimnasios.jsp">Gimnasios</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/Nosotros.jsp">Nosotros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/Contactenos.jsp">Contacto</a>
                </li>

                <% if(user == null) { %>
                    <li class="nav-item mt-3 mt-lg-0">
                        <a href="${pageContext.request.contextPath}/Login.jsp" class="btn fw-bold px-4" style="background-color: #FFD700; color: #000; border-radius: 8px; box-shadow: 0 4px 10px rgba(255, 215, 0, 0.2);">
                            LOGIN
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item mt-3 mt-lg-0 d-flex align-items-center bg-dark px-3 py-2 rounded-pill border border-warning">
                        <span style="color: #FFD700; font-weight: bold; margin-right: 15px; font-size: 0.95rem;">
                            <i class="fa-solid fa-user me-2"></i> Hola, <%= user.getNombre() %>
                        </span>
                        <a href="${pageContext.request.contextPath}/LogoutController" class="btn btn-sm btn-outline-danger fw-bold rounded-pill" style="border-width: 2px;">
                            Salir <i class="fa-solid fa-right-from-bracket ms-1"></i>
                        </a>
                    </li>
                <% } %>
                
            </ul>
        </div>
    </div>
</nav> 