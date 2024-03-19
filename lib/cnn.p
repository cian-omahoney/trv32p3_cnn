#define MAX_INT32 2147483647
#define MIN_INT32 -2147483648

const v22w32 expRes = {1, 3, 7, 20, 55, 148, 403, 1097, 2981, 8103, 22026, 59874, 162755, 442413, 1202604, 3269017, 8886111, 24154953, 65659969, 178482301, 485165195, 1318815734};

w32 INT32_SATURATION(int64_t fullResult)
{
    int32_t saturatedResult;
    if(fullResult > MAX_INT32)
    {
        saturatedResult = MAX_INT32;
    }
    else if(fullResult < MIN_INT32){
        saturatedResult = MIN_INT32;
    }
    else{
        saturatedResult = fullResult[31:0];
    }
    return saturatedResult;
}

w32 mac(w32 c, w32 a, w32 b)  {
  int32_t multResult;
  int32_t result;
  
  multResult = INT32_SATURATION(a*b);
  result     = INT32_SATURATION(c + multResult);
  
  return result;
}

w32 exp(w32 a)  {
  int32_t result;
  if(a < 0){
      return 0;
  }
  else if (a > 21){
      return MAX_INT32;
  }
  else{
      return expRes[a];
  }
}
