/*
 * -----------------------------------------------------------------------------
 * Title:       Databricks AI Functions Playground
 * Description: Exploring 12 LLM-powered SQL functions in Databricks.
 * Author:      SRESTA AAKULA/SRESTA-STARS1111
 * License:     Apache License, Version 2.0
 * -----------------------------------------------------------------------------
 */

-- 1. ai_query(): The "Jack of All Trades"
-- Perfect for custom prompts using specific Foundation Model endpoints.
SELECT ai_query(
    'databricks-meta-llama-3-1-70b-instruct',
    'Describe Databricks SQL in 30 words.'
) AS summary;

-- Using column values (pickup_zip) to augment the prompt dynamically.
SELECT *,
  ai_query(
    'databricks-meta-llama-3-1-70b-instruct',
    "Return only the US state name for ZIP code: " || pickup_zip
    ) AS state_name
  FROM samples.nyctaxi.trips
  LIMIT 10;


-- 2. ai_summarize(): Content Condensing
-- Boils down long text into a specific word count (default 50).
SELECT ai_summarize(
    'Apache Spark is a unified analytics engine for large-scale data processing. ' ||
    'It provides high-level APIs in Java, Scala, Python and R, and an optimized ' ||
    'engine that supports general execution graphs...',
    20
) AS spark_summary;


-- 3. ai_translate(): Language Localization
-- Automatically detects source and translates to target (e.g., 'ko' for Korean).
SELECT ai_translate(
    'Perception, Reasoning, Planning, Action, and Reflection', 
    'ko'
) AS agentic_ai_korean;


-- 4. ai_analyze_sentiment(): Sentiment Analysis
-- Categorizes the "vibe" as positive, negative, or neutral.
SELECT ai_analyze_sentiment('오늘 날씨가 정말 좋아서 기분이 행복해요') AS mood;


-- 5. ai_classify(): Zero-Shot Classification
-- Sorting text into custom buckets without training a model.
SELECT ai_classify("My password is leaked.", ARRAY("urgent", "not urgent")) AS status;


-- 6. ai_extract(): Structured Data Extraction
-- Pulling entities out of messy strings into a JSON format.
SELECT ai_extract(
    "John (70) can be reached at john@example.com", 
    ARRAY("name", "age", "email")
) AS user_details;


-- 7. ai_fix_grammar(): Automated Proofreading
-- Correcting syntax and style in-flight.
SELECT ai_fix_grammar("You seem to not care of anything") AS corrected_text;


-- 8. ai_gen(): Quick Text Generation
-- A simplified wrapper for ai_query for general tasks.
SELECT ai_gen("What does agentic flow in ML mean in under 3 sentences?") AS definition;


-- 9. ai_mask(): PII Redaction
-- Identifying and hiding sensitive data for privacy compliance.
SELECT ai_mask(
    "John works at Microsoft earning 100 billion dollars.",
    ARRAY("person", "organization", "money")
) AS redacted_pii;


-- 10. ai_similarity(): Semantic Distance
-- Comparing how "close" two strings are in meaning (returns 0.0 to 1.0).
SELECT ai_similarity('Machine Learning', 'Artificial Intelligence') AS semantic_score;


-- 11. ai_forecast(): Time-Series Prediction (TVF)
-- Note: Forecasts future values based on historical table data.
/*
SELECT * FROM ai_forecast(
  TABLE(my_historical_data),
  horizon => '2026-12-31',
  time_col => 'ds',
  value_col => 'y'
);
*/


-- 12. ai_query (Advanced): Model Self-Awareness
-- Asking the model to list its own capabilities or best practices.
SELECT ai_query(
    'databricks-meta-llama-3-1-70b-instruct',
    'List 5 best practices for prompt engineering in Databricks SQL.'
) AS pro_tips;
