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
        $objResponse -> navigation = 'index';
        $objResponse -> setTplValue('navigation', 'index');
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
            case 'noPermission':
                $this->doNoPermission($objRequest, $objResponse);
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
        
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/index");
    }

    /**
     * 首页显示
     */
    protected function doNoPermission($objRequest, $objResponse) {
        //赋值
        //设置类别

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/noPermission");
    }

    protected function admin_content($objRequest, $objResponse) {
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/admin_content");
    }

    protected function employee_login($objRequest, $objResponse) {
        $arrayLoginInfo['username'] = trim($objRequest->username);
        $arrayLoginInfo['employee_password'] = trim($objRequest->password);
        $remember_me = $objRequest->remember_me;
        $method = $objRequest->method;
        if($method == 'logout') {
            LoginService::logout();
            redirect(__WEB);
        }
        $error_login = 0;
        if(!empty($arrayLoginInfo['username']) && !empty($arrayLoginInfo['employee_password'])) {
            $arrayEmployeeInfo = null;
            if(strpos($arrayLoginInfo['username'], '@') !== false) {
                $arrayEmployeeInfo = LoginService::loginEmployee(array('employee_email'=>$arrayLoginInfo['username']));
            } elseif (strlen($arrayLoginInfo['username']) == 11 && is_numeric($arrayLoginInfo['username'])) {
                $arrayEmployeeInfo = LoginService::loginEmployee(array('employee_mobile'=>$arrayLoginInfo['username']));
            } else {
                $arrayEmployeeInfo = LoginService::loginEmployee(array('employee_name'=>$arrayLoginInfo['username']));
            }
            if(!empty($arrayEmployeeInfo)) {
                $lenght = count($arrayEmployeeInfo);
                for($i = 0; $i < $lenght; $i++) {
                    if (md5(md5($arrayLoginInfo['employee_password']) . md5($arrayEmployeeInfo[$i]['employee_password_salt'])) == $arrayEmployeeInfo[$i]['employee_password']) {
                        LoginService::setLoginEmployeeCookie($arrayEmployeeInfo[$i], $remember_me);
                        redirect(__WEB);
                        break;
                    }
                }
                $error_login = 1;
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