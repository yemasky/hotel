<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class UploadAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'upload';
        $objResponse -> setTplValue('navigation', 'upload');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'uploadImages':
                $this->doUploadImages($objRequest, $objResponse);
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
    }

    protected function doUploadImages($objRequest, $objResponse) {
        $this->setDisplay();
        if($objRequest -> act == 'manager_img') {
            $this->doManagerImages($objRequest, $objResponse);
            return;
        }

        $upload_type = $objRequest->upload_type;
        $room_layout_id = decode($objRequest->room_layout_id);

        //定义允许上传的文件扩展名
        $ext_arr = array(
            'image' => array('gif', 'jpg', 'jpeg', 'png', 'bmp')
        );
        //最大文件大小
        $max_size = 204800;//200k

        //PHP上传失败
        if (!empty($_FILES['imgFile']['error'])) {
            switch($_FILES['imgFile']['error']){
                case '1':
                    $error = '超过php.ini允许的大小。';
                    break;
                case '2':
                    $error = '超过表单允许的大小。';
                    break;
                case '3':
                    $error = '图片只有部分被上传。';
                    break;
                case '4':
                    $error = '请选择图片。';
                    break;
                case '6':
                    $error = '找不到临时目录。';
                    break;
                case '7':
                    $error = '写文件到硬盘出错。';
                    break;
                case '8':
                    $error = 'File upload stopped by extension。';
                    break;
                case '999':
                default:
                    $error = '未知错误。';
            }
            $this->alert($error);
            return;
        }

        //有上传文件时
        if (empty($_FILES) === false) {
            //原文件名
            $file_name = $_FILES['imgFile']['name'];
            //服务器上临时文件名
            $tmp_name = $_FILES['imgFile']['tmp_name'];
            //文件大小
            $file_size = $_FILES['imgFile']['size'];
            //检查文件名
            if (!$file_name) {
                $this->alert("请选择文件。");
                return;
            }
            $save_path = __DEFAULT_IMG;
            $save_url = '';//__IMGWEB;
            //检查目录
            if (@is_dir($save_path) === false) {
                $this->alert("上传目录不存在。");
                return;
            }
            //检查目录写权限
            if (@is_writable($save_path) === false) {
                $this->alert("上传目录没有写权限。");
                return;
            }
            //检查是否已上传
            if (@is_uploaded_file($tmp_name) === false) {
                $this->alert("上传失败。");
                return;
            }
            //检查文件大小
            if ($file_size > $max_size) {
                $this->alert("上传文件大小超过限制。");
                return;
            }
            //检查目录名
            /*$dir_name = 'image';
            if (empty($ext_arr[$dir_name])) {
                $this->alert("目录名不正确。");
                return;
            }*/
            //获得文件扩展名
            $temp_arr = explode(".", $file_name);
            $file_ext = array_pop($temp_arr);
            $file_ext = trim($file_ext);
            $file_ext = strtolower($file_ext);
            //检查扩展名
            if (in_array($file_ext, $ext_arr['image']) === false) {
                $this->alert("上传文件扩展名是不允许的扩展名。\n只允许" . implode(",", $ext_arr['image']) . "格式。");
                return;
            }
            //创建文件夹
            /*if ($dir_name !== '') {
                $save_path .= $dir_name . "/";
                $save_url .= $dir_name . "/";
                if (!file_exists($save_path)) {
                    mkdir($save_path);
                }
            }*/
            $relative_file = '';
            $y = date("Y");
            $save_path .= $y . "/";
            $save_url .= $y . "/";
            $relative_file .= $y . "/";
            if (!file_exists($save_path)) {
                mkdir($save_path);
            }
            $md = date("md");
            $save_path .= $md . "/";
            $save_url .= $md . "/";
            $relative_file .= $md . "/";
            if (!file_exists($save_path)) {
                mkdir($save_path);
            }
            //新文件名
            $new_file_name = date("YmdHis") . '_' . rand(10000, 99999) . '.' . $file_ext;
            //移动文件
            $file_path = $save_path . $new_file_name;
            $relative_file = $relative_file . $new_file_name;
            if (move_uploaded_file($tmp_name, $file_path) === false) {
                $this->alert("上传文件失败。");
                return;
            }
            @chmod($file_path, 0644);
            $file_url = $save_url . $new_file_name;
            $id = '';
            if($upload_type == 'rooms_layout') {
                $id = RoomService::saveRoomLayoutImages(array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                    'room_layout_images_path'=>$relative_file,
                    'room_layout_id'=>$room_layout_id,
                    'room_layout_images_filesize'=>$file_size,
                    'room_layout_images_add_date'=>getDay(),
                    'room_layout_images_add_time'=>getTime()));
            }
            if($upload_type == 'hotel') {

            }
            header('Content-type: text/html; charset=UTF-8');
            echo json_encode(array('error' => 0, 'url' => $file_url, 'title'=>$id));
        }

        //赋值
    }

    protected function doManagerImages($objRequest, $objResponse) {
        $this->setDisplay();
        $ext_arr = array('gif', 'jpg', 'jpeg', 'png', 'bmp');
        $dir_name = __DEFAULT_IMG;
        $root_path = __DEFAULT_IMG;
        $root_url = __IMGWEB;
        $path = $objRequest -> path;
        if (empty($path)) {
            $current_path = $root_path;
            $current_url = $root_url;
            $current_dir_path = '';
            $moveup_dir_path = '';
        } else {
            $current_path = $root_path;
            $current_url = $root_url;
            $current_dir_path = $path;
            $moveup_dir_path = preg_replace('/(.*?)[^\/]+\/$/', '$1', $current_dir_path);
            $order = empty($objRequest -> order) ? 'name' : strtolower($objRequest -> order);
        }
        if (preg_match('/\.\./', $current_path)) {
            $this->alert('Access is not allowed.');
            return;
        }
        //最后一个字符不是/
        if (!preg_match('/\/$/', $current_path)) {
            $this->alert('Parameter is not valid.');
            return;
        }
        $hotel = $objResponse->arrayLaguage['hotel']['page_laguage_value'];
        $room_layout = $objResponse->arrayLaguage['room_layout']['page_laguage_value'];
        $file_list = array();
        if(empty($path)) {
            for($i = 0; $i < 2; $i++) {
                $file_list[$i]['is_dir'] = true; //是否文件夹
                $file_list[$i]['has_file'] = true; //文件夹是否包含文件
                $file_list[$i]['filesize'] = 555; //文件大小
                $file_list[$i]['is_photo'] = false; //是否图片
                $file_list[$i]['filetype'] = ''; //文件类别，用扩展名判断
                $file_list[$i]['filename'] =  $hotel;//文件名，包含扩展名
                if($i == 1) {
                    $file_list[$i]['filename'] = $room_layout; //文件名，包含扩展名
                }
                $file_list[$i]['datetime'] = date('Y-m-d H:i:s'); //文件最后修改时间
            }
        } else {
            if(strpos($path, $hotel) !== false) {

            } elseif (strpos($path, $room_layout) !== false) {
                $conditions = DbConfig::$db_query_conditions;
                $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
                $arrarImages = RoomService::getRoomLayoutImages($conditions);
                if(!empty($arrarImages)) {
                    foreach ($arrarImages as $k => $v) {
                        $file_list[$k]['is_dir'] = false;
                        $file_list[$k]['has_file'] = false;
                        $file_list[$k]['filesize'] = $v['room_layout_images_filesize'];
                        $file_list[$k]['is_photo'] = true;
                        $temp_arr = explode(".", $v['room_layout_images_path']);
                        $file_ext = strtolower(trim(array_pop($temp_arr)));
                        $file_list[$k]['filetype'] = $file_ext;
                        $temp_arr = explode("/", $v['room_layout_images_path']);
                        //$file_list[$k]['filename'] = array_pop($temp_arr); //文件名，包含扩展名
                        $file_list[$k]['filename'] = $v['room_layout_images_path'];
                        array_pop($temp_arr);
                        $file_list[$k]['dir_path'] = implode('/', $temp_arr) . '/';
                        $file_list[$k]['datetime'] = $v['room_layout_images_add_date'] . ' ' . $v['room_layout_images_add_time']; //文件最后修改时间
                        $file_list[$k]['id'] = $v['room_layout_images_id'];
                    }
                }
            } else {
                $this->alert("读取失败！");
                return;
            }
        }



        $result = array();
        //相对于根目录的上一级目录
        $result['moveup_dir_path'] = $moveup_dir_path;
        //相对于根目录的当前目录
        $result['current_dir_path'] = $current_dir_path;
        //当前目录的URL
        $result['current_url'] = $current_url;
        //文件数
        $result['total_count'] = count($file_list);
        //文件列表数组
        $result['file_list'] = $file_list;

        //输出JSON字符串
        header('Content-type: application/json; charset=UTF-8');
        echo json_encode($result);

    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

    protected function alert($msg) {
        header('Content-type: text/html; charset=UTF-8');
        echo json_encode(array('error' => 1, 'message' => $msg));
    }
}