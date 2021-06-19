<script>
import { Doughnut } from 'vue-chartjs'

export default {
  extends: Doughnut,
  data: () => ({
    chartdata: {
      datacollection: {
        labels: ['January', 'February', 'March'],
        datasets: [
          {
            label: 'Data One',
            backgroundColor: ['#FF6384', '#36A2EB', 'yellow'],
            data: [40, 20, 30]
          }
        ]
      }
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      legend: {
        position: 'bottom'
      }
    }
  }),
  mounted () {
    this.renderChart(this.chartdata.datacollection, this.options)
  }
}
</script>
