/**
 * @license Copyright (c) 2003-2024, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
 */

( e => {
const { [ 'fr' ]: { dictionary, getPluralForm } } = {"fr":{"dictionary":{"media widget":"Widget média","Media URL":"URL de média","Paste the media URL in the input.":"Coller l'URL du média","Tip: Paste the URL into the content to embed faster.":"Astuce : Copier l'URL du média dans le contenu pour l'insérer plus rapidement","The URL must not be empty.":"L'URL ne doit pas être vide.","This media URL is not supported.":"Cette URL de média n'est pas supportée.","Insert media":"Insérer un média","Media":"Média","Media toolbar":"Barre d'outils des médias","Open media in new tab":"Ouvrir le média dans un nouvel onglet"},getPluralForm(n){return (n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;}}};
e[ 'fr' ] ||= { dictionary: {}, getPluralForm: null };
e[ 'fr' ].dictionary = Object.assign( e[ 'fr' ].dictionary, dictionary );
e[ 'fr' ].getPluralForm = getPluralForm;
} )( window.CKEDITOR_TRANSLATIONS ||= {} );
