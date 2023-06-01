import lombok.Setter;
import lombok.SneakyThrows;
import org.apache.http.HttpHeaders;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.security.web.authentication.Http403ForbiddenEntryPoint;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Setter
@ConfigurationProperties(prefix = "api")
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // TODO: Needs to be added via the application.yml
    private List<String> validApiTokens;

    @Override
    protected void configure(HttpSecurity http) {
        ApiTokenHeaderFilter filter = new ApiTokenHeaderFilter();
        filter.setAuthenticationManager(this::validateApiToken);

        addApiTokenAuthenticationToCriticalEndpoint(http, filter);
    }

    @SneakyThrows
    private void addApiTokenAuthenticationToCriticalEndpoint(HttpSecurity http, ApiTokenHeaderFilter filter) {
        http.csrf()
            .disable()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            .and()
            .addFilter(filter)
            .addFilterBefore(new ExceptionTranslationFilter(new Http403ForbiddenEntryPoint()), filter.getClass())
            .authorizeRequests()
            .antMatchers("/one/endpoint/**").authenticated()
            .antMatchers("/another/endpoint/**").authenticated()
            .anyRequest()
            .permitAll();
    }

    private Authentication validateApiToken(Authentication authentication) {
        String principal = (String) authentication.getPrincipal();

        if (!validApiTokens.contains(principal)) {
            throw new BadCredentialsException("The API token is invalid.");
        }

        authentication.setAuthenticated(true);
        return authentication;
    }

    private static class ApiTokenHeaderFilter extends AbstractPreAuthenticatedProcessingFilter {

        @Override
        protected Object getPreAuthenticatedPrincipal(HttpServletRequest request) {
            return request.getHeader(HttpHeaders.AUTHORIZATION);
        }

        @Override
        protected Object getPreAuthenticatedCredentials(HttpServletRequest request) {
            return "N/A";
        }
    }
}
