<!DOCTYPE html>
<html lang="en">
<#include "../common/header.ftl">
<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">后台</a>
        <a href="">管理</a>
        <a>
          <cite>作品列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so">
            <input type="text" name="username"  placeholder="请输入标题" autocomplete="off" class="layui-input" value="${RequestParameters['title']!''}" />
            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn" onclick="x_admin_show('添加作品', '/admin/work/add')"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：${info.getTotalElements()} 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>作品ID</th>
            <th>标题</th>
            <th>所属商家账号</th>
            <th>所属商家昵称</th>
            <th>资源类型</th>
            <th>封面</th>
            <th>添加时间</th>
            <th>收藏数</th>
            <th>浏览量</th>
            <th>下载量</th>
            <th>用户状态</th>
            <td>操作</td>
        </tr>
        </thead>
        <tbody>
        <#list info.content as v>
            <tr>
                <td>${v.id}</td>
                <td>${v.title!'-'}</td>
                <td>${v.adminName!'-'}</td>
                <td>${v.nickName!'-'}</td>
                <#if v.type == 1 >
                    <td>图片</td>
                <#else>
                    <td>视频</td>
                </#if>
                <td>
                    <img src="${v.coverImageUrl!'-'}" alt="${v.coverImageUrl!'-'}" /></td>
                <td>${v.createTime!'-'}</td>
                <td>${v.collectionCount!'0'}</td>
                <td>${v.visitCount!'0'}</td>
                <td>${v.downloadCount!'0'}</td>
                <td class="td-status">
                    <#if v.status == 1 >
                    <span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span>
                    <#else>
                    <span class="layui-btn layui-btn-normal layui-btn-mini layui-btn-disabled">已停用</span>
                    </#if>
                </td>
                <td class="td-manage">
                    <a onclick="member_stop(this, ${v.id})" href="javascript:;" <#if v.status == 1>title="启用"<#else>title="停用"</#if>>
                    <#if v.status == 1>
                    <i class="layui-icon">&#xe601;</i>
                    <#else>
                    <i class="layui-icon">&#xe62f;</i>
                    </#if>
                    </a>
                    <a title="编辑" onclick="x_admin_show('编辑', '/admin/work/edit?id=${v.id}')" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="member_del(this,'${v.id}')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>
    <div class="page">
        <div>
            ${html}
        </div>
    </div>

</div>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj,id){
        var title = $(obj).attr('title');
        if(title=='启用'){
            var text = '停用';
        }else{
            var text = '启用';
        }
        layer.confirm('确认'+text+'吗？',function(){
            $.ajax({
                url:"/admin/work/status",
                data:{'id':id},
                type:"post",
                dataType:"json",
                success:function(result){
                    if(result.code==200){
                        if(result.data==1){
                            $(obj).attr('title','启用');
                            $(obj).find('i').html('&#xe601;');
                            $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                            layer.msg('已启用!',{icon: 1,time:1000});
                        }else{
                            //发异步把用户状态进行更改
                            $(obj).attr('title','停用')
                            $(obj).find('i').html('&#xe62f;');

                            $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                            layer.msg('已停用!',{icon: 5,time:1000});
                        }
                    }else{
                        layer.msg(result.msg,{time:2000,anim:6});
                    }
                },
                error:function(){
                    layer.msg('网络繁忙',{time:2000,anim:6});
                }
            })
        });
    }


    /*用户-删除*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？',function(){
            $.ajax({
                url:"/admin/work/delete",
                data:{"id":id,},
                type:"post",
                dataType:"json",
                success:function(result){
                    if(result.code==200){
                        layer.msg('删除成功',{icon:1,anim:1,time:1000},function(){
                            $(obj).parents("tr").remove();
                        });
                    }else{
                        layer.msg('删除失败',{anim:6,time:2000});
                    }
                },
                error:function(){
                    layer.msg('网络繁忙',{anim:6});
                }
            });
        });
    }
</script>
</body>

</html>