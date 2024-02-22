  static targets = [
    "quiz",
    "answerEls",
    "questionEl",
    "a_text",
    "b_text",
    "c_text",
    "d_text",
    "submit"
  ]



const quizData = [
  {
    question: "I want to find out more about a tour that I am going on. I would:",
    a: "read about the tour on the itinerary",
    b: "use a map and see where the places are",
    c: "look at details about the highlights and activities on the tour",
    d: "talk with the person who planned the tour or others who are going on the tour",
    visual: "b",
    aural: "d",
    reading: "a",
    kinesthetic: "c",
  },
  {
    question: "When I am learning I:",
    a: "like to talk things through",
    b: "read books, articles and handouts",
    c: "see patterns in things",
    d: "use examples and applications",
    visual: "c",
    aural: "a",
    reading: "b",
    kinesthetic: "d",
  },
  {
    question: "When finding my way, I:",
    a: "head in the general direction to see if I can find my destination without instructions",
    b: "like to read instructions from GPS or instructions that have been written",
    c: "rely on paper maps or GPS maps",
    d: "rely on verbal instructions from GPS or from someone traveling with me",
    visual: "c",
    aural: "d",
    reading: "b",
    kinesthetic: "a",
  },
  {
    question: "I want to save more money and to decide between a range of options. I would:",
    a: "consider examples of each option using my financial information",
    b: "talk with an expert about the options",
    c: "use graphs showing different options for different time periods",
    d: "read a print brochure that describes the options in detail",
    visual: "c",
    aural: "b",
    reading: "d",
    kinesthetic: "a",
  },
];

const quiz = docutment.getElementById('quiz')
const answerEls = document.querySelectorAll('.answer')
const questionEl = document.getElementById('question')
const a_text = document.getElementById('a_text')
const b_text = document.getElementById('b_text')
const c_text = document.getElementById('c_text')
const d_text = document.getElementById('d_text')
const submitBtn = document.getElementById('submit')

let currentQuiz = 0
let visualScore = 0
let auralScore = 0
let readingScore = 0
let kinestheticScore = 0

loadQuiz()

function loadQuiz() {

  deselectAnswers()

  const currentQuizData = quizData[currentQuiz]

  questionEl.innerText = currentQuizData.question
  a_text.innerText = currentQuizData.a
  b_text.innerText = currentQuizData.b
  c_text.innerText = currentQuizData.c
  d_text.innerText = currentQuizData.d
}

function deselectAnswers() {
  answerEls.forEach(answerEl => answerEl.checked = false)
}

function getSelected() {
  let answer
  answerEls.forEach(answerEl => {
    if(answerEl.checked) {
      answer = answerEl.id
    }
  })
  return answer
}

submitBtn.addEventListener('click', () => {
  const answer = getSelected()
  if(answer) {
    if(answer === quizData[currentQuiz].visual) {
      visualScore++
    }
    else if (answer === quizData[currentQuiz].aural) {
      auralScore++
    }
    else if (answer === quizData[currentQuiz].reading) {
      readingScore++
    }
    else {
      kinestheticScore++
    }

    currentQuiz++

    if(currentQuiz < quizData.length) {
      loadQuiz()
    } else {
      quiz.innerHTML `
      <h2>
        Visual Score: ${visualScore}
        Aural Score: ${auralScore}
        Reading Score: ${readingScore}
        Kinesthetic Score: ${kinestheticScore}
      </h2>

      <button onclick="location.reload()">Reload</button>
      `
    }
  }
})
