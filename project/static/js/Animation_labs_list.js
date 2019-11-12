// 实验室名片hover效果
$(document).ready(function () {
    var lab_card = $(".lab_part");

    layui.use('element', function () {
        var element = layui.element;
        var $ = layui.jquery;
        var active = {
            tabAdd: function () {
                element.tabAdd('xbs_tab', {
                    title: "实验室详情",
                    content: "./lab_detail.html"
                })
            }
        };
        lab_card.on('click', function () {
            var that = $(this), type = that.data(type);
            active[type].call(this, that);
        });
    });
    lab_card.hover(
        function MouseIn() {
            $(this).animate({
                    // marginTop : -3,
                    // marginBottom : 20,
                    opacity: 0.8,
                },
                "fast"
            )
        },
        function MouseOut() {
            $(this).animate({
                    // marginTop : 5,
                    // marginBottom : 12,
                    opacity: 1,
                },
                "fast"
            )
        }
    )
});
layui.use('element', function(){
    var $ = layui.jquery
        ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

    //触发事件
    var active = {
        tabAdd: function(){
            //新增一个Tab项
            element.tabAdd('demo', {
                title: '新选项'+ (Math.random()*1000|0) //用于演示
                ,content: '内容'+ (Math.random()*1000|0)
                ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
            })
        }
        ,tabDelete: function(othis){
            //删除指定Tab项
            element.tabDelete('demo', '44'); //删除：“商品管理”


            othis.addClass('layui-btn-disabled');
        }
        ,tabChange: function(){
            //切换到指定Tab项
            element.tabChange('demo', '22'); //切换到：用户管理
        }
    };

    $('.site-demo-active').on('click', function(){
        var othis = $(this), type = othis.data('type');
        active[type] ? active[type].call(this, othis) : '';
    });

//Hash地址的定位
    var layid = location.hash.replace(/^#test=/, '');
    element.tabChange('test', layid);

    element.on('tab(test)', function(elem){
        location.hash = 'test='+ $(this).attr('lay-id');
    });
});
