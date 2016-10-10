<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
namespace hotel;

class ModulesConfig extends \ModulesConfig {
	public static $modulesCompany = array('edit'=>24, 'delete'=>25, 'add'=>28);
	public static $modulesHotel = array('edit'=>26, 'delete'=>27, 'add'=>29);
    public static $modulesRoomsSetting = array('view'=>18,'edit'=>000, 'delete'=>000, 'add'=>32,
        'room_type'=>array('room','office','store','varia','dining','restaurant'));


    public static $modulesCompanyCacheKey = array('company_default_id'=>'company_default_id_');
	public static $modulesHotelCacheKey = array('hotel_default_id'=>'hotel_default_id_','hotel_attribute'=>'hotel_attribute_');

}