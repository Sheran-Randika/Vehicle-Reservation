<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.sql.DriverManager,java.sql.SQLException" %>
<%@ page import="java.sql.Date,java.sql.Time,java.sql.Timestamp,java.time.LocalDate,java.time.LocalTime,java.time.LocalDateTime,java.time.format.DateTimeFormatter" %>
<%
 // You can assign a default value or retrieve it from a session, request, etc.
Connection connection = null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/Style.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

    <nav>
        <ul>
            <li><a href="#section1">Contact</a></li>
            <li><a href="#section2">Reservation</a></li>
            <li><a href="#section3">Booking Details</a></li>
        </ul>
    </nav>

    <section id="section1">
    <h2>Contact Information</h2>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Country</th>
            </tr>
            <tr>
                <td id ="name"></td>
                <td id ="email"></td>
                <td id ="phone"></td>
                <td id="country"></td>
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
            
            <input type="hidden" id="usernameForInsert" name="usernameForInsert" value="">

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

            <input type="submit" value="Submit" id="submit" name="submit">
        </form>
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
		    String username = request.getParameter("usernameForInsert");
		    System.out.println(username);
		 // Parse date
		    Date date = Date.valueOf(LocalDate.parse(request.getParameter("date")));

		    // Parse time
		    Time time = Time.valueOf(LocalTime.parse(request.getParameter("time")));
		    String vehicleType = request.getParameter("vehicleType");
		    String message = request.getParameter("message");
		
		
		   
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
		             preparedStatement.setString(7, username);
		
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
    
    <section id="section3">
    <h1>Services</h1>
    <form id="serviceTable" method="post" onsubmit="document.getElementById('SelectContainer').style.display='block'">
        <input type="hidden" id="usernameForSelect" name="usernameForSelect" value="" >
        <input type="submit" name="reservations" id="reservations" value="Click here to see your reservations" class="formbtn">
    </form>

    <div class="container" id="SelectContainer">
        <h1>Booking Details</h1>
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Location</th>
                    <th>Mileage</th>
                    <th>Vehicle Number</th>
                    <th>Message</th>
                    <th>Action</th>
                </tr>
            </thead>
            <%
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, password);
                    String unForSelect = request.getParameter("usernameForSelect");

                    String sql = "SELECT * FROM vehicle_service WHERE username = ?";
                    PreparedStatement stmt = connection.prepareStatement(sql);
                    stmt.setString(1, unForSelect);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                    	Date currentDate = new Date(System.currentTimeMillis());

                        while (rs.next()) {
                            int bookingId = rs.getInt("booking_id");
                            String date = rs.getString("date");
                            String time = rs.getString("time");
                            String location1 = rs.getString("location");
                            String mileage = rs.getString("mileage");
                            String vehicleNumber = rs.getString("vehicle_no");
                            String message1 = rs.getString("message");
                            Date date0 = rs.getDate("date");
            %>
                            <tr>
                                <td><%= bookingId %></td>
                                <td><%= date %></td>
                                <td><%= time %></td>
                                <td><%= location1 %></td>
                                <td><%= mileage %></td>
                                <td><%= vehicleNumber %></td>
                                <td><%= message1 %></td>
                                <td>
                                    <%
                                        if (!date0.before(currentDate)) {
                                    %>
                                        <form id="deleteRecord" method="post" action="#services" onsubmit="document.getElementById('SelectContainer').style.display='block'">
                                            <input type="hidden" id="idForDelete" name="idForDelete" value=<%= bookingId %> >
                                            <input type="submit" name="delete" id="delete" value="Delete">
                                        </form>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("Error: " + e.getMessage());
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }

                        if (connection != null) {
                        	connection.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("Error: " + e.getMessage());
                    }
                }
            %>
        </table>
    </div>

    <%
        if (request.getParameter("delete") != null) {
            PreparedStatement preparedStatement = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, user, password);
                String bookingId = request.getParameter("idForDelete");
                int id = Integer.parseInt(bookingId);

                String sql = "DELETE FROM vehicle_service WHERE booking_id = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, id);
                int rowsAffected = preparedStatement.executeUpdate();

                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }

                    if (connection != null) {
                    	connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</section>
<script>

$(document).ready(function() {
	var accessToken = localStorage.getItem('accessToken');
	var idToken = localStorage.getItem('idToken');
	
	console.log(accessToken);
	if(accessToken && idToken){
		   var settings = {
		            "url": 'https://api.asgardeo.io/t/sheran/oauth2/userinfo',
		            "method": "GET",
		            "timeout": 0,
		            "headers": {
		                "Authorization": "Bearer " + accessToken
		            },
		        };
	
		        $.ajax(settings)
		            .done(function (response) {
		                //console.log(response);
		                var username =  response.username;
		                var given_name = response.given_name;
		                var phone = response.phone_number;
		                var email = response.email;
		                var username = response.username;
						var address = response.address;
		                var country = address.country;
		          //      console.log(username);
		          //      console.log(country);
		                
		                
		                document.getElementById('name').textContent = given_name;
		                document.getElementById('email').textContent = email;
		                document.getElementById('phone').textContent = phone;
		                document.getElementById('country').textContent = country;
		                
		            
		                localStorage.setItem('username', username);
		            
		                 
		             
		            })
		            .fail(function (jqXHR, textStatus, errorThrown) {
		                // Handle any errors here
		                console.error('Error:', errorThrown);
		                alert("Authorization error. Login again!");
		                window.location.href = "./index.jsp";
		            });
	}
	
	
    var username = localStorage.getItem('username')
    console.log(username);
     
     document.getElementById('submit').addEventListener('click', function () {
         // Set the username as a hidden field value in the form
         document.getElementById('usernameForInsert').value = username;
      });
     
     document.getElementById('reservations').addEventListener('click', function () {
         // Set the username as a hidden field value in the form
         document.getElementById('usernameForSelect').value = username;
      });
     
     
     
     	//const idToken = localStorage.getItem('idToken');
 	
 		const state = localStorage.getItem('sessionState');

 	
    document.getElementById("client-id").value = "2zGvdGwcZlHJf6Mvf01VIypHfzQa";
    document.getElementById("post-logout-redirect-uri").value = "http://localhost:8080/VehicalServiceReservation/index.jsp";
    document.getElementById("state").value = state;
    
    
    
	
});
	 
</script>
</body>
</html>