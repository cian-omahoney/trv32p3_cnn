#define MAX_INT32 2147483647
#define MIN_INT32 -2147483648

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


