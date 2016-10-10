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
                $v['url'] = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesRoomsSetting['view']), 'room_id'=>encode($v['room_id'])));
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

    public static function deleteHotel($where) {
        return RoomDao::instance('\hotel\RoomDao')->setTable('room')->delete($where);
    }

    public static function getAttribute($hotel_id) {

    }

}