new Vue({
  el: '#app',
  data: {
    message: "Hello Vue.js!"
  }
})

var app2 = new Vue({
  el: "#app-2",
  data: {
    message: "You loaded this page on " + new Date().toLocaleString()
  }
})

var app3 = new Vue({
  el: "#app-3",
  data: {
    seen: true
  }
})

var app4 = new Vue({
  el: "#app-4",
  data: {
    todos: [
      { text: "Learn JavaScript" },
      { text: "Learn Vue" },
      { text: "Build something awesome" }
    ]
  }
})

var app5 = new Vue({
  el: "#app-5",
  data: {
    message: "Hello Vue.js!"
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
})

var app6 = new Vue({
  el: "#app-6",
  data: {
    message: "Hello Vue!"
  }
})

Vue.component('todo-item', {
  props: ['todo'],
  template: '<li>{{ todo.text }}</li>'
})

var app7 = new Vue({
  el: "#app-7",
  data: {
    groceryList: [
      { id: 0, text: 'Vegetables' },
      { id: 1, text: 'Cheese' },
      { id: 2, text: 'Whatever else' }
    ]
  }
})

var vm = new Vue({
  el: "#example",
  data: {
    message: "Hello"
  },
  computed: {
    reversedMessage: function () {
      return this.message.split('').reverse().join('')
    }
  }
})

var watchExampleVM = new Vue({
  el: '#watch-example',
  data: {
    question: '',
    answer: 'I cannot give you an answer until you ask a question'
  },
  watch: {
    question: function (newQuestion) {
      this.answer = 'Watching for you to stop typing...'
      this.getAnser()
    }
  },
  methods: {
    getAnser: _.debounce(
      function () {
        if (this.question.indexOf('?') === -1) {
          this.answer = 'Questions usually contain a question mark.'
          return
        }
        this.answer = 'Thinking...'
        var vm = this
        axios.get('https://yesno.wtf/api')
          .then(function (response) {
            vm.answer = _.capitalize(response.data.answer)
          })
          .catch(function (error) {
            vm.answer = 'Error! Could not reach the API.' + error
          })
    },
    500
    )
  }
})

var conditionalExampleVM = new Vue({
  el: '#conditional-example',
  data: {
    ok: true
  }
})

var forObjectVM = new Vue({
  el: '#v-for-object',
  data: {
    object: {
      firstName: 'John',
      lastName: 'Doe',
      age: 30
    }
  }
})

var forRangeVM = new Vue({
  el: '#v-for-range'
})

var inlineHandlerVM = new Vue({
  el: '#inline-handler',
  methods: {
    say: function (message) {
      alert(message)
    }
  }
})

Vue.component('button-counter', {
  template: '<button v-on:click="incrementCounter">{{ counter }}</button>',
  data: function () {
    return {
      counter: 0
    }
  },
  methods: {
    incrementCounter: function () {
      this.counter += 1
      this.$emit('increment')
    }
  }
})

counterEventVM = new Vue({
  el: '#counter-event-example',
  data: {
    total: 0
  },
  methods: {
    incrementTotal: function () {
      this.total += 1
    }
  }
})
