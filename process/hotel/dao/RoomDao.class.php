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
    private static $objDao = null;

    public static function instance() {
        if(is_object(self::$objDao)) {
            return self::$objDao;
        }
        self::$objDao = new RoomDao();
        return self::$objDao;
    }

    public function getDsnRead() {
        return DbConfig::dsnRead();
    }

    public function getDsnWrite() {
        return DbConfig::dsnWrite();
    }

    public function getRoom($conditions, $fileid = '', $hashKey = null){
        $cacheId = md5('getRoom' . json_encode($conditions) . $hashKey);
        if(empty($fileid) || $fileid == '*')
            $fileid = 'room_id, hotel_id, room_name, room_describe, room_mansion, room_number, room_floor, room_area, room_orientations, room_add_date, room_add_time, room_type';
        return $this->setDsnRead($this->getDsnRead())->setTable('room')->getList($conditions, $fileid, $hashKey);//->DBCache($cacheId)
    }
}