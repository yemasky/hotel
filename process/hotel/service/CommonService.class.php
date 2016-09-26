<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class CommonService extends \BaseService {
    //取得登录用户权限模块
    public static function getEmployeeModules($arrayLoginEmployeeInfo) {
        $arrayRoleModulesEmployee = RoleService::getRoleModulesEmployee($arrayLoginEmployeeInfo['employee_id']);
        $arrayHotelModules = HotelService::getHotelModules($arrayLoginEmployeeInfo['hotel_id']);
        $arrayModules = ModulesService::getModules();

        $arrayEmployeeModules = array();
        $i_length = count($arrayHotelModules);
        for($i = 0; $i <$i_length; $i++) {
            if(isset($arrayRoleModulesEmployee[$arrayHotelModules[$i]['modules_id']]) && $arrayHotelModules[$i]['hotel_modules_show'] == '1') {
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

    //网站导航
    public static function getNavigation($arrayLoginEmployeeInfo, $modules_id) {
        $arrayNavigation = array();
        if(empty($modules_id) || empty($arrayLoginEmployeeInfo)) {
            return $arrayNavigation;
        }
        $arrayHotelModules = HotelService::getHotelModules($arrayLoginEmployeeInfo['hotel_id'], 'modules_id');
        $arrayModules = ModulesService::getModules();
        if(!isset($arrayHotelModules[$modules_id])) {
            return $arrayNavigation;
        }
        $arrayHotelModule = $arrayHotelModules[$modules_id];
        $i = 0;
        if($arrayHotelModule['modules_id'] != $arrayHotelModule['hotel_modules_father_id'] && isset($arrayHotelModules[$arrayHotelModule['hotel_modules_father_id']])) {
            $arrayNavigation[$i] = $arrayHotelModules[$arrayHotelModule['hotel_modules_father_id']];
            $arrayNavigation[$i]['hotel_modules_name'] = empty($arrayNavigation[$i]['hotel_modules_name']) ? $arrayModules[$arrayHotelModule['hotel_modules_father_id']]['modules_name'] : $arrayNavigation[$i]['hotel_modules_name'];
            $arrayNavigation[$i]['modules_module'] = $arrayModules[$arrayHotelModule['hotel_modules_father_id']]['modules_module'];
            $arrayNavigation[$i]['hotel_modules_ico'] = $arrayModules[$arrayHotelModule['hotel_modules_father_id']]['modules_ico'];
            $arrayNavigation[$i]['modules_action'] = $arrayModules[$arrayHotelModule['hotel_modules_father_id']]['modules_action'];
            $arrayNavigation[$i]['url'] = \BaseUrlUtil::Url(array('module'=>encode($arrayHotelModule['hotel_modules_father_id'])));
            $i++;
        }
        $arrayNavigation[$i] = $arrayHotelModules[$modules_id];
        $arrayNavigation[$i]['hotel_modules_name'] = empty($arrayNavigation[$i]['hotel_modules_name']) ? $arrayModules[$modules_id]['modules_name'] : $arrayNavigation[$i]['hotel_modules_name'];
        $arrayNavigation[$i]['modules_module'] = $arrayModules[$modules_id]['modules_module'];
        $arrayNavigation[$i]['hotel_modules_ico'] = $arrayModules[$modules_id]['modules_ico'];
        $arrayNavigation[$i]['modules_action'] = $arrayModules[$modules_id]['modules_action'];
        $arrayNavigation[$i]['url'] = '#';
        return $arrayNavigation;
    }

    public static function getPageModuleLaguage($modules_module, $laguage = '简体中文') {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('page_module'=>$modules_module, 'laguage'=>$laguage);
        return LaguageDao::instance('\hotel\LaguageDao')->getPageModuleLaguage($conditions);
    }

}