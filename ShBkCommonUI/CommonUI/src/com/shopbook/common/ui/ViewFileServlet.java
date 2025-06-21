package com.shopbook.common.ui;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet(name = "ViewFileServlet", urlPatterns = { "/viewfileservlet" })
public class ViewFileServlet extends HttpServlet {
    private static final int DEFAULT_BUFFER_SIZE = 10240; // 10KB

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getParameter("path");
        InputStream inputStream = null;

        try {
            File file = new File(path);
            if (file.exists() && file.isFile()) {
                inputStream = new FileInputStream(file);

                // Detect MIME type
                String mimeType = getServletContext().getMimeType(file.getName());
                if (mimeType == null) {
                    mimeType = "application/pdf"; // fallback if undetectable
                }
                response.setContentType(mimeType);

                // Tell browser to display inline (important for PDF)
                response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

            } else {
                // Fallback to default image
                inputStream = getServletContext().getResourceAsStream("/images/NoImage.png");
                if (inputStream == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Fallback image not found.");
                    return;
                }
                response.setContentType("image/png");
                response.setHeader("Content-Disposition", "inline; filename=\"NoImage.png\"");
            }

            // Stream the file or image
            try (BufferedInputStream in = new BufferedInputStream(inputStream);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error serving file.");
        }
    }
}
