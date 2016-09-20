<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace merchant;


class IndexAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        if($objRequest->getAction() != 'login') {
            $objResponse->arrUserInfo = LoginService::checkLoginUser();
            $objResponse->arrMerchantMenu = CommonService::getMerchantMenu($objResponse->arrUserInfo['mu_id']);
        }
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'admin_content':
                $this->admin_content($objRequest, $objResponse);
                break;
            case 'login':
                $this->admin_login($objRequest, $objResponse);
                break;
            case 'logout':
                $this->admin_logout($objRequest, $objResponse);
                break;
            case 'register':
                $this->admin_register($objRequest, $objResponse);
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
        $objResponse -> setTplName("merchant/index");
    }

    protected function admin_content($objRequest, $objResponse) {
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("merchant/admin_content");
    }

    protected function admin_login($objRequest, $objResponse) {
        $arrayLoginInfo['mu_login_email'] = $objRequest->username;
        $arrayLoginInfo['mu_login_password'] = $objRequest->password;
        $remember_me = $objRequest->remember_me;
        $method = $objRequest->method;
        if($method == 'logout') {
            LoginService::logout();
            redirect(__WEB);
        }
        $error_login = 0;
        if(!empty($arrayLoginInfo['mu_login_email']) && !empty($arrayLoginInfo['mu_login_password'])) {
            $arrayUserInfo = LoginService::loginUser($arrayLoginInfo);
            if(!empty($arrayUserInfo)) {
                $arrayUserInfo['mu_login_email'] = $arrayLoginInfo['mu_login_email'];
                LoginService::setLoginUserCookie($arrayUserInfo, $remember_me);
                redirect(__WEB);
            } else {
                $error_login = 1;
            }
        }
        $objResponse -> setTplValue('error_login', $error_login);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("merchant/admin_login");
    }
}