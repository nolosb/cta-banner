import Component from '@glimmer/component';
import { inject as service } from '@ember/service';
import { htmlSafe } from '@ember/template';
import { defaultHomepage } from 'discourse/lib/utilities';
import and from 'truth-helpers/helpers/and';
import i18n from 'discourse-common/helpers/i18n';

export default class CtaBanner extends Component {
  @service site;
  @service siteSettings;
  @service router;

  <template>
    {{#if (and this.showOnRoute this.showOnMobile)}}
      <div class='cta-banner__wrapper'>
        <div class='cta-banner__container'>
          <h3 class='cta-banner__message'>
            {{i18n (themePrefix 'cta_banner.message')}}</h3>
          <a
            class='cta-banner__button btn-default btn btn-text btn-primary'
            href='{{settings.cta_banner_link}}'
          >
            <span class='d-button-label'>
              {{i18n (themePrefix 'cta_banner.button_label')}}
            </span>
          </a>
        </div>
      </div>
    {{/if}}
  </template>

  get showOnRoute() {
    const currentRoute = this.router.currentRouteName;
    switch (settings.show_on) {
      case 'everywhere':
        return !currentRoute.includes('admin');
      case 'homepage':
        return currentRoute === `discovery.${defaultHomepage()}`;
      case 'latest/top/new/categories':
        const topMenu = this.siteSettings.top_menu;
        const targets = topMenu.split('|').map((opt) => `discovery.${opt}`);
        return targets.includes(currentRoute);
      default:
        return false;
    }
  }

  get showOnMobile() {
    if (settings.hide_on_mobile && this.site.mobileView) {
      return false;
    } else {
      return true;
    }
  }
}
