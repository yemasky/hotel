<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class HotelEmployeeDao extends \BaseDao {

    public function getLoginEmployee($arrayLoginInfo){
        return \DBQuery::instance(\DbConfig::hotel_dsn_read)->setTable('employee')->getRow($arrayLoginInfo, 'employee_id, company_id, hotel_id, employee_name, employee_mobile, employee_password');
    }
}