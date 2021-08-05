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
            backgroundColor: [],
            data: []
          }
        ]
      }
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      legend: {
        position: 'left'
      }
    },
    counterLists: []
  }),
  mounted () {
    this.tags.forEach((tag) => {
      // チャートの色をランダム生成
      const r = Math.round(Math.random() * 255)
      const g = Math.round(Math.random() * 255)
      const b = Math.round(Math.random() * 255)
      this.chartdata.datacollection.labels.push(tag.name)
      this.chartdata.datacollection.datasets[0].backgroundColor.push(`rgba(${r},${g},${b}, 0.5)`)
      this.chartdata.datacollection.datasets[0].data.push(tag.counter)
    })
    this.renderChart(this.chartdata.datacollection, this.options)
  }
}
</script>
