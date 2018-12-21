<head>
 <title>The Climbing Being</title>
</head>
<body>
<?php
// PHP code just started


// a
include 'open.php';

ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);


echo "<h1>Top 10 climbers</h1>";

if ($mysqli->multi_query("CALL Topfemale();")) {
               if ($result = $mysqli->store_result()) {
                 echo "<table border=\"1px solid black\">";
                       $row = $result->fetch_row();
                       if (strcmp($row[0], 'ERROR: ') == 0) {
                               echo "<tr><th> Result </th></tr>";
                               do {
                                       echo "<tr><td>" ;
                                       for($i = 0; $i < sizeof($row); $i++){
                                               echo $row[$i] ;
                                       }
                                       echo "</td></tr>";
                               } while ($row = $result->fetch_row());
                       }
                       else {
                               echo "<tr>";
                               echo "<th> Country </th>";
                               echo "<th> number of elite female climber </th>";
                               echo "</tr>";
                               do {
                                       echo "<tr>";
                                       for($i = 0; $i < sizeof($row); $i++){
                                               echo "<td>" . $row[$i] . "</td>";
                                       }
                                       echo "</tr>";
                               } while($row = $result->fetch_row());
                       }
                       echo "</table>";
                       $result->close();
               }
               if ($mysqli->more_results()) {
                       printf("-----------------\n");
               }
       // } while ($mysqli->next_result());
}
else {
       printf("<br>Error: %s\n", $mysqli->error);
}

?>
</body>
