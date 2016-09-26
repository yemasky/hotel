<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class Action extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        if($objRequest->getAction() != 'login') {
            $objResponse->arrayLoginEmployeeInfo = LoginService::checkLoginEmployee();
            $objResponse->arrayEmployeeModules = CommonService::getEmployeeModules($objResponse->arrayLoginEmployeeInfo);
            $arrayNavigation = CommonService::getNavigation($objResponse->arrayLoginEmployeeInfo, decode(trim($objRequest->module)));
            //
            $objResponse->setTplValue('arrayEmployeeModules', $objResponse -> arrayEmployeeModules);
            $objResponse->setTplValue('arrayNavigation', $arrayNavigation);
        }
    }

    protected function service($objRequest, $objResponse) {
        $modules_id = decode(trim($objRequest->module));
        $action = $objRequest->action;
        $this->setDisplay();
        $module = '\hotel\IndexAction';
        $defaultAction = 'index';
        if(!empty($modules_id)) {
            $arrayRoleModulesEmployee = RoleService::getRoleModulesEmployee($objResponse->arrayLoginEmployeeInfo['employee_id']);
            if(!isset($arrayRoleModulesEmployee[$modules_id])) {
                //无权限
                $action = 'noPermission';
            } else {
                $arrayModules = ModulesService::getModules();
                if(isset($arrayModules[$modules_id])) {
                    $arrayModule = $arrayModules[$modules_id];
                    $module = '\hotel\\' . ucwords($arrayModule['modules_module']) . 'Action';
                    if(!empty($arrayModule['modules_action'])) {
                        $action = $arrayModule['modules_action'];
                    }
                    $defaultAction = $arrayModule['modules_module'];
                    $arrayLaguage = CommonService::getPageModuleLaguage($arrayModule['modules_module']);
                    //权限
                    $objResponse->setTplValue('arrayRoleModulesEmployee', $arrayRoleModulesEmployee[$modules_id]);
                    //语言
                    $objResponse->setTplValue('arrayLaguage', $arrayLaguage);
                }
            }
        }

        $module_action = empty($action) ? $defaultAction : $action;
        $objResponse->setTplValue('action', $module_action);
        $objResponse->setTplName("hotel/modules");
        $objAction = new $module();
        $objAction->execute($action, $objRequest, $objResponse);//
    }
}