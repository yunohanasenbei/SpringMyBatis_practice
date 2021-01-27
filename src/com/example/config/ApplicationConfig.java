package com.example.config;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.support.ResourcePatternUtils;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan(basePackages = "com.example")//探す範囲のフォルダ指定
@EnableWebMvc //これを入れたら、クラスにimplements WebMvcConfigurerを記述
@EnableTransactionManagement
@MapperScan("com.example.dao")
public class ApplicationConfig implements WebMvcConfigurer{

	//ViewResolverの設定(Springが使用する特別な設定なので、メソッド名を変えない）
	@Bean
	public ViewResolver viewResolver() {
		var viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/view/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	//MultipartResolverの設定

	@Bean
	public MultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}


	//静的ファイルの有効化
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/images/**").addResourceLocations("/images/");
		registry.addResourceHandler("/css/**").addResourceLocations("/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("/js/");

	}

	//バリデーションメッセージのカスタマイズ
	@Override
	public Validator getValidator() {
		var validator = new LocalValidatorFactoryBean();
		validator.setValidationMessageSource(messageSource());
		return validator;
	}

	@Bean
	public ResourceBundleMessageSource messageSource() {
		var messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("messages");
		return messageSource;
	}

	//DB関連の設定(c3p0)
	@Bean
	public DataSource dataSource() throws Exception {
		InitialContext ctx = new InitialContext();
		return (DataSource) ctx.lookup("java:comp/env/jdbc/mydb2");
		}
	//↑上で設定したDBをNamedParameter～で使用する定義
	@Bean
	public SqlSessionFactoryBean sqlSessionFactory() throws Exception {
	var factory = new SqlSessionFactoryBean();
	var resolver = ResourcePatternUtils
	.getResourcePatternResolver(new DefaultResourceLoader());
	factory.setDataSource(dataSource());
	factory.setMapperLocations(resolver
	.getResources("classpath:**/dao/**/*.xml"));
	return factory;
	}

	//@EnableTransactionManagementアノテーションとセット
	@Bean
	public DataSourceTransactionManager txManagr() throws Exception {
		return new DataSourceTransactionManager(dataSource());
	}



}
