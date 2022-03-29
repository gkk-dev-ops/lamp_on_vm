function powering() {
    var arg1 = document.getElementById("arg1").value;
    let arg2 = document.getElementById("arg2").value;
    const wynik = document.getElementById("wynik");
    wynik.innerHTML = Math.pow(arg1, arg2);
    return wynik;
}
