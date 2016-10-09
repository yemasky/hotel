<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class HotelService extends \BaseService {
    public static function getHotelModules($hotel_id, $hashKey = null) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        return HotelDao::instance('\hotel\HotelDao')->getHotelModules($conditions, $hashKey);
    }

    public static function getHotel($conditions, $hashKey = null) {
        $conditions['order'] = 'hotel_id DESC';
        return HotelDao::instance('\hotel\HotelDao')->getHotel($conditions, $hashKey);
    }

    public static function saveHotel($arrayData) {
        return HotelDao::instance('\hotel\HotelDao')->setTable('hotel')->insert($arrayData);
    }

    public static function updateHotel($where, $row) {
        return HotelDao::instance('\hotel\HotelDao')->setTable('hotel')->update($where, $row);
    }

    public static function deleteHotel($where) {
        return HotelDao::instance('\hotel\HotelDao')->setTable('hotel')->delete($where);
    }

    public static function getAttribute($hotel_id) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0, $hotel_id)));
        $cache_id = ModulesConfig::$modulesHotelCacheKey['hotel_attribute'] . $hotel_id;
        $conditions['order'] = 'hotel_attribute_father_id ASC, hotel_attribute_order ASC, hotel_attribute_id ASC';
        $arrayAttr =  HotelDao::instance('\hotel\HotelDao')->setTable('hotel_attribute')->DBCache($cache_id)->getList($conditions);
        $arrarResult = array();
        foreach ($arrayAttr as $k => $v) {
            if($v['hotel_attribute_id'] == $v['hotel_attribute_father_id']) {
                $arrarResult[$v['hotel_attribute_father_id']] = $v;
                $arrarResult[$v['hotel_attribute_father_id']]['childen'] = array();
            } else {
                $arrarResult[$v['hotel_attribute_father_id']]['childen'][] = $v;
            }
        }
        sort($arrarResult);
        return $arrarResult;
    }

}