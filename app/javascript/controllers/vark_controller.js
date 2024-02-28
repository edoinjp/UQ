import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vark"
export default class extends Controller {
  connect() {
    console.log("Hello from vark_controller")
  }
}

const quizData = [
  {
    remaining: "Question 1/4",
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
    remaining: "Question 2/4",
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
    remaining: "Question 3/4",
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
    remaining: "Question 4/4",
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

const questions_remaining = document.getElementById('remaining')
const quiz = document.getElementById('quiz')
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

  questions_remaining.innerText = currentQuizData.remaining
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

    console.log(currentQuiz++);

    if(currentQuiz < quizData.length) {
      loadQuiz()
    } else {
      quiz.innerHTML = `
      <h2 id="results">
        Visual Score: ${visualScore} <br><br>
        Aural Score: ${auralScore} <br><br>
        Reading Score: ${readingScore} <br><br>
        Kinesthetic Score: ${kinestheticScore} <br><br>
      </h2>

      <button onclick="location.reload()">Reload</button>
      `
    }
  }
})
