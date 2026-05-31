
<?php 
    $file = fopen("sites-visites.csv", "r");

    echo "<html><head><meta charset='UTF-8'>";
    echo "<style>
        @page { 
            size: A4 landscape; 
            margin: 0.2cm; 
        }
        body { 
            font-family: Arial, sans-serif; 
            font-size: 6pt; 
            margin: 0; 
            padding: 0; 
            line-height: 1.2;
        }
        h1 { 
            text-align: center; 
            font-size: 10pt;
            margin: 2px 0 5px 0; 
            color: #333;
        }
        .header {
            text-align: center;
            margin-bottom: 3px; 
            padding: 0;
        }
        .logo { 
            width: 40px; 
            height: auto;
        }
        .container {
            column-count: 3;
            column-gap: 10px;
            width: 100%;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            font-size: 5pt;
        }
        tr {
            page-break-inside: avoid;
        }
        th, td { 
            border: 0.5px solid #999; 
            padding: 1px; 
            text-align: left; 
            vertical-align: top;
        }
        th { 
            background-color: #ddd; 
            font-weight: bold;
        }
    </style></head><body>";

    echo "<div class='header'>";
    echo "<img src='Logo_office_tourisme.png' alt='Logo' class='logo'>";
    echo "<h1>Sites Touristiques - Par Nombre de Visiteurs</h1>";
    echo "</div>";

    echo "<div class='container'>";
    echo "<table>";
    echo "<tr><th>N°</th><th>Département</th><th>Site</th><th>Visiteurs</th></tr>";

    while(($line = fgetcsv($file, 1000, ",")) !== FALSE) {
        if (count($line) >= 4 && !empty(trim($line[1], '" '))) {
            $num_dept = trim($line[1], '" ');
            $nom_dept = trim($line[2], '" ');
            $site = trim($line[0], '" ');
            $visiteurs = trim($line[3], '" ');
            
            echo "<tr>";
            echo "<td>$num_dept</td>";
            echo "<td>$nom_dept</td>";
            echo "<td>$site</td>";
            echo "<td>$visiteurs</td>";
            echo "</tr>";
        }
    }

    echo "</table></div></body></html>";
    fclose($file);
?>