<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class IndexAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        if($objRequest->getAction() != 'login') {
            $objResponse->arrEmployeeInfo = LoginService::checkLoginEmployee();
        }
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'admin_content':
                $this->admin_content($objRequest, $objResponse);
                break;
            case 'login':
                $this->employee_login($objRequest, $objResponse);
                break;
            case 'logout':
                $this->employee_login($objRequest, $objResponse);
                break;
            case 'register':
                $this->employee_register($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        //赋值
        //设置类别
        $objResponse -> nav = 'index';
        $objResponse -> setTplValue('merchantMenu', $objResponse->arrMerchantMenu);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/index");
    }

    protected function admin_content($objRequest, $objResponse) {
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/admin_content");
    }

    protected function employee_login($objRequest, $objResponse) {
        $arrayLoginInfo['employee_email'] = $objRequest->username;
        $arrayLoginInfo['employee_password'] = $objRequest->password;
        $remember_me = $objRequest->remember_me;
        $method = $objRequest->method;
        if($method == 'logout') {
            LoginService::logout();
            redirect(__WEB);
        }
        $error_login = 0;
        if(!empty($arrayLoginInfo['employee_email']) && !empty($arrayLoginInfo['employee_password'])) {
            $arrayEmployeeInfo = LoginService::loginEmployee(array('employee_email'=>$arrayLoginInfo['employee_email']));
            if(!empty($arrayEmployeeInfo)) {
                LoginService::setLoginEmployeeCookie($arrayEmployeeInfo, $remember_me);
                redirect(__WEB);
            } else {
                $error_login = 1;
            }
        }
        $objResponse -> setTplValue('error_login', $error_login);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/employee_login");
    }
}