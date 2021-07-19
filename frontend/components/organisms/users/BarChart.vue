<script>
import { Doughnut } from 'vue-chartjs'

export default {
  extends: Doughnut,
  props: {
    tags: {
      type: Array,
      default: () => []
    }
  },
  data: () => ({
    chartdata: {
      datacollection: {
        labels: [],
        datasets: [
          {
            label: 'Data One',
            backgroundColor: ['info', 'blue', 'yellow', 'purple'],
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
    this.chartdata.datacollection.labels = this.tags
    this.renderChart(this.chartdata.datacollection, this.options)
  }
}
</script>
