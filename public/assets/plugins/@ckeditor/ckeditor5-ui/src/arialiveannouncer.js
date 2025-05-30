/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */
import View from './view.js';
import '../theme/components/arialiveannouncer/arialiveannouncer.css';
/**
 * The politeness level of an `aria-live` announcement.
 *
 * Available keys are:
 * * `AriaLiveAnnouncerPoliteness.POLITE`,
 * * `AriaLiveAnnouncerPoliteness.ASSERTIVE`
 *
 * [Learn more](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/ARIA_Live_Regions#Politeness_levels).
 */
export const AriaLiveAnnouncerPoliteness = {
    POLITE: 'polite',
    ASSERTIVE: 'assertive'
};
/**
 * An accessibility helper that manages all ARIA live regions associated with an editor instance. ARIA live regions announce changes
 * to the state of the editor features.
 *
 * These announcements are consumed and propagated by screen readers and give users a better understanding of the current
 * state of the editor.
 *
 * To announce a state change to an editor use the {@link #announce} method:
 *
 * ```ts
 * editor.ui.ariaLiveAnnouncer.announce( 'Text of an announcement.' );
 * ```
 */
export default class AriaLiveAnnouncer {
    /**
     * @inheritDoc
     */
    constructor(editor) {
        this.editor = editor;
        /**
         * Some screen readers only look at changes in the aria-live region.
         * They might not read a region that already has content when it is added.
         * To stop this problem, make sure to set up regions for all politeness settings when the editor starts.
         */
        editor.once('ready', () => {
            for (const politeness of Object.values(AriaLiveAnnouncerPoliteness)) {
                this.announce('', politeness);
            }
        });
    }
    /**
     * Sets an announcement text to an aria region that is then announced by a screen reader to the user.
     *
     * If the aria region of a specified politeness does not exist, it will be created and can be re-used later.
     *
     * The default announcement politeness level is `'polite'`.
     *
     * ```ts
     * // Most screen readers will queue announcements from multiple aria-live regions and read them out in the order they were emitted.
     * editor.ui.ariaLiveAnnouncer.announce( 'Image uploaded.' );
     * editor.ui.ariaLiveAnnouncer.announce( 'Connection lost. Reconnecting.' );
     * ```
     */
    announce(announcement, attributes = AriaLiveAnnouncerPoliteness.POLITE) {
        const editor = this.editor;
        if (!editor.ui.view) {
            return;
        }
        if (!this.view) {
            this.view = new AriaLiveAnnouncerView(editor.locale);
            editor.ui.view.body.add(this.view);
        }
        const { politeness, isUnsafeHTML } = typeof attributes === 'string' ? {
            politeness: attributes
        } : attributes;
        let politenessRegionView = this.view.regionViews.find(view => view.politeness === politeness);
        if (!politenessRegionView) {
            politenessRegionView = new AriaLiveAnnouncerRegionView(editor, politeness);
            this.view.regionViews.add(politenessRegionView);
        }
        politenessRegionView.announce({
            announcement,
            isUnsafeHTML
        });
    }
}
/**
 * The view that aggregates all `aria-live` regions.
 */
export class AriaLiveAnnouncerView extends View {
    constructor(locale) {
        super(locale);
        this.regionViews = this.createCollection();
        this.setTemplate({
            tag: 'div',
            attributes: {
                class: [
                    'ck',
                    'ck-aria-live-announcer'
                ]
            },
            children: this.regionViews
        });
    }
}
/**
 * The view that represents a single `aria-live`.
 */
export class AriaLiveAnnouncerRegionView extends View {
    constructor(editor, politeness) {
        super(editor.locale);
        this.setTemplate({
            tag: 'div',
            attributes: {
                role: 'region',
                'aria-live': politeness,
                'aria-relevant': 'additions'
            },
            children: [
                {
                    tag: 'ul',
                    attributes: {
                        class: [
                            'ck',
                            'ck-aria-live-region-list'
                        ]
                    }
                }
            ]
        });
        editor.on('destroy', () => {
            if (this._pruneAnnouncementsInterval !== null) {
                clearInterval(this._pruneAnnouncementsInterval);
                this._pruneAnnouncementsInterval = null;
            }
        });
        this.politeness = politeness;
        this._domConverter = editor.data.htmlProcessor.domConverter;
        this._pruneAnnouncementsInterval = setInterval(() => {
            if (this.element && this._listElement.firstChild) {
                this._listElement.firstChild.remove();
            }
        }, 5000);
    }
    /**
     * Appends new announcement to region.
     */
    announce({ announcement, isUnsafeHTML }) {
        if (!announcement.trim().length) {
            return;
        }
        const messageListItem = document.createElement('li');
        if (isUnsafeHTML) {
            this._domConverter.setContentOf(messageListItem, announcement);
        }
        else {
            messageListItem.innerText = announcement;
        }
        this._listElement.appendChild(messageListItem);
    }
    /**
     * Return current announcements list HTML element.
     */
    get _listElement() {
        return this.element.querySelector('ul');
    }
}
