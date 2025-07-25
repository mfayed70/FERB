package com.aalm.master.view.filter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.web.filter.authc.UserFilter;

public class FacesAjaxAwareUserFilter extends UserFilter {
    private static final String FACES_REDIRECT_XML =
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "<partial-response><redirect " +
        "url=\"%s\"></redirect></partial-response>";

    @Override
    protected void redirectToLogin(ServletRequest req, ServletResponse res) throws IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        request.setCharacterEncoding("UTF-8");
        if ("partial/ajax".equals(request.getHeader("Faces-Request"))) {
            res.setContentType("text/xml");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().printf(FACES_REDIRECT_XML, request.getContextPath() + getLoginUrl());
        } else {
            req.setCharacterEncoding("UTF-8");
            super.redirectToLogin(req, res);
        }
    }
}
