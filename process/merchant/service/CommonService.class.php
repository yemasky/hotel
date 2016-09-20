<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace merchant;
class CommonService extends \BaseService {
    public static function getMerchantMenu($mu_id) {
        $arrayUserModels = NULL;
        $arrayAuthorize = self::getMerchantUserAuthorize($mu_id);
        if(!empty($arrayAuthorize)) {
            $arrayMc_id = array();
            foreach($arrayAuthorize as $k => $v) {
                $arrayMc_id[] = $v['mc_id'];
            }
            $objModulesAuthorizeDao = new ModulesAuthorizeDao();
            $arrayUserModels = $objModulesAuthorizeDao->DBCache(1800)->getMerchantUserModules($arrayMc_id);
        }
        return $arrayUserModels;
    }

    public static function getMerchantUserAuthorize($mu_id) {
        $objModulesAuthorizeDao = new ModulesAuthorizeDao();
        return $objModulesAuthorizeDao->DBCache(1800)->getMerchantUserAuthorize($mu_id);
    }

    public static function getMerchantRate($m_id) {
        if(!empty(self::$arrayMerchantRate[$m_id])) return self::$arrayMerchantRate[$m_id];
        $arrayRates = MerchantDao::instance()->getMerchantRate($m_id);
        self::$arrayMerchantRate[$m_id] = $arrayRates[0];
        return self::$arrayMerchantRate[$m_id];
    }

    public static function getMerchantRatePrice($m_id, $price_source, $type) {
        $arrayMerchantRate = self::getMerchantRate($m_id);
        switch ($type) {
            case 'tourism':
                $price['wholesale'] = ceil($price_source * $arrayMerchantRate['m_rate_tourism']);//批发价
                $price['sell'] = ceil($price_source * $arrayMerchantRate['m_rate_tourism_sell']);//售卖价
                break;
            case 'hotel':
                $price['wholesale'] = ceil($price_source * $arrayMerchantRate['m_rate_hotel']);//批发价
                $price['sell'] = ceil($price_source * $arrayMerchantRate['m_rate_hotel_sell']);//售卖价
                break;
            case 'air_ticket':
                $price['wholesale'] = ceil($price_source * $arrayMerchantRate['m_rate_air_ticket']);//批发价
                $price['sell'] = ceil($price_source * $arrayMerchantRate['m_rate_air_ticket_sell']);//售卖价
                break;
        }
        return $price;
    }

}