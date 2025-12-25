## ACF PRO 6.4 - no license required.
### Step to include

1. return true for acf_pro_is_license_active() function 

2. wp-content/plugins/advanced-custom-fields-pro/pro/acf-pro.php
	- line 48 
		- // add_action( 'acf/internal_post_type/current_screen', array( $this, 'invalid_license_redirect' ) );
		- // add_action( 'acf/internal_post_type_list/current_screen', array( $this, 'invalid_license_redirect_notice' ) );
	- line 323 
		- // $classes .= ' acf-pro-inactive-license';

3. wp-content/plugins/advanced-custom-fields-pro/includes/admin/views/acf-field-group/field.php
	- line 36 ! acf_pro_is_license_active() comment this
	```
	if ( acf_is_pro() && acf_get_field_type_prop( $field['type'], 'pro' ) && ! acf_pro_is_license_active() ) {
		// $field_type_label .= '<span class="acf-pro-label-field-type"><img src="' . esc_url( acf_get_url( 'assets/images/pro-chip.svg' ) ) . '" alt="' . esc_attr__( 'ACF PRO Logo', 'acf' ) . '"></span>';
		// if ( ! acf_pro_is_license_expired() ) {
		// 	$inactive_field_class = ' acf-js-tooltip';
		// 	$inactive_field_title = __( 'PRO fields cannot be edited without an active license.', 'acf' );
		// }
	}
	```


4. wp-content/plugins/advanced-custom-fields-pro/includes/admin/views/global/header.php
	- line 41 comment
	```
	if ( 'acf-ui-options-page' === $post_type && acf_is_pro() && ! acf_pro_is_license_active() ) {
		// $class .= ' disabled';
	}
	```

5. wp-content/plugins/advanced-custom-fields-pro/includes/admin/views/browse-fields-modal.php
	- line 74 comment
	```
	<a target="_blank" data-url-base="<?php echo esc_attr( $acf_upgrade_link ); ?>" class="acf-btn acf-btn-pro">
		<?php echo esc_html( $acf_upgrade_text ); ?>
	</a>
	```

6. wp-content/plugins/advanced-custom-fields-pro/assets/build/js/acf-field-group.min.js
	- Remove: this.$el.find(".acf-select-field").hide() 

7. wp-content/plugins/advanced-custom-fields-pro/assets/build/js/acf.min.js
	- Remove: (t.disabled?' disabled="disabled"':"")+

8. wp-content/plugins/advanced-custom-fields-pro/assets/build/js/acf-field-group.min.js
	- disabled="disabled"