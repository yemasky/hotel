<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class NightAuditAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {

    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $thisDay = $objRequest -> time_begin;
        $thisDay = empty($thisDay) ? getDay() : $thisDay;
        //赋值
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> thisDay = $thisDay;
        $objResponse -> nextYear = $objResponse -> nextYear = $objResponse -> thisYear + 1;

        $objResponse -> module = $objRequest->module;
        $objResponse -> search_url = \BaseUrlUtil::Url('');
        //设置类别
    }
}