/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */

( e => {
const { [ 'km' ]: { dictionary, getPluralForm } } = {"km":{"dictionary":{"Unlink":"ផ្ដាច់​តំណ","Link":"តំណ","Link URL":"URL តំណ","Link URL must not be empty.":"","Link image":"","Edit link":"","Open link in new tab":"","This link has no URL":"","Open in a new tab":"","Downloadable":"","Create link":"","Move out of a link":""},getPluralForm(n){return 0;}}};
e[ 'km' ] ||= { dictionary: {}, getPluralForm: null };
e[ 'km' ].dictionary = Object.assign( e[ 'km' ].dictionary, dictionary );
e[ 'km' ].getPluralForm = getPluralForm;
} )( window.CKEDITOR_TRANSLATIONS ||= {} );
