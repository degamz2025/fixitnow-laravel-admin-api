/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */
/**
 * @module ckfinder/ckfinderui
 */
import { icons, Plugin } from 'ckeditor5/src/core.js';
import { ButtonView, MenuBarMenuListItemButtonView } from 'ckeditor5/src/ui.js';
/**
 * Introduces UI components for `CKFinder` plugin.
 *
 * The plugin introduces two UI components to the {@link module:ui/componentfactory~ComponentFactory UI component factory}:
 *
 * * the `'ckfinder'` toolbar button,
 * * the `'menuBar:ckfinder'` menu bar component, which is by default added to the `'Insert'` menu.
 *
 * It also integrates with the `insertImage` toolbar component and `menuBar:insertImage` menu component.
 */
export default class CKFinderUI extends Plugin {
    /**
     * @inheritDoc
     */
    static get pluginName() {
        return 'CKFinderUI';
    }
    /**
     * @inheritDoc
     */
    init() {
        const editor = this.editor;
        editor.ui.componentFactory.add('ckfinder', () => this._createFileToolbarButton());
        editor.ui.componentFactory.add('menuBar:ckfinder', () => this._createFileMenuBarButton());
        if (editor.plugins.has('ImageInsertUI')) {
            editor.plugins.get('ImageInsertUI').registerIntegration({
                name: 'assetManager',
                observable: () => editor.commands.get('ckfinder'),
                buttonViewCreator: () => this._createImageToolbarButton(),
                formViewCreator: () => this._createImageDropdownButton(),
                menuBarButtonViewCreator: isOnly => this._createImageMenuBarButton(isOnly ? 'insertOnly' : 'insertNested')
            });
        }
    }
    /**
     * Creates the base for various kinds of the button component provided by this feature.
     */
    _createButton(ButtonClass) {
        const editor = this.editor;
        const locale = editor.locale;
        const view = new ButtonClass(locale);
        const command = editor.commands.get('ckfinder');
        view.bind('isEnabled').to(command);
        view.on('execute', () => {
            editor.execute('ckfinder');
            editor.editing.view.focus();
        });
        return view;
    }
    /**
     * Creates a simple toolbar button for files management, with an icon and a tooltip.
     */
    _createFileToolbarButton() {
        const t = this.editor.locale.t;
        const button = this._createButton(ButtonView);
        button.icon = icons.browseFiles;
        button.label = t('Insert image or file');
        button.tooltip = true;
        return button;
    }
    /**
     * Creates a simple toolbar button for images management, with an icon and a tooltip.
     */
    _createImageToolbarButton() {
        const t = this.editor.locale.t;
        const imageInsertUI = this.editor.plugins.get('ImageInsertUI');
        const button = this._createButton(ButtonView);
        button.icon = icons.imageAssetManager;
        button.bind('label').to(imageInsertUI, 'isImageSelected', isImageSelected => isImageSelected ? t('Replace image with file manager') : t('Insert image with file manager'));
        button.tooltip = true;
        return button;
    }
    /**
     * Creates a button for images management for the dropdown view, with an icon, text and no tooltip.
     */
    _createImageDropdownButton() {
        const t = this.editor.locale.t;
        const imageInsertUI = this.editor.plugins.get('ImageInsertUI');
        const button = this._createButton(ButtonView);
        button.icon = icons.imageAssetManager;
        button.withText = true;
        button.bind('label').to(imageInsertUI, 'isImageSelected', isImageSelected => isImageSelected ? t('Replace with file manager') : t('Insert with file manager'));
        button.on('execute', () => {
            imageInsertUI.dropdownView.isOpen = false;
        });
        return button;
    }
    /**
     * Creates a button for files management for the menu bar.
     */
    _createFileMenuBarButton() {
        const t = this.editor.locale.t;
        const button = this._createButton(MenuBarMenuListItemButtonView);
        button.icon = icons.browseFiles;
        button.withText = true;
        button.label = t('File');
        return button;
    }
    /**
     * Creates a button for images management for the menu bar.
     */
    _createImageMenuBarButton(type) {
        const t = this.editor.locale.t;
        const button = this._createButton(MenuBarMenuListItemButtonView);
        button.icon = icons.imageAssetManager;
        button.withText = true;
        switch (type) {
            case 'insertOnly':
                button.label = t('Image');
                break;
            case 'insertNested':
                button.label = t('With file manager');
                break;
        }
        return button;
    }
}
