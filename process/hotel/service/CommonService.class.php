<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CommonService extends \BaseService {
    public static function getEmployeeModules($arrayLoginEmployeeInfo) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('employee_id'=>$arrayLoginEmployeeInfo['employee_id']);
        $arrayHotelModules = HotelService::getHotelModules($arrayLoginEmployeeInfo['hotel_id']);
        $arrayRoleModulesEmployee = RoleDao::instance('\hotel\RoleDao')->getRoleModulesEmployee($conditions);
        $arrayModules = ModulesDao::instance('\hotel\ModulesDao')->getModules(\DbConfig::$db_query_conditions);

        $arrayEmployeeModules = array();
        $i_length = count($arrayHotelModules);
        for($i = 0; $i <$i_length; $i++) {
            if(isset($arrayRoleModulesEmployee[$arrayHotelModules[$i]['modules_id']])) {
                $arrayHotelModules[$i]['hotel_modules_name'] = empty($arrayHotelModules[$i]['hotel_modules_name']) ? $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_name'] : $arrayHotelModules[$i]['hotel_modules_name'];
                $arrayHotelModules[$i]['modules_module'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_module'];
                $arrayHotelModules[$i]['hotel_modules_ico'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_ico'];
                $arrayHotelModules[$i]['modules_action'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_action'];
                $arrayEmployeeModules[] = $arrayHotelModules[$i];
            }
        }
        return $arrayEmployeeModules;
    }

    public static  function getHotelModules($hotel_id) {
        $arrayHotelModules = HotelService::getHotelModules($hotel_id);
        $arrayModules = ModulesDao::instance('\hotel\ModulesDao')->getModules(\DbConfig::$db_query_conditions);
        $i_length = count($arrayHotelModules);
        for($i = 0; $i <$i_length; $i++) {
            if(isset($arrayHotelModules[$arrayHotelModules[$i]['modules_id']])) {
                $arrayHotelModules[$i]['hotel_modules_name'] = empty($arrayHotelModules[$i]['hotel_modules_name']) ? $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_name'] : $arrayHotelModules[$i]['hotel_modules_name'];

                $arrayEmployeeModules[] = $arrayHotelModules[$i];
            }
        }
    }

}