<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.sql.DriverManager,java.sql.SQLException" %>
<%@ page import="java.sql.Date,java.sql.Time,java.sql.Timestamp,java.time.LocalDate,java.time.LocalTime,java.time.LocalDateTime,java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/Style.css">
</head>
<body>

    <nav>
        <ul>
            <li><a href="#section1">Section 1</a></li>
            <li><a href="#section2">Section 2</a></li>
            <li><a href="#section3">Section 3</a></li>
        </ul>
    </nav>

    <section id="section1">
    <h2>Contact Information</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Currency</th>
            </tr>
            <tr>
                <td>Sheran Randika</td>
                <td>sheran@gmail.com</td>
                <td>(070) 570-4651</td>
                <td>LKR</td>
            </tr>
        </table>
    </section>

    <section id="section2">
    <h2>Vehicle Reservation Form</h2>
         <form id="reservationForm"  method="post">

            <label for="location">Location:</label>
            <select id="location" name="location" required>
                <option value="" disabled selected>Select your district</option>
                <option value="Colombo">Colombo</option>
                <option value="Gampaha">Gampaha</option>
                <option value="Kalutara">Kalutara</option>
                <option value="Kandy">Kandy</option>
                <option value="Matale">Matale</option>
                <option value="Nuwara Eliya">Nuwara Eliya</option>
                <option value="Galle">Galle</option>
                <option value="Matara">Matara</option>
                <option value="Hambantota">Hambantota</option>
                <option value="Jaffna">Jaffna</option>
                <option value="Vavuniya">Vavuniya</option>
                <option value="Mannar">Mannar</option>
                <option value="Mullaitivu">Mullaitivu</option>
                <option value="Batticaloa">Batticaloa</option>
                <option value="Ampara">Ampara</option>
                <option value="Trincomalee">Trincomalee</option>
                <option value="Kurunegala">Kurunegala</option>
                <option value="Puttalam">Puttalam</option>
                <option value="Anuradhapura">Anuradhapura</option>
                <option value="Polonnaruwa">Polonnaruwa</option>
                <option value="Badulla">Badulla</option>
                <option value="Monaragala">Monaragala</option>
                <option value="Ratnapura">Ratnapura</option>
                <option value="Kegalle">Kegalle</option>
            </select>

            <label for="mileage">Mileage:</label>
            <input type="number" id="mileage" name="mileage" required>

            <label for="dateTime">Date:</label>
            <input type="date" id="date" name="date" required>
			
			<label for="time">Time:</label>
            <input type="time" id="time" name="time" required>
			
			
            <label for="vehicleType">Vehicle Type:</label>
            <select id="vehicleType" name="vehicleType" required>
                <option value="sedan">Sedan</option>
                <option value="suv">SUV</option>
                <option value="truck">Truck</option>
            </select>

            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="4"></textarea>

            <input type="submit" value="Submit" name="submit">
        </form>
    </section>

    <section id="section3">
    <button>Show details</button>
     <div id="reservationInfo">
            <h2>Your Reservation Information</h2>
            <p><strong>Location:</strong> <span id="infoLocation"></span></p>
            <p><strong>Mileage:</strong> <span id="infoMileage"></span></p>
            <p><strong>Date:</strong> <span id="infoDate"></span></p>
            <p><strong>Time:</strong> <span id="infoTime"></span></p>
            <p><strong>Vehicle Type:</strong> <span id="infoVehicleType"></span></p>
            <p><strong>Message:</strong> <span id="infoMessage"></span></p>
        </div>
    </section>
    
    <%
 // JDBC URL, username, and password of MySQL server
    String url = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
    String user = "isec";
    String password = "EUHHaYAmtzbv";
    if(request.getParameter("submit")!= null){
		 // Retrieve form parameters
		    String location = request.getParameter("location");
		    int mileage = Integer.parseInt(request.getParameter("mileage"));
		    
		 // Parse date
		    Date date = Date.valueOf(LocalDate.parse(request.getParameter("date")));

		    // Parse time
		    Time time = Time.valueOf(LocalTime.parse(request.getParameter("time")));
		    String vehicleType = request.getParameter("vehicleType");
		    String message = request.getParameter("message");
		
		
		    Connection connection = null;
		    try {
		        // Establish the connection
		        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL JDBC driver
		        connection = DriverManager.getConnection(url, user, password);
		        if(connection != null){
		        	System.out.println("Database connection is successfull");
		        	
		        }
		
		        // Insert data into the database
		         String sql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
             
		        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
		        	preparedStatement.setDate(1, new java.sql.Date(date.getTime())); // Current date
		             preparedStatement.setTime(2, time); // Current time
		             preparedStatement.setString(3, location);
		             preparedStatement.setInt(4, mileage);
		             preparedStatement.setString(5, vehicleType);
		             preparedStatement.setString(6, message);
		             preparedStatement.setString(7, "shera@gmail.com");
		
		            preparedStatement.executeUpdate();
		        }
		
		        // Display a success message or redirect to a thank-you page
		        out.println("Reservation submitted successfully!");
		
		    } catch (ClassNotFoundException | SQLException e) {
		        out.println("Error processing the reservation: " + e.getMessage());
		    } finally {
		        // Close the connection in the finally block to ensure it's always closed
		        try {
		            if (connection != null) {
		                connection.close();
		            }
		        } catch (SQLException e) {
		            out.println("Error closing the connection: " + e.getMessage());
		        }
		    }
    }
%>
</body>
</html>