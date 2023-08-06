import RadioGroup from '@/Components/RadioGroup';
import LifeStyleRadioGroup from './LifeStyleRadioGroup';
import { lifeStyleAdditionQuestionList, ageQuestionList } from '@/global/data';
import { QuestionBodyProps } from '@/global/type';
import AdditionQuestionTitle from './AdditionQuestionTitle';
import { Fragment } from 'react';

function QuestionBody({
  step,
  age,
  lifeStyle,
  myLifeStyle,
  ageHandler,
  lifeStyleHandler,
  myLifeStyleHandler,
}: QuestionBodyProps) {
  const question =
    step === '1' ? (
      <RadioGroup
        data={ageQuestionList}
        name={'age'}
        value={age}
        onChangeHandler={ageHandler}
      />
    ) : step === '2' ? (
      <LifeStyleRadioGroup
        value={lifeStyle}
        onChangeHandler={lifeStyleHandler}
      />
    ) : step === 'addition' ? (
      lifeStyleAdditionQuestionList.map((additionQuestion, index) => (
        <Fragment key={index}>
          <AdditionQuestionTitle title={additionQuestion.question} />
          <RadioGroup
            data={additionQuestion.answerList}
            name={additionQuestion.value}
            value={
              myLifeStyle[additionQuestion.value as keyof typeof myLifeStyle]
            }
            onChangeHandler={myLifeStyleHandler}
          />
        </Fragment>
      ))
    ) : null;

  return <>{question}</>;
}

export default QuestionBody;
