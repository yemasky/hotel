<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
namespace hotel;

class ModulesConfig extends \ModulesConfig {
	public static $modulesCompany = array('edit'=>22, 'delete'=>23, 'add'=>26);
	public static $modulesHotel = array('edit'=>24, 'delete'=>25, 'add'=>27);

	public static $modulesCompanyCacheKey = array('company_default_id'=>'company_default_id', 'delete'=>23, 'add'=>26);
	public static $modulesHotelCacheKey = array('hotel_default_id'=>'hotel_default_id');

}