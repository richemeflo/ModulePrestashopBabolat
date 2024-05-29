{if isset($urlValid)}
  {if $urlValid == $smarty.server.REQUEST_URI}
    <style>
      
      .inactive {
          display: none;
      }
      .active {
          display: flex;
      }

      #box-module {
        display: flex;
        justify-content: center;
        align-items: center;
        height: fit-content;
        width: 100%;
        background-color: white;
      }

      #suggestionmodule {
        background-color: #EDF0FC;
        border-radius: 5px;
        border: #030512 solid 2px;
        width: min(90%,700px);
        margin-top: 10px;
        padding: 20px;
      }

      .content{
        width: 90%;
        margin-left: 5%;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
      }
      .step {
          flex-basis: 100%;
          margin-bottom: 10px;
          display: flex;
          justify-content: space-between;
      }
      .step div {
          width: 20%;
          height: 3px;
          background-color: #DCE0F9;
          border-radius: 5px;
      }
      .step .here {
          background-color: #111E6C;
      }
      .left-part {
          flex-basis: 43%;
      }
      .right-part {
          flex-basis: 43%;
          display: flex;
          flex-direction: column;
          justify-content:center;
          align-items: left;
          gap: 10%;
      }
      #text-start {
          color: #030512;
          text-align: left;
          margin-bottom: 10px;
          font-size: 1em;
          margin-top: 10px;
      }
      .bouton-start {
          background-color: #111E6C;
          color: #EDF0FC;
          text-align: center;
          padding: 10px 15px 10px 15px;
          width: fit-content;
          border-radius: 5px;
          margin-top: 10px;
          font-size: 0.9em;
      }
      .bouton-start:hover {
          box-shadow:1px 1px 1px 1px black;
      }

      .left-part img {
          width: 100%;
      }
      .bouton-retour {
          background-repeat: no-repeat;
          background-position: left;
          background-image: url("{$boutonRetour}");
          background-size: contain;
          text-align: left;
          height: 1.2em;
          width: calc(min(5%, 50px));
          margin: 10px 10px 10px 0px;
          font-size: 0.8em;
      }

      .bouton-retour:hover{
        margin-left:-1px;
      }

      .retour-icon {
          display: none;
      }

      .form-question{
          flex-basis: 100%;
      }

      .form-question form {
          display: flex;
          flex-direction: column;
          color: #030512;
      }

      .form-question form label {
        align-self: start;
        flex-basis: 100%;
        margin-top: 10px;
        margin-bottom: 10px;
        font-size: 1em;
        font-weight: bold;
      }

      .form-question form select {
        align-self: start;
        background-color:#DCE0F9;
        border: #111E6C solid 1px;
        border-radius: 5px;
        padding: 0 1em 0 0;
        margin: 0;
        width: 100%;
        font-family: inherit;
        font-size: inherit;
        cursor: inherit;
        line-height: inherit;
        width: 100%;
        font-size: 0.9em;

        z-index: 1;
        text-wrap:balance;
      }


      .form-question form option .active{
        display: block;
      }

      .form-question form option .inactive{
        display: none;
      }



      .form-question form input[type=submit] {
        background-color: #111E6C;
        color: #EDF0FC;
        text-align: center;
        padding: 10px 15px 10px 15px;
        width: fit-content;
        border-radius: 5px;
        margin-top: 20px;
        align-self: flex-end;
        font-size: 0.9em;
        box-shadow:1px 1px 1px 1px rgba(0, 0, 0, 0);
      }

      .form-question form input[type=submit]:hover {
        box-shadow:1px 1px 1px 1px black;
      }

      .text-bravo {
        flex-basis: 100%;
        color: #030512;
        text-align: left;
        margin-bottom: 10px;
        font-size: 1em;
        margin-top: 10px;
      }

      .resultat-suggestion {
        flex-basis: 100%;
        display: flex;
        flex-direction: column;
        align-items: left;
        margin-top: 20px;
        margin-bottom: 20px;
      }

      .resultat-suggestion .list-pdt {
        flex-basis: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-around;
        align-items: center;
        gap: 2%;
        flex-wrap: wrap;
      }

      .resultat-suggestion .list-pdt .pdt {
        flex-basis: 40%;
        display: flex;
        margin-bottom: 20px;
      }

      a.link-pdt {
        all:unset;
      }

      .resultat-suggestion .list-pdt .pdt .link-pdt {
        justify-content: center;
        align-items: center;
        text-decoration: none;
        color:#030512;
        border:#111E6C solid 1px;
        background-color: #EDF0FC;
        border-radius: 5px;
        padding-top: 10px;
        padding-bottom: 10px;
      }

      .resultat-suggestion .list-pdt .pdt .link-pdt .image-pdt {
        width: 95%;
        margin-left: 2.5%;
        margin-top: 10px;
        border-radius:5px;
      }

      .resultat-suggestion .list-pdt .pdt .link-pdt .name-pdt {
        font-size: 0.8em;
        font-weight: bold;
        width: 95%;
        text-align: center;
        margin-left: 2.5%;
        margin-bottom: 10px;
        height:1.5em;
        overflow:hidden;
      }

      .resultat-suggestion .list-pdt .pdt .link-pdt .price-pdt {
        font-size: 0.7em;
        width: 95%;
        text-align: center;
        margin-left: 2.5%;
        margin-bottom: 10px;
      }

      .resultat-suggestion .list-pdt .pdt .link-pdt:hover {
        background-color: white;
      }

      .price-pdt::after {
        content: "€";
      }

    </style>

    





    <div id="box-module">
      <div id='suggestionmodule'>
        <div id="home" class="content active">
          <div class="step"><div class="here"></div><div></div><div></div><div></div></div>
          <div class="left-part"><img src="{$logoBabolat}" alt="Babolat"></div>
          <div class="right-part">
            <div id="text-start">Répondez à ces question pour découvrir votre raquette de padel Babolat idéale.</div>
            <div class="bouton-start">Commencer</div>
          </div>
          
        </div>

        <div id="question1" class="content inactive">
          <div class="step"><div class="here"></div><div class="here"></div><div></div><div></div></div>
          <div class="bouton-retour"> </div>
          <div class="form-question">
            <form action="" >
              <label for="q1">Vous êtes : </label>
              <select name="q1" required>
                <option value='homme'>Homme</option>
                <option value='femme'>Femme</option>
                <option value='junior'>Junior</option>
              </select>
              <input type="submit" value="Suivant">
            </form>
          </div>
        </div>

        <div id="question2" class="content inactive">
          <div class="step"><div class="here"></div><div class="here"></div><div class="here"></div><div></div></div>
          <div class="bouton-retour"> </div>
          <div class="form-question">
            <form action="">
              <label for="q2">Sélectionnez votre niveau : </label>
              <select name="q2" required>
                <option value='competition'>Compétition</option>
                <option value='avance'>Avancé</option>
                <option value='loisir'>Loisir</option>
              </select>
              <input type="submit" value="Suivant">
            </form>
          </div>
        </div>

        <div id="question3" class="content inactive">
          <div class="step"><div class="here"></div><div class="here"></div><div class="here"></div><div class="here"></div></div>
          <div class="bouton-retour"> </div>
          <div class="form-question">
            <form action="">
              <label for="q3">Sélectionnez votre style de jeu :</label>
              <select name="q3" required>
                <option value="hide" selected disabled>-- Choisir un style --</option>
                <option value='dynamique' class="femme inactive"><b>La joueuse dynamique :</b> Rapide sur ses pieds et surprenant toujours ses adversaires, elle utilise sa vitesse pour passer facilement de la défense à l'attaque.</option>
                <option value='avance' class="femme inactive">Avancé</option>
                <option value='contre_attaque' class="femme inactive"><b>Contre-attaquant :</b> Posée et réfléchie, elle s'appuie sur sa patience et sa constance pour épuiser ses adversaires.</option>
                <option value="technique" class="homme inactive"><b>Attaquant technique :</b> Moteur du jeu, l'attaquant technique utilise ses compétences et sa force pour être décisif sur chaque coup d'attaque.</option>
                <option value="aerien" class="homme inactive"><b>Attaquant aérien :</b> Ultra dynamique, l'attaquant aérien saisit toutes les occasions pour monter au filet et fait la différence grâce à sa vitesse.</option>
                <option value="contre_attaque" class="homme inactive"><b>Contre-attaquant :</b> Patient et contrôlant le jeu, le contre-attaquant résiste aux coups de l'adversaire et attend la balle parfaite pour la smasher.</option>
              </select>
              <input type="submit" value="Suivant">
            </form>
          </div>
        </div>

        <div id="question4" class="content inactive">
          <div class="step"><div class="here"></div><div class="here"></div><div class="here"></div><div class="here"></div></div>
          <div class="bouton-retour"> </div>
          <div class="form-question">
            <form action="">
              <label for="q4">Avez-vous déjà pratiqué un sport de raquette ?</label>
              <select name="q4" required>
                <option value='oui'>Oui</option>
                <option value='non'>Non</option>
              </select>
              <input type="submit" value="Suivant">
            </form>
          </div>
        </div>

        <div id="fin" class="content inactive">
          <div class="step"><div class="here"></div><div class="here"></div><div class="here"></div><div class="here"></div></div>
          <div class="bouton-retour"> </div>
          <div class="text-bravo">
            Félicitation ! Découvrez la ou les raquettes Babolat faites pour vous :
          </div>
          <div class="resultat-suggestion">
            <div id="homme_competition_aerien" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_competition_aerien item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_competition_technique" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_competition_technique item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_competition_contre_attaque" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_competition_contre_attaque item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_avance_aerien" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_avance_aerien item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_avance_technique" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_avance_technique item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_avance_contre_attaque" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_avance_contre_attaque item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_loisir_oui" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_loisir_oui item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="homme_loisir_non" class="inactive">
              <div class="list-pdt">
                {foreach from=$homme_loisir_non item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="femme_competition_dynamique" class="inactive">
              <div class="list-pdt">
                {foreach from=$femme_competition_dynamique item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="femme_competition_contre_attaque" class="inactive">
              <div class="list-pdt">
                {foreach from=$femme_competition_contre_attaque item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="femme_avance_dynamique" class="inactive">
              <div class="list-pdt">
                {foreach from=$femme_avance_dynamique item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="femme_avance_contre_attaque" class="inactive">
              <div class="list-pdt">
                {foreach from=$femme_avance_contre_attaque item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="femme_loisir" class="inactive">
              <div class="list-pdt">
                {foreach from=$femme_loisir item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
            <div id="junior" class="inactive">
              <div class="list-pdt">
                {foreach from=$junior item="product"}
                  <div class="pdt">
                    <a class='link-pdt' href="{$product["productLink"]}">
                      <img class='image-pdt' src="{$product['productImage']}" alt="image">
                      <div class='name-pdt'>{$product['productName']}</div>
                      <div class='price-pdt'>{$product['productPrice']}</div>
                    </a>
                  </div>
                {/foreach}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      const questions = document.querySelectorAll('.content');
      const h=document.querySelectorAll('.homme');
      const f=document.querySelectorAll('.femme');
      var currentQuestion = 0;
      var pastQuestion = [0];
      var suggestion="";


      function showQuestion(index) {
          questions.forEach((question, i) => {
              if (i === index) {
                  question.classList.remove('inactive');
                  question.classList.add('active');
              } else {
                  question.classList.add('inactive');
                  question.classList.remove('active');
              }
          });
      }

      function prevQuestion() {
        if (pastQuestion.length > 0) {
          pastQuestion.pop();
          currentQuestion = pastQuestion[pastQuestion.length - 1];
          console.log("q "+currentQuestion);
          showQuestion(currentQuestion);
        }
        suggestion = suggestion.split('_').slice(0, currentQuestion-1).join('_');

      }

      function ChangeQuestion(i) {
        if ((i >= 0) && (i < questions.length)) {
          currentQuestion = i;
          pastQuestion.push(i);
          showQuestion(currentQuestion);
        }
      }

      const resultat_possible=document.querySelectorAll('.resultat-suggestion div');
      function FinalQuestion() {
        if (suggestion=="homme_competition_technique"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_competition_technique').classList.add('active');
          document.querySelector('#homme_competition_technique').classList.remove('inactive');
          document.querySelectorAll('#homme_competition_technique div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_competition_aerien"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_competition_aerien').classList.add('active');
          document.querySelector('#homme_competition_aerien').classList.remove('inactive');
          document.querySelectorAll('#homme_competition_aerien div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_competition_contre_attaque"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_competition_contre_attaque').classList.add('active');
          document.querySelector('#homme_competition_contre_attaque').classList.remove('inactive');
          document.querySelectorAll('#homme_competition_contre_attaque div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_avance_technique"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_avance_technique').classList.add('active');
          document.querySelector('#homme_avance_technique').classList.remove('inactive');
          document.querySelectorAll('#homme_avance_technique div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_avance_aerien"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_avance_aerien').classList.add('active');
          document.querySelector('#homme_avance_aerien').classList.remove('inactive');
          document.querySelectorAll('#homme_avance_aerien div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_avance_contre_attaque"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_avance_contre_attaque').classList.add('active');
          document.querySelector('#homme_avance_contre_attaque').classList.remove('inactive');
          document.querySelectorAll('#homme_avance_contre_attaque div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_loisir_oui"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_loisir_oui').classList.add('active');
          document.querySelector('#homme_loisir_oui').classList.remove('inactive');
          document.querySelectorAll('#homme_loisir_oui div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="homme_loisir_non"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#homme_loisir_non').classList.add('active');
          document.querySelector('#homme_loisir_non').classList.remove('inactive');
          document.querySelectorAll('#homme_loisir_non div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="femme_competition_dynamique"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#femme_competition_dynamique').classList.add('active');
          document.querySelector('#femme_competition_dynamique').classList.remove('inactive');
          document.querySelectorAll('#femme_competition_dynamique div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="femme_competition_contre_attaque"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#femme_competition_contre_attaque').classList.add('active');
          document.querySelector('#femme_competition_contre_attaque').classList.remove('inactive');
          document.querySelectorAll('#femme_competition_contre_attaque div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="femme_avance_dynamique"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#femme_avance_dynamique').classList.add('active');
          document.querySelector('#femme_avance_dynamique').classList.remove('inactive');
          document.querySelectorAll('#femme_avance_dynamique div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="femme_avance_contre_attaque"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#femme_avance_contre_attaque').classList.add('active');
          document.querySelector('#femme_avance_contre_attaque').classList.remove('inactive');
          document.querySelectorAll('#femme_avance_contre_attaque div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if ((suggestion=="femme_loisir_oui")||(suggestion=="femme_loisir_non")){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#femme_loisir').classList.add('active');
          document.querySelector('#femme_loisir').classList.remove('inactive');
          document.querySelectorAll('#femme_loisir div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }
        if (suggestion=="junior"){
          resultat_possible.forEach((item) => {
            item.classList.add('inactive');
            item.classList.remove('active');
          });
          document.querySelector('#junior').classList.add('active');
          document.querySelector('#junior').classList.remove('inactive');
          document.querySelectorAll('#junior div').forEach((child) => {
            child.classList.remove('inactive');
          });
        }

        ChangeQuestion(questions.length-1);
      }


      document.querySelector('.bouton-start').addEventListener('click', function (e) {
        ChangeQuestion(currentQuestion+1);
      });

      document.querySelector('#question1 form').addEventListener('submit', function (e) {
          e.preventDefault();
          let valeur = document.querySelector('#question1 form select').value;
          console.log(valeur);
          if (valeur == 'junior') {
            suggestion = "junior";
            FinalQuestion();
          }
          if (valeur == 'femme') {
            suggestion = "femme";
            f.forEach((item) => {
              item.classList.add('active');
              item.classList.remove('inactive');
            });
            h.forEach((item) => {
              item.classList.add('inactive');
              item.classList.remove('active');
            });
            ChangeQuestion(currentQuestion+1);
          }
          if (valeur == 'homme') {
            suggestion = "homme";
            f.forEach((item) => {
              item.classList.add('inactive');
              item.classList.remove('active');
            });
            h.forEach((item) => {
              item.classList.add('active');
              item.classList.remove('inactive');
            });
            ChangeQuestion(currentQuestion+1);
          }
      });

      document.querySelector('#question2 form').addEventListener('submit', function (e) {
          e.preventDefault();
          pastSuggestion = suggestion;
          valeur = document.querySelector('#question2 form select').value;
          suggestion = suggestion +"_"+ valeur;
          if (valeur == 'loisir') {
            ChangeQuestion(questions.length - 2);
          }else {
            ChangeQuestion(currentQuestion+1);
          }
      });
      document.querySelector('#question3 form').addEventListener('submit', function (e) {
          e.preventDefault();
          if (document.querySelector('#question3 form select').value != 'hide') {
            suggestion = suggestion +"_"+ document.querySelector('#question3 form select').value;
            FinalQuestion();
          }
          console.log(suggestion);
      });
      document.querySelector('#question4 form').addEventListener('submit', function (e) {
          e.preventDefault();
          pastSuggestion = suggestion;
          suggestion = suggestion +"_"+ document.querySelector('#question4 form select').value;
          console.log(suggestion);
          FinalQuestion();
      });

      let retours = document.querySelectorAll('.bouton-retour');
      retours.forEach((retour) => {
        retour.addEventListener('click', prevQuestion);
      });
    </script>
  {/if}
{/if}
