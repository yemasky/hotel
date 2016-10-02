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
        $module_action_tpl = 'index';
        $modules_module = 'index';

        if(!empty(decode($objRequest->company_id))) {//公司权限
            $conditions = \DbConfig::$db_query_conditions;
            $conditions['where'] = array('employee_id'=>$objResponse->arrayLoginEmployeeInfo['employee_id']);
            $arrayCompanyId = EmployeeService::getEmployeeCompany($conditions, 'company_id');
            $company_id = decode($objRequest->company_id);
            if(!isset($arrayCompanyId[$company_id])) {
                $module_action_tpl = $action = 'noPermission';
                $modules_id = null;
            }
        }

        if(!empty($modules_id)) {
            $arrayRoleModulesEmployeePermissions = RoleService::getRoleModulesEmployee($objResponse->arrayLoginEmployeeInfo['employee_id']);
            if(!isset($arrayRoleModulesEmployeePermissions[$modules_id])) {
                //无权限
                $module_action_tpl = $action = 'noPermission';
            } else {
                $arrayModules = ModulesService::getModules();
                if(isset($arrayModules[$modules_id])) {
                    $arrayModule = $arrayModules[$modules_id];
                    $module = '\hotel\\' . ucwords($arrayModule['modules_module']) . 'Action';
                    if(!empty($arrayModule['modules_action'])) {
                        $action = $arrayModule['modules_action'];
                    }
                    $modules_module = $arrayModule['modules_module'];
                    $module_action_tpl = empty($action) ? $arrayModule['modules_module'] : $arrayModule['modules_module'] . '_' . $action;

                    //权限
                    $objResponse->arrayRoleModulesEmployeePermissions = $arrayRoleModulesEmployeePermissions;
                    $objResponse->setTplValue('arrayRoleModulesEmployee', $arrayRoleModulesEmployeePermissions[$modules_id]);
                    //语言

                }
            }
        }
        $arrayLaguage = CommonService::getPageModuleLaguage($modules_module);
        $objResponse->setTplValue('arrayLaguage', $arrayLaguage);
        //$objResponse->setTplValue('action', $module_action);
        //$objResponse->setTplValue("hashKey", \Encrypt::instance()->decode(date("Y-m-d") . __WEB_KEY));
        $objResponse->setTplName("hotel/modules_" . $module_action_tpl);
        $objAction = new $module();
        $objAction->execute($action, $objRequest, $objResponse);//
    }
}