<?php
require_once ("../config.php");

for ($i = 0; $i <= 6; $i++ ) {
    echo 1 - $i . "<br>";
}

return;
function getOrderNumber($billid, $length = 16) {
	if(strlen($billid) >= $length) return $billid;
	$billno = $billid.'0';
	$id_lenght = strlen($billno) + 1;
	for($i = $id_lenght; $i<=$length; $i++) {
		$billno .= rand(1, 9);
	}
	return $billno;
}

for($i = 1; $i <= 50; $i++) {
	echo getOrderNumber($i). "<br>\r\n";
}

return;
function insertLocation() {
    $lines = file("city.txt");
    $locations_id = $province_id = $city_id = '';
    foreach ($lines as $line) {
        $line = rtrim($line);
        if(empty($line)) continue;
        //echo $line . "<br>";
        $arrayLocation = explode('     　', $line);
        $arrayProvince = explode('　', $arrayLocation[1]);
        print_r($arrayProvince);
        $locations_id = $arrayLocation[0];
        $countProvince = count($arrayProvince);
        if($countProvince == 1) {//Province
            $province_id = $arrayLocation[0];
            $city_id = null;
            $location_name = trim($arrayLocation[1]);
            $locations_type = 'province';
        } elseif ($countProvince == 2) {//city
            $city_id = $arrayLocation[0];
            $location_name = trim($arrayProvince[1]);
            $locations_type = 'city';
        } elseif ($countProvince == 3) {//town
            $location_name = trim($arrayProvince[2]);
            $locations_type = 'town';
        }
        $insertData['locations_id'] = $locations_id;
        $insertData['location_name'] = $location_name;
        $insertData['province_id'] = $province_id;
        $insertData['city_id'] = $city_id;
        $insertData['locations_type'] = $locations_type;

        DBQuery::instance(\DbConfig::hotel_dsn_write)->setTable('locations')->insert($insertData);

    }
}

function exportLocationXml() {
    $arrayLocation = DBQuery::instance(\DbConfig::hotel_dsn_write)->setTable('locations')->order('province_id ASC ,city_id ASC, locations_id ASC')->getList();
    //print_r($arrayLocation);
    header("Content-type:text/xml");
    $xml = '<?xml version="1.0" encoding="UTF-8"?><address>' . "\r\n";
    foreach ($arrayLocation as $k => $v) {
        if($v['locations_id'] == $v['province_id'] && $v['locations_type'] == 'province') {//省
            if($k > 0) {
                $xml .= "</province>\r\n";
            }
            $xml .= '<province location="'.$v['locations_id'].'" name="'.$v['location_name'].'">' . "\r\n";
        } elseif($v['locations_type'] == 'city') {//市
            $xml .= '<city location="'.$v['locations_id'].'" name="'.$v['location_name'].'">' . "\r\n";
            if(!isset($arrayLocation[$k + 1])) {
                $xml .= "</city>\r\n";
            } else {
                if ($arrayLocation[$k + 1]['locations_type'] != 'town') {
                    $xml .= "</city>\r\n";
                }
            }
        } elseif ($v['locations_type'] == 'town') {//区
            $xml .= '<country location="'.$v['locations_id'].'" name="'.$v['location_name'].'" />' . "\r\n";
            if(!isset($arrayLocation[$k + 1])) {
                $xml .= "</city>\r\n";
            } elseif ($arrayLocation[$k + 1]['locations_type'] != 'town') {
                $xml .= "</city>\r\n";
            }
        }
    }
    $xml .= '</province></address>';
    return $xml;
}

function readXml() {
    $xml = 'E:/SVN/hotel/root/hotel/static/area/Area.xml';
    $objXml = new XML();
    $arrayXml = $objXml->loadToArray($xml);
    //print_r($arrayXml);
    //$objXml->storeFromArray('E:/SVN/hotel/root/hotel/static/area/Area2.xml', $arrayXml);
    //$domObj = new xmlToArrayParser($xml);
    //print_r($domObj);
    Array2xml::instance($arrayXml);//->storeFromArray('E:/SVN/hotel/root/hotel/static/area/Area2.xml');
    //$xml = $objArray2Xml->getXml();
    //$objArray2Xml->storeFromArray('E:/SVN/hotel/root/hotel/static/area/Area2.xml', $xml);
}

function readXml2() {
    $xml = 'E:/SVN/hotel/root/hotel/static/area/Area2.xml';
    $objXml = new XML();
    $arrayXml = $objXml->loadToArray($xml);
    print_r($arrayXml);
}
echo  exportLocationXml();