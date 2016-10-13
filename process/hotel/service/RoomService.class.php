<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class RoomService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new RoomService();
        return self::$objService;
    }

    public function getRoom($conditions, $hashKey = null) {
        return RoomDao::instance()->getRoom($conditions, $hashKey);
    }

    public function saveRoom($arrayData) {
        return RoomDao::instance()->setTable('room')->insert($arrayData);
    }

    public function updateRoom($where, $row) {
        return RoomDao::instance()->setTable('room')->update($where, $row);
    }

    public function deleteRoom($where) {
        return RoomDao::instance()->setTable('room')->delete($where);
    }

    public function getAttribute($hotel_id, $room_type = 'room') {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0, $hotel_id)), 'room_type'=>$room_type);
        $cache_id = ModulesConfig::$cacheKey['hotel']['room_attribute'] . $hotel_id;
        $conditions['order'] = 'room_layout_attribute_father_id ASC, room_layout_attribute_order ASC, room_layout_attribute_id ASC';
        $arrayAttr =  RoomDao::instance()->setTable('room_layout_attribute')->getList($conditions);//DBCache($cache_id)->
        $arrarResult = array();
        foreach ($arrayAttr as $k => $v) {
            if($v['room_layout_attribute_id'] == $v['room_layout_attribute_father_id']) {
                $arrarResult[$v['room_layout_attribute_father_id']] = $v;
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'] = array();
            } else {
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'][] = $v;
            }
        }
        return $arrarResult;
    }

    public function getRoomLayout($conditions, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout')->getList($conditions, '', $hashKey);
    }

    public function saveRoomLayout($arrayData) {
        return RoomDao::instance()->setTable('room_layout')->insert($arrayData);
    }

    public function updateRoomLayout($where, $row) {
        return RoomDao::instance()->setTable('room_layout')->update($where, $row);
    }

    public function deleteRoomLayout($where) {
        return RoomDao::instance()->setTable('room_layout')->delete($where);
    }

    public function getRoomLayoutAttrValue($conditions, $hashKey = null, $multiple = false) {
        return RoomDao::instance()->setTable('room_layout_attribute_value')->getList($conditions, '', $hashKey, $multiple);
    }

    public function saveRoomLayoutAttrValue($arrayData) {
        return RoomDao::instance()->setTable('room_layout_attribute_value')->insert($arrayData);
    }

    public function batchSaveRoomLayoutAttrValue($arrayData, $insert_type = 'INSERT') {
        return RoomDao::instance()->setTable('room_layout_attribute_value')->batchInsert($arrayData, $insert_type);
    }

    public function updateRoomLayoutAttrValue($where, $row) {
        return RoomDao::instance()->setTable('room_layout_attribute_value')->update($where, $row);
    }

    public function deleteRoomLayoutAttrValue($where) {
        return RoomDao::instance()->setTable('room_layout_attribute_value')->delete($where);
    }

    public function getRoomLayoutImages($conditions, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout_images')->getList($conditions, '', $hashKey);
    }

    public function saveRoomLayoutImages($arrayData) {
        return RoomDao::instance()->setTable('room_layout_images')->insert($arrayData);
    }

    public function deleteRoomLayoutImages($where) {
        return RoomDao::instance()->setTable('room_layout_images')->delete($where);
    }


}