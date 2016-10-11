<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class RoomService extends \BaseService {

    public static function getRoom($conditions, $hashKey = null) {
        $arrayRoom = RoomDao::instance('\hotel\RoomDao')->getRoom($conditions, $hashKey);
        $arrayRoomHash = null;
        if(!empty($arrayRoom)) {
            foreach ($arrayRoom as $i => $v) {
                $v['url'] =
                    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsSetting']['view']), 'room_id'=>encode($v['room_id'])));
                $arrayRoomHash[$v['room_type']][] = $v;
            }
        }
        return $arrayRoomHash;
    }

    public static function saveRoom($arrayData) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room')->insert($arrayData);
    }

    public static function updateRoom($where, $row) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room')->update($where, $row);
    }

    public static function deleteRoom($where) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room')->delete($where);
    }

    public static function getAttribute($hotel_id, $room_type = 'room') {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0, $hotel_id)), 'room_type'=>$room_type);
        $cache_id = ModulesConfig::$cacheKey['hotel']['room_attribute'] . $hotel_id;
        $conditions['order'] = 'room_layout_attribute_father_id ASC, room_layout_attribute_order ASC, room_layout_attribute_id ASC';
        $arrayAttr =  RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute')->DBCache($cache_id)->getList($conditions);
        $arrarResult = array();
        foreach ($arrayAttr as $k => $v) {
            if($v['room_layout_attribute_id'] == $v['room_layout_attribute_father_id']) {
                $arrarResult[$v['room_layout_attribute_father_id']] = $v;
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'] = array();
            } else {
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'][] = $v;
            }
        }
        sort($arrarResult);
        return $arrarResult;
    }

    public static function getRoomLayout($conditions, $hashKey = null) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout')->getList($conditions, $hashKey);
    }

    public static function saveRoomLayout($arrayData) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout')->insert($arrayData);
    }

    public static function updateRoomLayout($where, $row) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout')->update($where, $row);
    }

    public static function deleteRoomLayout($where) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout')->delete($where);
    }

    public static function getRoomLayoutAttrValue($conditions, $hashKey = null) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute_value')->getList($conditions, $hashKey);
    }

    public static function saveRoomLayoutAttrValue($arrayData) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute_value')->insert($arrayData);
    }

    public static function batchSaveRoomLayoutAttrValue($arrayData) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute_value')->batchInsert($arrayData);
    }

    public static function updateRoomLayoutAttrValue($where, $row) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute_value')->update($where, $row);
    }

    public static function deleteRoomLayoutAttrValue($where) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room_layout_attribute_value')->delete($where);
    }


}