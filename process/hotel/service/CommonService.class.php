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
        $arrayRoleModulesEmployee = RoleService::getRoleModulesEmployee($arrayLoginEmployeeInfo['employee_id']);
        $arrayHotelModules = HotelService::getHotelModules($arrayLoginEmployeeInfo['hotel_id']);
        $arrayModules = ModulesService::getModules();

        $arrayEmployeeModules = array();
        $i_length = count($arrayHotelModules);
        for($i = 0; $i <$i_length; $i++) {
            if(isset($arrayRoleModulesEmployee[$arrayHotelModules[$i]['modules_id']])) {
                $arrayHotelModules[$i]['hotel_modules_name'] = empty($arrayHotelModules[$i]['hotel_modules_name']) ? $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_name'] : $arrayHotelModules[$i]['hotel_modules_name'];
                $arrayHotelModules[$i]['modules_module'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_module'];
                $arrayHotelModules[$i]['hotel_modules_ico'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_ico'];
                $arrayHotelModules[$i]['modules_action'] = $arrayModules[$arrayHotelModules[$i]['modules_id']]['modules_action'];
                $arrayHotelModules[$i]['url'] = \BaseUrlUtil::Url(array('module'=>encode($arrayHotelModules[$i]['modules_id'])));
                $arrayEmployeeModules[] = $arrayHotelModules[$i];
            }
        }
        return $arrayEmployeeModules;
    }


}