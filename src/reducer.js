const initialState = {
  handicapIndex: null,
  loading: false,
  error: null,
};

const userReducer = (state = initialState, action) => {
  switch (action.type) {
    case "FETCH_HANDICAP_REQUEST":
      return { ...state, loading: true };
    case "FETCH_HANDICAP_SUCCESS":
      return { ...state, loading: false, handicapIndex: action.payload };
    case "FETCH_HANDICAP_FAILURE":
      return { ...state, loading: false, error: action.error };
    default:
      return state;
  }
};

export default userReducer;
