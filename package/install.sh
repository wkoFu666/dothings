#! /bin/sh

#参数的个数
PARAM_COUNT=$#

#当前路径，即install.sh文件所在的路径
WORK_DIR=`pwd`

#安装配置文件路径
GLOBE_COMMON_CONF=$WORK_DIR/globe.common.conf
INSTALL_CONFIG_SH=$WORK_DIR/install_config.sh

#替换掉\r字符。
sed -i "s/\r//" $GLOBE_COMMON_CONF
sed -i "s/\r//" $INSTALL_CONFIG_SH


#工程名
PROJECT_NAME=`cat $GLOBE_COMMON_CONF  | grep '^PROJECT_NAME' | cut -d= -f2`

#安装路径
INSTALL_PATH=`cat $GLOBE_COMMON_CONF  | grep '^INSTALL_PATH' | cut -d= -f2`


# Spring Boot项目部署
deploySpringBoot(){


}

#将globe.common.conf中的业务配置信息写入业务的xxx.properties文件中
configThirdProperties(){
    #执行业务配置
    source $INSTALL_CONFIG_SH
}

#定义记录日志的函数
writeLog(){
    # print time
    time=`date "+%D %T"`
    echo "[$time] : PROJECT-INSTALL : $*"
}


#初始化，检测环境
init() {

    #安装目录中是否有lib目录
    if [ ! -d $WORK_DIR/lib ]; then
        writeLog "ERROR: install package has no lib folder, install will exit"
        exit 1
    fi
}

# 备份程序，以防止出现安装新版本的时候安装失败且老版本已经被删除，导致系统不能使用的情况。备份文件最多只保留五份
backup() {
	# 程序安装路径（需要备份的目录路径）
	APP_DIR=${INSTALL_PATH}/${PROJECT_NAME}_install
	# 日期戳
	timeStamp=`date "+%Y%m%d%H%M%S"`
    BACKUP_DIR=${APP_DIR}_bak_${timeStamp}
    if [ -d "$APP_DIR" ];then
        if [ ! -d "$BACKUP_DIR" ];then
            # 如果程序的目录不存在，并且今天没有备份过
            writeLog "INFO: Backup app..."
            cp -rf ${APP_DIR} ${BACKUP_DIR}
        fi
    else
        #创建安装目录
        writeLog "INFO: install folder is not exist, I will make it for you!"
        mkdir -p ${INSTALL_PATH}/${PROJECT_NAME}_install
    fi


    #删除多余的备份文件
    declare -a bakFiles
    	declare -a bakDates
    	arrayIndex=0
    	regex="^${PROJECT_NAME}_install_bak_[0-9][0-9]*$"
    	FILES=`ls $INSTALL_PATH -t|grep $regex`
    	for file in $FILES
    	do
    		if [ ! -d $INSTALL_PATH/$file ];then
    			continue;
    		fi
    		date=`echo $file|awk -F "_" '{print $4}'`
    		## 4这个数字是自己安装目录名称改成备份名称后，用下划线分割后日期所在的位置！！！
    		## 例如：${PROJECT_NAME}_install_bak_20140127155258，则这个目录名用下划线分割后，20140127155258这个日期在第4个位置。
    		bakFiles[$arrayIndex]=$file
    		bakDates[$arrayIndex]=$date
    		arrayIndex=`expr $arrayIndex + 1`
    	done

    	if [ $arrayIndex -gt 5 ];then
    		for (( i=0; i<$arrayIndex; ++i ))
    		do
    			for (( j=$i+1; j<$arrayIndex; ++j ))
    			do
    				if [ ${bakDates[$i]} -lt ${bakDates[$j]} ];then
    					tmpName=${bakFiles[$i]}
    					tmpDate=${bakDates[$i]}
    					bakFiles[$i]=${bakFiles[$j]}
    					bakDates[$i]=${bakDates[$j]}
    					bakFiles[$j]=$tmpName
    					bakDates[$j]=$tmpDate
    				fi
    			done
    		done
    		for (( i=3; i<$arrayIndex; ++i ))
    		do
    			rm -rf $INSTALL_PATH/${bakFiles[$i]}
    		done
    	fi
}


#安装
install() {

    #初始化，检测环境
    init

    #备份
    backup

    #写入配置,配置第三方属性
    #configThirdProperties

    #部署Springboot项目
    deploySpringBoot
}

install
