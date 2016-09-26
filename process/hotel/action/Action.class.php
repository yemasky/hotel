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
            $objResponse->setTplValue('arrayEmployeeModules', $objResponse -> arrayEmployeeModules);
        }
    }

    protected function service($objRequest, $objResponse) {
        $module_id = decode(trim($objRequest->module));
        $action = $objRequest->action;
        $this->setDisplay();
        $module = '\hotel\IndexAction';
        $defaultAction = 'index';
        if(!empty($module_id)) {
            $arrayRoleModulesEmployee = RoleService::getRoleModulesEmployee($objResponse->arrayLoginEmployeeInfo['employee_id']);
            if(!isset($arrayRoleModulesEmployee[$module_id])) {
                //无权限
                $action = 'noPermission';
            } else {
                $arrayModules = ModulesService::getModules();
                if(isset($arrayModules[$module_id])) {
                    $arrayModule = $arrayModules[$module_id];
                    $module = '\hotel\\' . ucwords($arrayModule['modules_module']) . 'Action';
                    if(!empty($arrayModule['modules_action'])) {
                        $action = $arrayModule['modules_action'];
                    }
                    $defaultAction = $arrayModule['modules_module'];
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