/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */
/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */
/**
 * @module table/tablecaption/tablecaptionediting
 */
import { Plugin, type Editor } from 'ckeditor5/src/core.js';
import { Element } from 'ckeditor5/src/engine.js';
/**
 * The table caption editing plugin.
 */
export default class TableCaptionEditing extends Plugin {
    /**
     * A map that keeps saved JSONified table captions and table model elements they are
     * associated with.
     *
     * To learn more about this system, see {@link #_saveCaption}.
     */
    private _savedCaptionsMap;
    /**
     * @inheritDoc
     */
    static get pluginName(): "TableCaptionEditing";
    /**
     * @inheritDoc
     */
    constructor(editor: Editor);
    /**
     * @inheritDoc
     */
    init(): void;
    /**
     * Returns the saved {@link module:engine/model/element~Element#toJSON JSONified} caption
     * of a table model element.
     *
     * See {@link #_saveCaption}.
     *
     * @internal
     * @param tableModelElement The model element the caption should be returned for.
     * @returns The model caption element or `null` if there is none.
     */
    _getSavedCaption(tableModelElement: Element): Element | null;
    /**
     * Saves a {@link module:engine/model/element~Element#toJSON JSONified} caption for
     * a table element to allow restoring it in the future.
     *
     * A caption is saved every time it gets hidden. The
     * user should be able to restore it on demand.
     *
     * **Note**: The caption cannot be stored in the table model element attribute because,
     * for instance, when the model state propagates to collaborators, the attribute would get
     * lost (mainly because it does not convert to anything when the caption is hidden) and
     * the states of collaborators' models would de-synchronize causing numerous issues.
     *
     * See {@link #_getSavedCaption}.
     *
     * @internal
     * @param tableModelElement The model element the caption is saved for.
     * @param caption The caption model element to be saved.
     */
    _saveCaption(tableModelElement: Element, caption: Element): void;
}
