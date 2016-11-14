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

    public function getHotelModules($hotel_id, $hashKey = null, $multiple = false) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        return HotelDao::instance()->getHotelModules($conditions, '*', $hashKey, $multiple);
    }

    public function getHotel($conditions, $hashKey = null) {
        if(empty($conditions['order'])) $conditions['order'] = 'hotel_id DESC';
        return HotelDao::instance()->getHotel($conditions, null, $hashKey);
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
        $arrayAttr =  HotelDao::instance()->setTable('hotel_attribute')->getList($conditions);//->DBCache($cache_id)
        $arrarResult = array();
        foreach ($arrayAttr as $k => $v) {
            if($v['hotel_attribute_id'] == $v['hotel_attribute_father_id']) {
                $arrarResult[$v['hotel_attribute_father_id']] = $v;
                $arrarResult[$v['hotel_attribute_father_id']]['hotel_attribute_id'] = encode($v['hotel_attribute_id']);
                $arrarResult[$v['hotel_attribute_father_id']]['childen'] = array();
            } else {
                $encodeV = $v;
                $encodeV['hotel_attribute_id'] = encode($v['hotel_attribute_id']);
                $arrarResult[$v['hotel_attribute_father_id']]['childen'][] = $v;
            }
        }
        return $arrarResult;
    }

    public function saveHotelAttr($arrayData) {
        return RoomDao::instance()->setTable('hotel_attribute')->insert($arrayData);
    }

    public function updateHotelAttr($where, $row) {
        return RoomDao::instance()->setTable('hotel_attribute')->update($where, $row);
    }

    public function deleteHotelAttr($where) {
        return RoomDao::instance()->setTable('hotel_attribute')->delete($where);
    }

    public function getHotelImages($conditions, $hashKey = null) {
        return RoomDao::instance()->setTable('hotel_images')->getList($conditions, '', $hashKey);
    }

    public function saveHotelImages($arrayData) {
        return RoomDao::instance()->setTable('hotel_images')->insert($arrayData);
    }

    public function deleteHotelImages($where) {
        return RoomDao::instance()->setTable('hotel_images')->delete($where);
    }

    public function getHotelAttrValue($conditions, $hashKey = null, $multiple = false) {
        return RoomDao::instance()->setTable('hotel_attribute_value')->getList($conditions, '', $hashKey, $multiple);
    }

    public function saveHotelAttrValue($arrayData) {
        return RoomDao::instance()->setTable('hotel_attribute_value')->insert($arrayData);
    }

    public function batchSaveHotelAttrValue($arrayData, $insert_type = 'INSERT') {
        return RoomDao::instance()->setTable('hotel_attribute_value')->batchInsert($arrayData, $insert_type);
    }

    public function updateHotelAttrValue($where, $row) {
        return RoomDao::instance()->setTable('hotel_attribute_value')->update($where, $row);
    }

    public function deleteHotelAttrValue($where) {
        return RoomDao::instance()->setTable('hotel_attribute_value')->delete($where);
    }
    //hotel_service
    public function getHotelService($conditions, $field = '*', $hashKey = null, $multiple = false, $fatherKey = '') {
        return RoomDao::instance()->setTable('hotel_service')->getList($conditions, $field, $hashKey, $multiple, $fatherKey);
    }

    public function saveHotelService($arrayData) {
        return RoomDao::instance()->setTable('hotel_service')->insert($arrayData);
    }

    public function updateHotelService($where, $row) {
        return RoomDao::instance()->setTable('hotel_service')->update($where, $row);
    }

    public function deleteHotelService($where) {
        return RoomDao::instance()->setTable('hotel_service')->delete($where);
    }
}