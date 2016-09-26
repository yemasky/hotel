<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class HotelDao extends \BaseDao {

    public function getHotelModules($conditions, $hashKey = null){
        $cacheId = md5('getHotelModules' . json_encode($conditions) . $hashKey);
        $fileid = 'hotel_id, modules_id, hotel_modules_father_id, hotel_modules_name, hotel_modules_navigation, hotel_modules_order, hotel_modules_ico, hotel_modules_show';
        $conditions['order'] = 'hotel_modules_father_id ASC, hotel_modules_order ASC, modules_id ASC';
        return $this->setDsnRead(\DbConfig::hotel_dsn_read)->setTable('hotel_modules')->getList($conditions, $fileid, $hashKey);//->DBCache($cacheId)
    }
}