<?php
/**
* 2007-2023 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2023 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/


if (!defined('_PS_VERSION_')) {
    exit;
}

class Suggestionproduit extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'suggestionproduit';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'FrenchPadelShop';
        $this->need_instance = 0;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('suggestionproduit');
        $this->description = $this->l('Suggère des produits selon les réponses aux questions posées.');

        $this->confirmUninstall = $this->l('Êtes-vous sûr de vouloir désinstaller le module ?');

        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    /**
     * Install
     */
    public function install()
    {
        return parent::install() &&
            $this->registerHook('displayContentWrapperTop');
    }

    public function uninstall()
    {   
        Configuration::deleteByName('SUGGESTIONPRODUIT_URL_BABOLAT');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_COMPETITION_TECHNIQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_COMPETITION_AERIEN');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_COMPETITION_CONTRE_ATTAQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_AVANCE_TECHNIQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_AVANCE_AERIEN');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_AVANCE_CONTRE_ATTAQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_LOISIR_OUI');
        Configuration::deleteByName('SUGGESTIONPRODUIT_HOMME_LOISIR_NON');
        Configuration::deleteByName('SUGGESTIONPRODUIT_FEMME_COMPETITION_DYNAMIQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_FEMME_COMPETITION_CONTRE_ATTAQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_FEMME_AVANCE_DYNAMIQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_FEMME_AVANCE_CONTRE_ATTAQUE');
        Configuration::deleteByName('SUGGESTIONPRODUIT_FEMME_LOISIR');
        Configuration::deleteByName('SUGGESTIONPRODUIT_JUNIOR');
        return parent::uninstall();
    }

    /**
     * Load the configuration form
     */
    public function getContent()
    {
        /**
         * If values have been submitted in the form, process.
         */
        if (((bool)Tools::isSubmit('submitSuggestionproduitModule')) == true) {
            $this->postProcess();
        }

        $this->context->smarty->assign('module_dir', $this->_path);

        $output = $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');

        return $output.$this->renderForm();
    }

    /**
     * Create the form that will be displayed in the configuration of your module.
     */
    protected function renderForm()
    {
        $helper = new HelperForm();

        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);

        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitSuggestionproduitModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            .'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFormValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        );

        return $helper->generateForm(array($this->getConfigForm()));
    }

    /**
     * Create the structure of your form.
     */
    protected function getConfigForm()
    {
        return array(
            'form' => array(
                'legend' => array(
                'title' => $this->l('Settings'),
                'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'prefix' => '<i class="icon icon-link"></i>',
                        'desc' => $this->l('url de la page babolat de french : /3-raquettes-de-padel/s-1/marque_2-babolat'),
                        'name' => 'SUGGESTIONPRODUIT_URL_BABOLAT',
                        'label' => $this->l('URL page : '),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_TECHNIQUE',
                        'label' => $this->l('Raquette pour Homme - Compétition - Attaquant Technique'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_AERIEN',
                        'label' => $this->l('Raquette pour Homme - Compétition - Attaquant Aérien'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_CONTRE_ATTAQUE',
                        'label' => $this->l('Raquette pour Homme - Compétition - Contre-attaquant'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_TECHNIQUE',
                        'label' => $this->l('Raquette pour Homme - Avancé - Attaquant Technique'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_AERIEN',
                        'label' => $this->l('Raquette pour Homme - Avancé - Attaquant Aérien'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_CONTRE_ATTAQUE',
                        'label' => $this->l('Raquette pour Homme - Avancé - Contre-Attaquant'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_OUI',
                        'label' => $this->l('Raquette pour Homme - Loisir - Dejà pratiqué un sport de raquette'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_NON',
                        'label' => $this->l('Raquette pour Homme - Loisir - Jamais pratiqué un sport de raquette'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_DYNAMIQUE',
                        'label' => $this->l('Raquette pour Femme - Compétition - Dynamique'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_CONTRE_ATTAQUE',
                        'label' => $this->l('Raquette pour Femme - Compétition - Contre-attaquante'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_DYNAMIQUE',
                        'label' => $this->l('Raquette pour Femme - Avancé - Dynamique'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_CONTRE_ATTAQUE',
                        'label' => $this->l('Raquette pour Femme - Avancé - Contre-attaquante'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_FEMME_LOISIR',
                        'label' => $this->l('Raquette pour Femme - Loisir'),
                    ),
                    array(
                        'col' => 3,
                        'type' => 'textarea',
                        'prefix' => '<i class="icon icon-envelope"></i>',
                        'desc' => $this->l('idProduit1,idProduit2,idProduit3'),
                        'name' => 'SUGGESTIONPRODUIT_RACKET_JUNIOR',
                        'label' => $this->l('Raquette Junior'),
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
            ),
        );
    }

    /**
     * Set values for the inputs.
     */
    protected function getConfigFormValues()
    {
        return array(
            'SUGGESTIONPRODUIT_URL_BABOLAT' => Configuration::get('SUGGESTIONPRODUIT_URL_BABOLAT', 'https://www.frenchpadelshop.com/3-raquettes-de-padel/s-1/marque_2-babolat'),
            'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_TECHNIQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_TECHNIQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_AERIEN' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_AERIEN', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_CONTRE_ATTAQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_CONTRE_ATTAQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_TECHNIQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_TECHNIQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_AERIEN' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_AERIEN', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_CONTRE_ATTAQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_CONTRE_ATTAQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_OUI' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_OUI', ''),
            'SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_NON' => Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_NON', ''),
            'SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_DYNAMIQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_DYNAMIQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_CONTRE_ATTAQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_CONTRE_ATTAQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_DYNAMIQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_DYNAMIQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_CONTRE_ATTAQUE' => Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_CONTRE_ATTAQUE', ''),
            'SUGGESTIONPRODUIT_RACKET_FEMME_LOISIR' => Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_LOISIR', ''),
            'SUGGESTIONPRODUIT_RACKET_JUNIOR' => Configuration::get('SUGGESTIONPRODUIT_RACKET_JUNIOR', ''),
        );
    }

    /**
     * Save form data.
     */
    protected function postProcess()
    {
        $form_values = $this->getConfigFormValues();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    public function hookDisplayContentWrapperTop()
    {
        if ($_SERVER['REQUEST_URI'] == Configuration::get('SUGGESTIONPRODUIT_URL_BABOLAT')){
            $this->context->smarty->assign([
                'urlValid' => Configuration::get('SUGGESTIONPRODUIT_URL_BABOLAT'),
                'logoBabolat' => $this->_path.'views/img/logoBabolat.svg',
                'boutonRetour' => $this->_path.'views/img/bouton-retour.png',
                'homme_competition_technique' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_TECHNIQUE')),
                'homme_competition_aerien' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_AERIEN')),
                'homme_competition_contre_attaque' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_COMPETITION_CONTRE_ATTAQUE')),
                'homme_avance_technique' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_TECHNIQUE')),
                'homme_avance_aerien' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_AERIEN')),
                'homme_avance_contre_attaque' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_AVANCE_CONTRE_ATTAQUE')),
                'homme_loisir_oui' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_OUI')),
                'homme_loisir_non' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_HOMME_LOISIR_NON')),
                'femme_competition_dynamique' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_DYNAMIQUE')),
                'femme_competition_contre_attaque' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_COMPETITION_CONTRE_ATTAQUE')),
                'femme_avance_dynamique' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_DYNAMIQUE')),
                'femme_avance_contre_attaque' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_AVANCE_CONTRE_ATTAQUE')),
                'femme_loisir' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_FEMME_LOISIR')),
                'junior' => $this->getProducts(Configuration::get('SUGGESTIONPRODUIT_RACKET_JUNIOR')),
            ]);
            
            return $this->display(__FILE__, 'views/templates/front/babolat.tpl');
        }
        else {
            return;
        }

    }

    public function getProducts($idsText)
    {
        // vérification que l'on a bien un type string en paramètre dans le cas où aucune configuration n'a été faite du module.
        if (!is_string($idsText)) {
            return [];
        }

        // on s'assure que l'on a pas de chaine avec seulement un espace sans quoi, cela cause une erreur 500
        $id_products = array_filter(explode(",", $idsText), static fn ($v) => !empty(trim($v)));
        
        $products = array();
        foreach ($id_products as $key => $id) {
            
            $image = Image::getCover($id);
            $productName = Product::getProductName($id);
            $imageurl = $this->context->link->getImageLink(str_replace(" ", "-", $productName), $image['id_image']);
            $products[$key]=array(
                'productName' => $productName,
                'productPrice' => Product::getPriceStatic($id),
                'productImage' => $imageurl,
                'productLink' => $this->context->link->getProductLink($id),
            );
        }
        return $products;
    }




}
