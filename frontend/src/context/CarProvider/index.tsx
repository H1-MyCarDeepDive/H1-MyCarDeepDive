import { useReducer, createContext } from 'react';
import {
  InitialStateType,
  CarContextType,
  ActionType,
  CarProviderProps,
  SET_ENGINE,
  SET_BODY,
  SET_DRIVINGSYSTEM,
  SET_TRIM,
  SET_EXTERIORCOLOR,
  SET_INTERIORCOLOR,
  ADD_OPTION,
  DELETE_OPTION,
} from './type';

const initialState: InitialStateType = {
  engine: '',
  body: '',
  drivingSystem: '',
  trim: '',
  exteriorColor: '',
  interiorColor: '',
  optionList: [],
};

export const CarContext = createContext<CarContextType>({
  ...initialState,
  carDispatch: () => {},
});

const reducer = (state: InitialStateType, action: ActionType) => {
  switch (action.type) {
    case SET_ENGINE:
      return { ...state, engine: action.engine };
    case SET_BODY:
      return { ...state, body: action.body };
    case SET_DRIVINGSYSTEM:
      return { ...state, drivingSystem: action.drivingSystem };
    case SET_TRIM:
      return { ...state, trim: action.trim };
    case SET_EXTERIORCOLOR:
      return { ...state, exteriorColor: action.exteriorColor };
    case SET_INTERIORCOLOR:
      return { ...state, interiorColor: action.interiorColor };
    case ADD_OPTION:
      return { ...state, optionList: [...state.optionList, action.option] };
    case DELETE_OPTION:
      return {
        ...state,
        optionList: state.optionList.filter(
          (item: number) => item !== action.option,
        ),
      };
    default:
      throw new Error();
  }
};

const CarProvider = ({ children }: CarProviderProps) => {
  const [state, carDispatch] = useReducer(reducer, initialState);

  return (
    <CarContext.Provider
      value={{
        ...state,
        carDispatch,
      }}
    >
      {children}
    </CarContext.Provider>
  );
};

export default CarProvider;