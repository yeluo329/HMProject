export  function doFunc() {
  let array: string = 'Who Love Solo';
  let wordArr = array.split(' ');
  let sumLength = 0;
  for (let i = 0; i < wordArr.length; i++) {
    sumLength += wordArr[i].length
  }
  console.log('ljz:' + (sumLength / wordArr.length).toFixed(2));
}

