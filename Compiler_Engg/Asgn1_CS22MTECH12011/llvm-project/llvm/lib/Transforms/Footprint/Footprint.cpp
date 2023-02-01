// Authors : Soumya Banerjee (CS22MTECH12011), Raj Ambekar (CS22MTECH12008)
// Compiler Engineering CS6383 - Assignment-1

#include "llvm/IR/Module.h"
#include "llvm/IR/Metadata.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constant.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/DebugInfoMetadata.h"


using namespace llvm;

static cl::opt<std::string> varName("var-name", cl::desc("The name of the input variable"), cl::Required);

namespace{


  struct func_pass : public FunctionPass {
    static char ID;
    func_pass () : FunctionPass(ID) {}

    int firstLine, lastLine,numOfReads,numOfWrites;
    bool runOnFunction(Function &F) override {
      std::set<unsigned> lineNumbers;                 // set to store the footprints of a variable
      numOfReads=0;
      numOfWrites=0;
      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; I++) {
        LoadInst *LI;
        StoreInst *SI;
        if (LoadInst *LI = dyn_cast<LoadInst>(&*I)) {
          if (LI->getPointerOperand()->getName() == varName) {
            //errs() << "Variable accessed at line =" << LI->getDebugLoc().getLine() << "\n";
            lineNumbers.insert(LI->getDebugLoc().getLine());
            numOfReads++;
          }
        }
        else if (StoreInst *SI = dyn_cast<StoreInst>(&*I)) {
          if (SI->getPointerOperand()->getName() == varName) {
            //errs() << "Variable accessed at line =" << SI->getDebugLoc().getLine() << "\n";
            lineNumbers.insert(SI->getDebugLoc().getLine());
            numOfWrites++;
          }
        }
      }

      firstLine = INT_MAX;
      lastLine = INT_MIN;
      // to find the scope of the variable
      for (auto &BB : F) {      // iterating over basic blocks
        for (auto &I : BB) {    // iterating over instructions
          if (auto *lI = dyn_cast<LoadInst>(&I)) {
            if (lI->getPointerOperand()->getName() == varName) {
              auto lineNo = I.getDebugLoc().getLine();
                if (lineNo < firstLine) {
                  firstLine = lineNo;
                }
                if (lineNo > lastLine) {
                  lastLine = lineNo;
                }
              }
            }
          if (auto *sI = dyn_cast<StoreInst>(&I)) {
            if (sI->getPointerOperand()->getName() == varName) {
              auto lineNo = I.getDebugLoc().getLine();
                if (lineNo < firstLine) {
                  firstLine = lineNo;
                }
                if (lineNo > lastLine) {
                  lastLine = lineNo;
                }
            }
          }
        }
      }
      auto *LastInst = &F.back().back();    // finding the end of the function
      //lastLine=std::min(lastLine, LastInst->getDebugLoc().getLine());
      outs() << "Variable Name : "<< varName <<"\n";
      outs() << "Variable Scope : " << firstLine << ":" <<  LastInst->getDebugLoc().getLine() << "\n";
      outs() << "Footprint : ";
      int c=0;
      for(unsigned lineNo : lineNumbers){
        if(c==0)
        outs() << lineNo;
        else
        outs()<<", "<<lineNo;
        c++;

      }
      outs()<<"\n";

      outs() << "Number of Reads : " << numOfReads << "\n";
      outs() << "Number of Writes : " << numOfWrites << "\n";
      return false;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.setPreservesAll();
    }
  };

char func_pass ::ID = 0;

struct ftprint : public ModulePass {
  static char ID;
  ftprint() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    auto *NMD = M.getNamedMetadata("llvm.ident");
    if (!NMD)
      return false;

    auto *MD = NMD->getOperand(0);
    if (!MD)
      return false;

    // auto *ClangVersion = mdconst::dyn_extract<MDString>(MD->getOperand(0));
    auto *ClangVersion = cast<MDString>(MD->getOperand(0));
      //outs() << "Clang version: " << ClangVersion->getString() << "\n";
      //llvm::StringRef Clang_ver = ClangVersion->getString().substr(14,7);
      //outs() << "Clang version: " << Clang_ver << "\n";

      size_t found_version = ClangVersion->getString().find("version");
      size_t found_https = ClangVersion->getString().find("https");
      size_t found_git = ClangVersion->getString().find(".git");
      size_t found_opening_bracket=ClangVersion->getString().find("(");
      size_t found_closing_bracket=ClangVersion->getString().find(")");
      size_t length=found_git-found_https+4;
      size_t ver=found_opening_bracket-found_version-7;
      outs() << "Clang version : " << ClangVersion->getString().substr(found_version+7,ver) << "\n";
      if (found_https != llvm::StringRef::npos && found_git!=llvm::StringRef::npos) {
        //llvm::errs() << "Substring found at position: " << found << "\n";
        //outs() << "Starting point:"<< found_https <<" Ending point:"<< found_git<< "\n";
        outs() << "LLVM Source Repository : " << ClangVersion->getString().substr(found_https,length) << "\n";
        outs() << "LLVM Commit Hash : " << ClangVersion->getString().substr(found_git+4,found_closing_bracket-found_git-4) <<"\n";
      }
      outs() << "Target : " <<M.getTargetTriple()<<"\n";

    for (auto &F : M) {
      func_pass ().runOnFunction(F);
      break;
    }
    return false;
  }

};
}

char ftprint::ID = 0;
static RegisterPass<ftprint> X("ftprint", "Pass for printing the final output desired");
