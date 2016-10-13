<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class HotelService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new HotelService();
        return self::$objService;
    }

    public function getHotelModules($hotel_id, $hashKey = null) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        return HotelDao::instance()->getHotelModules($conditions, $hashKey);
    }

    public function getHotel($conditions, $hashKey = null) {
        $conditions['order'] = 'hotel_id DESC';
        return HotelDao::instance()->getHotel($conditions, $hashKey);
    }

    public function saveHotel($arrayData) {
        return HotelDao::instance()->setTable('hotel')->insert($arrayData);
    }

    public function updateHotel($where, $row) {
        return HotelDao::instance()->setTable('hotel')->update($where, $row);
    }

    public function deleteHotel($where) {
        return HotelDao::instance()->setTable('hotel')->delete($where);
    }

    public function getAttribute($hotel_id) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0, $hotel_id)));
        $cache_id = ModulesConfig::$cacheKey['hotel']['hotel_attribute'] . $hotel_id;
        $conditions['order'] = 'hotel_attribute_father_id ASC, hotel_attribute_order ASC, hotel_attribute_id ASC';
        $arrayAttr =  HotelDao::instance()->setTable('hotel_attribute')->DBCache($cache_id)->getList($conditions);
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