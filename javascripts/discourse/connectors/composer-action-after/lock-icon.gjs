import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { on } from "@ember/modifer";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { i18n } from "discourse-i18n";

export default class LockIcon extends Component {
  @service composer;
  @service toasts;

  get composerDisabledSubmit() {
    return this.composer.disableSubmit;
  }

  @action
  toggleComposerLocked() {
    if (this.composerDisabledSubmit) {
      this.composer.disableSubmit = false;
      this.toasts.success({
        duration: "short",
        data: { message: i18n("composer_unlocked") }
      });
    } else {
      this.composer.disableSubmit = true;
      this.toasts.success({
        duration: "short",
        data: { message: i18n("composer_locked") }
      });
    }
  }

  <template>
    <DButton
      @icon={{if this.composerDisabledSubmit "unlock" "lock"}}
      @title={{if this.composerDisabledSubmit (themePrefix "unlock_composer_button_title") (themePrefix "lock_composer_button_title")}}
      @action={{this.toggleComposerLocked}}
      class="btn btn-icon"
    />
  </template>
}
