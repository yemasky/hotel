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
            $arrayEmployeeModules = CommonService::getEmployeeModules($objResponse->arrayLoginEmployeeInfo);
            $objResponse -> setTplValue('arrayEmployeeModules', $arrayEmployeeModules);
        }
    }

    protected function service($objRequest, $objResponse) {
        $module = trim($objRequest->module);
        $action = $objRequest->action;
        $this->setDisplay();
        if(!empty($module)) {
            $module = '\hotel\\' . ucwords($_REQUEST['module']) . 'Action';
        } else {
            $module = '\hotel\IndexAction';
        }
        $objAction = new $module();
        $objAction->execute($action, $objRequest, $objResponse);//
    }
}