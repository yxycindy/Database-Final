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

$low = $_POST['grade'];
$y=7;
$high = $low + $y;
echo "<h1> ".$low." and high is ".$high." </h1>";

echo "<h1> Number of climbs in each country for the grade range selected </h1>";
if ($mysqli->multi_query("CALL ListClimb_GradeNum('".$low."', '".$high."');")) {
        do {
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
                               echo "<th> country name  </th>";
                               echo "<th> number of climb </th>";
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
        } while ($mysqli->next_result());
}
else {
       printf("<br>Error: %s\n", $mysqli->error);
}

echo "<h1> Number of men and women in each country achieved the grade range you selected</h1>";
if ($mysqli->multi_query("CALL ListClimb_Grade('".$low."', '".$high."');")) {
        do {
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
                               echo "<th> country name  </th>";
                               echo "<th> No. of man</th>";
                               echo "<th> No. of woman</th>";
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
        } while ($mysqli->next_result());
}
else {
       printf("<br>Error: %s\n", $mysqli->error);
}


?>
</body>
