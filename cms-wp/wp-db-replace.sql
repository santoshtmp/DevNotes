-- options --
UPDATE wp_options
SET option_value = REPLACE(option_value, 'http://old-domain.com', 'https://new-domain.com')
WHERE option_name IN ('siteurl', 'home');

UPDATE wp_options
SET option_value = REPLACE(option_value, 'https://naami.test.np/', '/')
WHERE option_value LIKE '%old-domain.com%';


-- post content --
UPDATE wp_posts
SET post_content = REPLACE(post_content, 'https://naami.test.np/', '/');

-- post meta --
UPDATE wp_postmeta
SET meta_value = REPLACE(meta_value, 'https://naami.test.np/', '/')
WHERE meta_value LIKE '%naami.test.np%';



