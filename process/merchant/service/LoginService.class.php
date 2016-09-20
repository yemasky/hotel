<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 23:55
 */
namespace merchant;
class LoginService extends \BaseService {
    private static $loginKey = 'loginuser';

    public static function loginUser($arrayLoginInfo){
        //$objMerchantUserDao = new MerchantUserDao();
        //return $objMerchantUserDao->getLoginUser($arrayLoginInfo);
        return MerchantUserDao::instance('\merchant\MerchantUserDao')->getLoginUser($arrayLoginInfo);
    }
    
    public static function getLoginUser($objCookie = NULL, $isSession = false) {
        if(!is_object($objCookie) && $isSession == false){
            $objCookie = new \Cookie;
        }
        $loginKey = self::$loginKey . date("z");
        if($isSession == false) {
            $loginuser = $objCookie -> $loginKey;
            if(empty($loginuser)) {//只针对cookie用户 session保存1个月占服务器太长时间
                $loginKey = self::$loginKey . 2592000;//一个月
                $loginuser = $objCookie -> $loginKey;
            }
        } else {
            $objSession = new \Session();
            $loginuser = $objSession -> $loginKey;
        }

        if(!empty($loginuser)) {
            $arrUser = explode("\t", $loginuser);
            $arrUserInfo['mu_id'] = $arrUser[0];
            $arrUserInfo['m_id'] = $arrUser[1];
            $arrUserInfo['mu_login_email'] = $arrUser[2];
            $arrUserInfo['mu_nickname'] = $arrUser[3];
            return $arrUserInfo;
        }
        return NULL;
    }

    public static function checkLoginUser($objCookie = NULL, $isSession = false) {
        if(!is_object($objCookie) && $isSession == false){
            $objCookie = new \Cookie();
        }
        if($isSession == false) {
            $arrUserInfo = self::getLoginUser($objCookie);
        } else {
            $arrUserInfo = self::getLoginUser(NULL, true);
        }
        if(empty($arrUserInfo)) redirect(__WEB . 'index.php?action=login');
        return $arrUserInfo;
    }

    public static function setLoginUserCookie($arrayLoginUserInfo, $remember_me = false) {
        $cookieUser = $arrayLoginUserInfo['mu_id'] . "\t" . $arrayLoginUserInfo['m_id'] . "\t" . $arrayLoginUserInfo['mu_login_email'] . "\t" . $arrayLoginUserInfo['mu_nickname'];
        $objCookie = new \Cookie();
        $time = NULL;
        $key = date("z");
        if($remember_me) {
            $time = 2592000;//一个月
            $key = $time;
        }
        $objCookie->setCookie(self::$loginKey . $key, $cookieUser, $time);
    }

    public static function logout() {
        $objCookie = new \Cookie();
        $loginKey = self::$loginKey . 2592000;//一个月
        unset($objCookie->$loginKey);
        $loginKey = self::$loginKey . date("z");
        unset($objCookie->$loginKey);
    }

    /**
     * @return string
     */
    public function getLoginKey() {
        return self::$loginKey;
    }

    /**
     * @param string $loginKey
     */
    public function setLoginKey($loginKey) {
        self::$loginKey = $loginKey;
    }

}