
<?php 
    // Étape 1 : Lire le fichier REGIONS
    $regions = array();
    $file_regions = fopen("REGIONS", "r");
    
    while(($line = fgets($file_regions)) !== FALSE) {
        $line = rtrim($line);
        if (empty($line)) continue;
        
        // Format: "Région=01, 02, 03"
        $parts = explode("=", $line);
        $region_name = trim($parts[0]);
        $depts = array_map('trim', explode(",", $parts[1]));
        
        $regions[$region_name] = $depts;
    }
    fclose($file_regions);
    
    // Étape 2 : Lire le fichier CSV des sites
    $sites = array();
    $file_csv = fopen("sites_touristiques_complets.csv", "r");
    
    while(($line = fgetcsv($file_csv, 1000, ",")) !== FALSE) {
        if (count($line) >= 4) {
            $dept_code = trim($line[1], '" ');
            $visiteurs = (int)trim($line[3], '" ');
            
            if (!isset($sites[$dept_code])) {
                $sites[$dept_code] = 0;
            }
            $sites[$dept_code] += $visiteurs;
        }
    }
    fclose($file_csv);
    
    // Étape 3 : Calculer le total par région
    $regions_totals = array();
    
    foreach ($regions as $region_name => $depts) {
        $total = 0;
        
        // Pour chaque département de la région
        foreach ($depts as $dept_code) {
            // Si le département existe dans nos sites
            if (isset($sites[$dept_code])) {
                $total += $sites[$dept_code];
            }
        }
        
        $regions_totals[$region_name] = $total;
    }
    
    // Étape 4 : Trier par visiteurs décroissant
    arsort($regions_totals);
    
    // Étape 5 : Générer le HTML
    echo "<html><head><meta charset='UTF-8'>";
    echo "<style>
        @page { 
            size: A4 landscape; 
            margin: 0.2cm; 
        }
        body { 
            font-family: Arial, sans-serif; 
            font-size: 8pt; 
            margin: 0; 
            padding: 0; 
            line-height: 1.2;
        }
        h1 { 
            text-align: center; 
            font-size: 12pt;
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
        table { 
            width: 100%; 
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td { 
            border: 0.5px solid #999; 
            padding: 3px; 
            text-align: left; 
            vertical-align: top;
        }
        th { 
            background-color: #ddd; 
            font-weight: bold;
        }
        td:last-child {
            text-align: right;
        }
    </style></head><body>";

    echo "<div class='header'>";
    echo "<img src='Logo_office_tourisme.png' alt='Logo' class='logo'>";
    echo "<h1>Synthèse des Visiteurs par Région</h1>";
    echo "</div>";

    echo "<table>";
    echo "<tr><th>Région</th><th>Total Visiteurs</th></tr>";

    foreach ($regions_totals as $region_name => $total) {
        echo "<tr>";
        echo "<td>$region_name</td>";
        echo "<td>$total</td>";
        echo "</tr>";
    }

    echo "</table></body></html>";
?>