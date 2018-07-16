package com.sunshine.Utils;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.sunshine.Dao.UserDaoMapper;
import com.sunshine.Model.User;

public class MyShiroReleam extends AuthorizingRealm {
	
	@Resource
	private UserDaoMapper userDaoMapper;
    /**
     * 获取权限
     */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection arg0) {
		
		return null;
	}
    /*登陆验证
     * (non-Javadoc)
     * @see org.apache.shiro.realm.AuthenticatingRealm#doGetAuthenticationInfo(org.apache.shiro.authc.AuthenticationToken)
     */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		String user_name=(String) token.getPrincipal();
		User user=userDaoMapper.getUserInfoRecordByName(user_name);
		if(user==null){
			return null;
		}
		SimpleAuthenticationInfo simpleAuthenticationInfo=new SimpleAuthenticationInfo(user, user.getPassword(), ByteSource.Util.bytes(token.getCredentials()), getName());
		return simpleAuthenticationInfo;
	}

}
