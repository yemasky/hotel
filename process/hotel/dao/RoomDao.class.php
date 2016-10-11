<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class RoomDao extends \BaseDao {
    protected $table = 'room';

    public function getDsnRead() {
        return DbConfig::dsnRead();
    }

    public function getDsnWrite() {
        return DbConfig::dsnWrite();
    }

    public function getRoom($conditions, $hashKey = null){
        $cacheId = md5('getRoom' . json_encode($conditions) . $hashKey);
        $fileid = 'room_id, hotel_id, room_name, room_describe, room_mansion, room_number, room_floor, room_area, room_add_date, room_add_time, room_type';
        return $this->setDsnRead($this->getDsnRead())->setTable('room')->getList($conditions, $fileid, $hashKey);//->DBCache($cacheId)
    }
}