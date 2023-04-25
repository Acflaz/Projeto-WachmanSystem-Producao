package com.mycompany.exemplo.banco;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;

public class Conexao {
    private JdbcTemplate conexaoDoBanco;

    public Conexao() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        dataSource.setUrl("jdbc:sqlserver://srv-watchmansystem.database.windows.net:1433;database=watchmansystem;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net");
        dataSource.setUsername("admin-projeto");
        dataSource.setPassword("#Gfgrupo2");
        
        this.conexaoDoBanco = new JdbcTemplate(dataSource);
    }
    
    public JdbcTemplate getConexaoDoBanco(){
        return conexaoDoBanco;
    }
}
