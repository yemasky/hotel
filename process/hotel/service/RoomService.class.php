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

    public function rollback() {
        RoomDao::instance()->rollback();
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
            if($v['room_layout_attribute_id'] == $v['room_layout_attribute_father_id'] || empty($v['room_layout_attribute_father_id'])) {
                //$v['room_layout_attribute_id'] = encode($v['room_layout_attribute_id']);
                $arrarResult[$v['room_layout_attribute_father_id']] = $v;
                $arrarResult[$v['room_layout_attribute_father_id']]['room_layout_attribute_id'] = encode($v['room_layout_attribute_id']);
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'] = array();
            } else {
                //$v['room_layout_attribute_id'] = encode($v['room_layout_attribute_id']);
                $encodeV = $v;
                $encodeV['room_layout_attribute_id'] = encode($v['room_layout_attribute_id']);
                $arrarResult[$v['room_layout_attribute_father_id']]['childen'][] = $encodeV;
            }
        }
        return $arrarResult;
    }

    public function saveRoomLayoutAttr($arrayData) {
        return RoomDao::instance()->setTable('room_layout_attribute')->insert($arrayData);
    }

    public function updateRoomLayoutAttr($where, $row) {
        return RoomDao::instance()->setTable('room_layout_attribute')->update($where, $row);
    }

    public function deleteRoomLayoutAttr($where) {
        return RoomDao::instance()->setTable('room_layout_attribute')->delete($where);
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
        return RoomDao::instance()->setTable('room_layout_attribute_value')->getList($conditions, null, $hashKey, $multiple);
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
        return RoomDao::instance()->setTable('room_layout_images')->getList($conditions, null, $hashKey);
    }

    public function saveRoomLayoutImages($arrayData) {
        return RoomDao::instance()->setTable('room_layout_images')->insert($arrayData);
    }

    public function deleteRoomLayoutImages($where) {
        return RoomDao::instance()->setTable('room_layout_images')->delete($where);
    }

    public function getRoomLayoutRoomDetailed($conditions, $hashKey = null) {
        $table = '`room` r INNER JOIN `room_layout_room` rlr ON r.room_id = rlr.room_id';
        $field = 'r.room_id, r.room_type, r.room_on_sell, r.room_status, r.room_name, r.room_describe, r.room_mansion, r.room_number, r.room_floor,'
            .'rlr.room_layout_id, rlr.room_layout_room_extra_bed';
        return RoomDao::instance()->setTable($table)->getList($conditions, $field, $hashKey);
    }

    public function getRoomLayoutRoom($conditions, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout_room')->getList($conditions, null, $hashKey);
    }

    public function saveRoomLayoutRoom($arrayData) {
        return RoomDao::instance()->setTable('room_layout_room')->insert($arrayData);
    }

    public function deleteRoomLayoutRoom($where) {
        return RoomDao::instance()->setTable('room_layout_room')->delete($where);
    }

    //房型价格
    public function getRoomLayoutPrice($conditions, $field = null, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout_price')->getList($conditions, $field, $hashKey);
    }

    public function saveRoomLayoutPrice($arrayData) {
        return RoomDao::instance()->setTable('room_layout_price')->insert($arrayData);
    }

    public function updateRoomLayoutPrice($where, $row) {
        return RoomDao::instance()->setTable('room_layout_price')->update($where, $row);
    }

    //加床
    public function getRoomLayoutExtenBedPrice($conditions, $field = null, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout_price_extra_bed')->getList($conditions, $field, $hashKey);
    }

    public function saveRoomLayoutExtenBedPrice($arrayData) {
        return RoomDao::instance()->setTable('room_layout_price_extra_bed')->insert($arrayData);
    }

    public function updateRoomLayoutExtenBedPrice($where, $row) {
        return RoomDao::instance()->setTable('room_layout_price_extra_bed')->update($where, $row);
    }
    //价格体系
    public function getRoomLayoutPriceSystem($conditions, $hashKey = null) {
        return RoomDao::instance()->setTable('room_layout_price_system')->getList($conditions, null, $hashKey);
    }

    public function saveRoomLayoutPriceSystem($arrayData) {
        return RoomDao::instance()->setTable('room_layout_price_system')->insert($arrayData);
    }

    public function updateRoomLayoutPriceSystem($where, $row) {
        return RoomDao::instance()->setTable('room_layout_price_system')->update($where, $row);
    }

    public function deleteRoomLayoutPriceSystem($where) {
        return RoomDao::instance()->setTable('room_layout_price_system')->delete($where);
    }

    public function getRoomLayoutPriceSystemFilter($conditions) {
        //EXPLAIN SELECT rlps.room_layout_price_system_id, rlps.room_layout_id, rlps.room_layout_price_system_name, hs.hotel_service_id
        //FROM `room_layout_price_system` rlps LEFT JOIN `room_layout_price_system_filter` rlpsf ON rlps.room_layout_price_system_id = rlpsf.room_layout_price_system_id
        //LEFT JOIN `hotel_service` hs ON hs.hotel_service_id = rlpsf.hotel_service_id WHERE rlps.hotel_id IN(0,1)
        $table = '`room_layout_price_system` rlps LEFT JOIN `room_layout_price_system_filter` rlpsf '
                .'ON rlps.room_layout_price_system_id = rlpsf.room_layout_price_system_id LEFT JOIN `hotel_service` hs '
                .'ON hs.hotel_service_id = rlpsf.hotel_service_id';
        $field = 'rlps.room_layout_price_system_id, rlps.room_layout_id, rlps.room_layout_price_system_name, hs.hotel_service_id,hs.hotel_service_name';
        $arrayPriceSystemFilter = RoomDao::instance()->setTable($table)->getList($conditions, $field);
        $arrayResule = array();
        if(!empty($arrayPriceSystemFilter)) {
            $k = 0;
            foreach($arrayPriceSystemFilter as $i => $arrayValues) {
                $id = $arrayValues['room_layout_price_system_id'];
                $arrayResule[$id]['room_layout_price_system_id'] = $id;
                $arrayResule[$id]['room_layout_id'] = $arrayValues['room_layout_id'];
                $arrayResule[$id]['room_layout_price_system_name'] = $arrayValues['room_layout_price_system_name'];
                if(empty($arrayValues['hotel_service_id'])) {
                    $arrayResule[$id]['hotel_service_id'] = '';
                    $arrayResule[$id]['hotel_service_name'] = '';
                } else {
                    $arrayResule[$id]['hotel_service_id'][] = $arrayValues['hotel_service_id'];
                    $arrayResule[$id]['hotel_service_name'][] = $arrayValues['hotel_service_name'];
                }
            }
            sort($arrayResule);
        }
        return $arrayResule;
    }
    //事务保存价格体系
    public function saveRoomLayoutPriceSystemAndFilter($arrayPostValue, $hotel_id) {
        $update_id = $arrayPostValue['update_system_id'];
        if($update_id == 1) return $update_id;//系统id 不能修改
        //事务开启
        RoomDao::instance()->startTransaction();
        $arrayRoomLayoutPriceSystem['room_layout_price_system_name'] = $arrayPostValue['price_system_name'];
        if(!empty($update_id)) {
            $room_layout_price_system_id = $update_id;
            $where = array('hotel_id'=>$hotel_id, 'room_layout_price_system_id'=>$update_id);
            $this->updateRoomLayoutPriceSystem($where, $arrayRoomLayoutPriceSystem);
            RoomDao::instance()->setTable('room_layout_price_system_filter')->delete($where);
        } else {
            $arrayRoomLayoutPriceSystem['hotel_id'] = $hotel_id;
            $arrayRoomLayoutPriceSystem['room_layout_price_system_add_date'] = getDay();
            $arrayRoomLayoutPriceSystem['room_layout_price_system_add_time'] = getTime();
            $arrayRoomLayoutPriceSystem['room_layout_id'] = $arrayPostValue['room_layout_id'];
            $room_layout_price_system_id = $this->saveRoomLayoutPriceSystem($arrayRoomLayoutPriceSystem);
        }
        if(isset($arrayPostValue['hotel_service_id']) && !empty($arrayPostValue['hotel_service_id'])) {
            foreach($arrayPostValue['hotel_service_id'] as $i => $hotel_service_id) {
                $arraySystemFilter[$i]['room_layout_price_system_id'] = $room_layout_price_system_id;
                $arraySystemFilter[$i]['hotel_id'] = $hotel_id;
                $arraySystemFilter[$i]['hotel_service_id'] = $hotel_service_id;
            }
            RoomDao::instance()->setTable('room_layout_price_system_filter')->batchInsert($arraySystemFilter);
        }
        RoomDao::instance()->commit();
        return $room_layout_price_system_id;
    }
}