<?php
require_once ("../config.php");

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
    $arrayLocation = DBQuery::instance(\DbConfig::hotel_dsn_write)->setTable('locations')->getList();
    //print_r($arrayLocation);
    $xml = '<?xml version="1.0" encoding="UTF-8"?><address>';
    foreach ($arrayLocation as $k => $v) {
        if($k > 0) {
            if($arrayLocation[$k - 1]['locations_type'] != $arrayLocation[$k]['locations_type']) {
                if($arrayLocation[$k - 1]['locations_type'] == 'town') {
                    $xml .= '</town>';
                }
                if($arrayLocation[$k - 1]['locations_type'] == 'city') {
                    $xml .= '</city>';
                }
                if($arrayLocation[$k - 1]['locations_type'] == 'province') {
                    $xml .= '</province>';
                }
            }
        }
        if($v['locations_id'] == $v['province_id'] && $v['locations_type'] == 'province') {//省
            $xml .= '<province name="'.$v['location_name'].'">';
        } elseif($v['locations_type'] == 'city') {
            $xml .= '<city name="'.$v['location_name'].'">';
        } elseif ($v['locations_type'] == 'town') {
            $xml .= '<country name="'.$v['location_name'].'" />';
        }
    }
    $xml .= '</address>';
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