import { apiInitializer } from 'discourse/lib/api';
import CtaBanner from '../components/cta-banner';

export default apiInitializer('1.14.0', (api) => {
  api.renderInOutlet(settings.plugin_outlet.trim(), CtaBanner);
});
