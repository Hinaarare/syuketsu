/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


list = new Array();
list["-"] = "\u25cb";
list["\u25cb"] = "×";
list["×"] = "-";

function change(id) {
//  alert("display_"+id)
  elm = document.getElementById("display_"+id)
  elm.innerHTML = list[elm.innerHTML];
  hidden = document.getElementById(id);
  hidden.value = elm.innerHTML;
}