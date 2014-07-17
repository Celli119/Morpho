#include "updateNormals.h"

SEXP updateVertexNormals(SEXP vb_, SEXP it_,SEXP angweight_) {
  try {
    typedef unsigned int uint;
    bool angweight = Rcpp::as<bool>(angweight_);
    NumericMatrix vb(vb_);
    IntegerMatrix it(it_);
    mat vbA(vb.begin(),vb.nrow(),vb.ncol());
    mat normals = vbA*0;
    imat itA(it.begin(),it.nrow(),it.ncol());
    //setup vectors to store temporary data
    colvec tmp0(3), tmp1(3), tmp2(3), angtmp(3), ntmp(3);
    int nit = it.ncol();
    for (int i=0; i < nit; ++i) {
      tmp0 = vbA.col(itA(1,i))-vbA.col(itA(0,i));
      tmp1 = vbA.col(itA(2,i))-vbA.col(itA(0,i));
      if (angweight) {
	tmp2 = vbA.col(itA(1,i))-vbA.col(itA(2,i));
	angtmp(0) = angcalcArma(tmp0,tmp1);
	angtmp(1) = angcalcArma(tmp0, tmp2);
	angtmp(2) = angcalcArma(-tmp1, tmp2);
      }
      crosspArma(tmp0,tmp1,ntmp);
      for (int j=0; j < 3; ++j) {
	double co = dot(normals.col(itA(j,i)),ntmp);
      
	if (co < 0)  {
	  if (!angweight) {
	    normals.col(itA(j,i)) -= ntmp;
	  } else {
	    normals.col(itA(j,i)) -= ntmp*angtmp(j);
	  }
	} else {
	  if (! angweight) {
	    normals.col(itA(j,i)) += ntmp;
	  } else {
	    normals.col(itA(j,i)) += ntmp*angtmp(j);
	  }
	}
      }
    }
    for (uint i=0; i < normals.n_cols; ++i) {
      double nlen = norm(normals.col(i),2);
      if (nlen > 0)
	normals.col(i) /= nlen;
    }
		       
    return Rcpp::wrap(normals);
  } catch (std::exception& e) {
    ::Rf_error( e.what());
  } catch (...) {
    ::Rf_error("unknown exception");
  }
}
      
SEXP updateFaceNormals(SEXP vb_, SEXP it_) {
  try {
    NumericMatrix vb(vb_);
    IntegerMatrix it(it_);
    mat vbA(vb.begin(),vb.nrow(),vb.ncol());
    mat normals(it.nrow(), it.ncol()); normals.fill(0.0);
    imat itA(it.begin(),it.nrow(),it.ncol());
    int nit = it.ncol();
    colvec tmp0(3), tmp1(3), ntmp(3);
    for (int i=0; i < nit; ++i) {
      tmp0 = vbA.col(itA(1,i))-vbA.col(itA(0,i));
      tmp1 = vbA.col(itA(2,i))-vbA.col(itA(0,i));
    
      crosspArma(tmp0,tmp1,ntmp);
      double nlen = norm(ntmp,2);
      if (nlen > 0)
	ntmp /= nlen; 
      normals.col(i) = ntmp;
    
    }
    return Rcpp::wrap(normals);
  } catch (std::exception& e) {
    ::Rf_error( e.what());
  } catch (...) {
    ::Rf_error("unknown exception");
  }
}
  
