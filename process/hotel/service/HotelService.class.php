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
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        return HotelDao::instance('\hotel\HotelDao')->getHotelModules($conditions, $hashKey);
    }


}