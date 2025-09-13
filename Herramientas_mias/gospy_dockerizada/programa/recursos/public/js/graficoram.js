
// import Chart from 'chart.js/auto'



const ramDiv=document.querySelector('#ramdata');
const total = parseFloat(ramDiv.dataset.memtotal);  
const libre = parseFloat(ramDiv.dataset.memfree);
const usada = total - libre;

const labels = ['Libre', 'Usada'];

const colors = ['rgb(69,177,223)','rgb(203,82,82)'];




const printChart=()=>{


    renderModelsChart()

}

const renderModelsChart=()=>{
    const data={
    labels: labels,
    datasets: [{
        data: [libre,usada],
        backgroundColor: colors
    }]
};
    new Chart('grafica', {type:'pie',data})
}
printChart()