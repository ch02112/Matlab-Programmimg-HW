#include "mex.h"
#include "matrix.h"
void lab12c(const double *A,const double *B,double *C, int n, int nb)
{
	 for (int i = 0; i < n; i++)
	 {
		 C[i] = 0;
		 for (int j = 0; j < nb/2 ; j++)
		 {
			 if(A[i] >= B[j] && A[i] < B[j+nb/2] )
			 {
				 C[i] = j+1;
				 break;
			 }
			 
		 }
	 }
}
/* The gateway routine */
void mexFunction(int nlhs, mxArray *plhs[],
 int nrhs, const mxArray *prhs[])
{
 /* input argument checking */
 if (nrhs != 2 || nlhs != 1) {
 mexErrMsgTxt("(lab12c) usage: C = lab12c(A,B)");
 }
 /* input A B*/
 double *A = mxGetPr(prhs[0]); //* pointer to the array content of A
 double *B = mxGetPr(prhs[1]); 
 
 int n = mxGetNumberOfElements(prhs[0]); // # elements
 int nb = mxGetNumberOfElements(prhs[1]); // # elements

 mwSize ndim = mxGetNumberOfDimensions(prhs[0]); // # dimensions
 const mwSize *dims = mxGetDimensions(prhs[0]); // sizes of the dimensions
 /* output C */
 plhs[0] = mxCreateNumericArray(ndim, dims, mxDOUBLE_CLASS, mxREAL);
 double *C = mxGetPr(plhs[0]); //* pointer to the array content of C
 /* actual processing */
 lab12c(A, B, C, n, nb);
}