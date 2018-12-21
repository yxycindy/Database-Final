<head>
 <title>The Climbing Being</title>
</head>
<body>

<?php
include 'open.php';
// c
ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);

$id = $_POST["ID"];
echo "<h1>All the climbs the user has done</h1>";
if ($mysqli->multi_query("CALL ListClimb('".$id."');")) {
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
                                echo "<th> name </th>";
                                echo "<th> crag </th>";
                                echo "<th> country </th>";
                                echo "<th> year </th>";
                                echo "<th> usa grade </th>";
                                echo "<th> methode name </th>";
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
                // $stmt->store_result();
        } while ($mysqli->next_result());
}
else {
        printf("<br>Error: %s\n", $mysqli->error);
}
// $stmt->store_result();
//while(mysqli_next_result($connect)){;}
echo "<h1>All the boulders the user has done</h1>";
if ($mysqli->multi_query("CALL ListBoulder('".$id."');")) {
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
                                echo "<th> name </th>";
                                echo "<th> crag </th>";
                                echo "<th> country </th>";
                                echo "<th> year </th>";
                                echo "<th> boulder grade </th>";
                                echo "<th> methode name </th>";
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

echo "<h1>number of climbs the user has done for each sending method</h1>";
if ($mysqli->multi_query("CALL CountMethod('".$id."');")) {
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
                                echo "<th> method name </th>";
                                echo "<th> num of climbs </th>";
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

echo "<h1>number of boulder problems the user has done for each sending method</h1>";
if ($mysqli->multi_query("CALL CountMethodBoulder('".$id."');")) {
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
                                echo "<th> method name </th>";
                                echo "<th> num of climbs </th>";
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
