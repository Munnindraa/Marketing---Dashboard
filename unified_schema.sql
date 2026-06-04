CREATE OR REPLACE TABLE `marketing_ads.unified_ad_performance` AS

SELECT
  date,
  'Facebook' AS platform,
  campaign_id,
  campaign_name,
  ad_set_id  AS ad_group_id,
  ad_set_name AS ad_group_name,
  impressions,
  clicks,
  spend,
  conversions,
  video_views,
  engagement_rate,
  reach,
  frequency,
  NULL  AS conversion_value,
  NULL  AS quality_score,
  NULL  AS search_impression_share,
  NULL  AS video_watch_25,
  NULL  AS video_watch_50,
  NULL  AS video_watch_75,
  NULL  AS video_watch_100,
  NULL  AS social_likes,
  NULL  AS social_shares,
  NULL  AS social_comments,
 
  SAFE_DIVIDE(clicks, impressions) AS ctr,
  SAFE_DIVIDE(spend, conversions) AS cpa,
  SAFE_DIVIDE(spend, impressions) * 1000 AS cpm
FROM `marketing_ads.facebook_ads`

UNION ALL

SELECT
  date,
  'Google' AS platform,
  campaign_id,
  campaign_name,
  ad_group_id,
  ad_group_name,
  impressions,
  clicks,
  cost AS spend,
  conversions,
  NULL  AS video_views,
  ctr  AS engagement_rate,
  NULL AS reach,
  NULL AS frequency,
  conversion_value,
  quality_score,
  search_impression_share,
  NULL, NULL, NULL, NULL,
  NULL, NULL, NULL,
  SAFE_DIVIDE(clicks, impressions)  AS ctr,
  SAFE_DIVIDE(cost, conversions)  AS cpa,
  SAFE_DIVIDE(cost, impressions) * 1000 AS cpm
FROM `marketing_ads.google_ads`

UNION ALL

SELECT
  date,
  'TikTok'  AS platform,
  campaign_id,
  campaign_name,
  adgroup_id  AS ad_group_id,
  adgroup_name  AS ad_group_name,
  impressions,
  clicks,
  cost  AS spend,
  conversions,
  video_views,
  SAFE_DIVIDE(clicks, impressions) AS engagement_rate,
  NULL AS reach,
  NULL AS frequency,
  NULL AS conversion_value,
  NULL AS quality_score,
  NULL AS search_impression_share,
  video_watch_25,
  video_watch_50,
  video_watch_75,
  video_watch_100,
  likes AS social_likes,
  shares AS social_shares,
  comments AS social_comments,
  SAFE_DIVIDE(clicks, impressions) AS ctr,
  SAFE_DIVIDE(cost, conversions)  AS cpa,
  SAFE_DIVIDE(cost, impressions) * 1000  AS cpm
FROM `marketing_ads.tiktok_ads`;