import { takeLatest, call, put } from "redux-saga/effects";

function* fetchHandicapSaga(action) {
  try {
    // API call to fetch handicap index
    const response = yield call(
      fetch,
      `/api/handicap/calculate/${action.payload.userId}`
    );
    const data = yield response.json();
    console.log("data", data);
    yield put({ type: "FETCH_HANDICAP_SUCCESS", payload: data.handicap });
    console.log("data", data);
  } catch (error) {
    yield put({ type: "FETCH_HANDICAP_FAILURE", error });
  }
}

// function* fetchTotalRounds(action) {
//   try {
//     const response = yield call(fetch, `api/`);
//   } catch (error) {
//     console.log(error);
//   }
// }

function* rootSaga() {
  yield takeLatest("FETCH_HANDICAP_REQUEST", fetchHandicapSaga);
  // yield takeLatest("FETCH_TOTAL_ROUNDS", fetchTotalRounds);
}

export default rootSaga;
