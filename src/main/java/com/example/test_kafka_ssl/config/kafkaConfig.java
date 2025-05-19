package com.example.test_kafka_ssl.config;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class kafkaConfig {
    @Bean
    public NewTopic createTopic() {
        return new NewTopic("test-topic", 1, (short) 1);
    }
}
