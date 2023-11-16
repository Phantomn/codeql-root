// Code partially generated by https://github.com/gagliardetto/codebox, with manual additions
// for atomic.Pointer and Uintptr, as well as atomic.Value's Swap method.

package main

import (
	"sync/atomic"
	"unsafe"
)

func TaintStepTest_SyncAtomicAddUintptr_B0I0O0(sourceCQL interface{}) interface{} {
	fromUintptr656 := sourceCQL.(uintptr)
	var intoUintptr414 *uintptr
	atomic.AddUintptr(intoUintptr414, fromUintptr656)
	return intoUintptr414
}

func TaintStepTest_SyncAtomicAddUintptr_B0I0O1(sourceCQL interface{}) interface{} {
	fromUintptr518 := sourceCQL.(uintptr)
	intoUintptr650 := atomic.AddUintptr(nil, fromUintptr518)
	return intoUintptr650
}

func TaintStepTest_SyncAtomicCompareAndSwapPointer_B0I0O0(sourceCQL interface{}) interface{} {
	fromPointer784 := sourceCQL.(unsafe.Pointer)
	var intoPointer957 *unsafe.Pointer
	atomic.CompareAndSwapPointer(intoPointer957, nil, fromPointer784)
	return intoPointer957
}

func TaintStepTest_SyncAtomicCompareAndSwapUintptr_B0I0O0(sourceCQL interface{}) interface{} {
	fromUintptr520 := sourceCQL.(uintptr)
	var intoUintptr443 *uintptr
	atomic.CompareAndSwapUintptr(intoUintptr443, 0, fromUintptr520)
	return intoUintptr443
}

func TaintStepTest_SyncAtomicLoadPointer_B0I0O0(sourceCQL interface{}) interface{} {
	fromPointer127 := sourceCQL.(*unsafe.Pointer)
	intoPointer483 := atomic.LoadPointer(fromPointer127)
	return intoPointer483
}

func TaintStepTest_SyncAtomicLoadUintptr_B0I0O0(sourceCQL interface{}) interface{} {
	fromUintptr989 := sourceCQL.(*uintptr)
	intoUintptr982 := atomic.LoadUintptr(fromUintptr989)
	return intoUintptr982
}

func TaintStepTest_SyncAtomicStorePointer_B0I0O0(sourceCQL interface{}) interface{} {
	fromPointer417 := sourceCQL.(unsafe.Pointer)
	var intoPointer584 *unsafe.Pointer
	atomic.StorePointer(intoPointer584, fromPointer417)
	return intoPointer584
}

func TaintStepTest_SyncAtomicStoreUintptr_B0I0O0(sourceCQL interface{}) interface{} {
	fromUintptr991 := sourceCQL.(uintptr)
	var intoUintptr881 *uintptr
	atomic.StoreUintptr(intoUintptr881, fromUintptr991)
	return intoUintptr881
}

func TaintStepTest_SyncAtomicSwapPointer_B0I0O0(sourceCQL interface{}) interface{} {
	fromPointer186 := sourceCQL.(unsafe.Pointer)
	var intoPointer284 *unsafe.Pointer
	atomic.SwapPointer(intoPointer284, fromPointer186)
	return intoPointer284
}

func TaintStepTest_SyncAtomicSwapPointer_B1I0O0(sourceCQL interface{}) interface{} {
	fromPointer908 := sourceCQL.(*unsafe.Pointer)
	intoPointer137 := atomic.SwapPointer(fromPointer908, nil)
	return intoPointer137
}

func TaintStepTest_SyncAtomicSwapUintptr_B0I0O0(sourceCQL interface{}) interface{} {
	fromUintptr494 := sourceCQL.(uintptr)
	var intoUintptr873 *uintptr
	atomic.SwapUintptr(intoUintptr873, fromUintptr494)
	return intoUintptr873
}

func TaintStepTest_SyncAtomicSwapUintptr_B1I0O0(sourceCQL interface{}) interface{} {
	fromUintptr599 := sourceCQL.(*uintptr)
	intoUintptr409 := atomic.SwapUintptr(fromUintptr599, 0)
	return intoUintptr409
}

func TaintStepTest_SyncAtomicValueLoad_B0I0O0(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Value)
	intoInterface898 := fromValue246.Load()
	return intoInterface898
}

func TaintStepTest_SyncAtomicValueStore_B0I0O0(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(interface{})
	var intoValue631 atomic.Value
	intoValue631.Store(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicValueSwap(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(interface{})
	var intoValue631 atomic.Value
	intoValue631.Swap(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicValueSwap2(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Value)
	intoInterface898 := fromValue246.Swap("clean")
	return intoInterface898
}

func TaintStepTest_SyncAtomicPointerLoad_B0I0O0(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Pointer[string])
	intoInterface898 := fromValue246.Load()
	return intoInterface898
}

func TaintStepTest_SyncAtomicPointerStore_B0I0O0(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(*string)
	var intoValue631 atomic.Pointer[string]
	intoValue631.Store(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicPointerSwap(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(*string)
	var intoValue631 atomic.Pointer[string]
	intoValue631.Swap(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicPointerSwap2(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Pointer[string])
	clean := "Clean"
	intoInterface898 := fromValue246.Swap(&clean)
	return intoInterface898
}

func TaintStepTest_SyncAtomicUintptrLoad_B0I0O0(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Uintptr)
	intoInterface898 := fromValue246.Load()
	return intoInterface898
}

func TaintStepTest_SyncAtomicUintptrStore_B0I0O0(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(uintptr)
	var intoValue631 atomic.Uintptr
	intoValue631.Store(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicUintptrSwap(sourceCQL interface{}) interface{} {
	fromInterface598 := sourceCQL.(uintptr)
	var intoValue631 atomic.Uintptr
	intoValue631.Swap(fromInterface598)
	return intoValue631
}

func TaintStepTest_SyncAtomicUintptrSwap2(sourceCQL interface{}) interface{} {
	fromValue246 := sourceCQL.(atomic.Uintptr)
	clean := "Clean"
	intoInterface898 := fromValue246.Swap(uintptr(unsafe.Pointer(&clean)))
	return intoInterface898
}

func RunAllTaints_SyncAtomic() {
	{
		source := newSource(0)
		out := TaintStepTest_SyncAtomicAddUintptr_B0I0O0(source)
		sink(0, out)
	}
	{
		source := newSource(1)
		out := TaintStepTest_SyncAtomicAddUintptr_B0I0O1(source)
		sink(1, out)
	}
	{
		source := newSource(2)
		out := TaintStepTest_SyncAtomicCompareAndSwapPointer_B0I0O0(source)
		sink(2, out)
	}
	{
		source := newSource(3)
		out := TaintStepTest_SyncAtomicCompareAndSwapUintptr_B0I0O0(source)
		sink(3, out)
	}
	{
		source := newSource(4)
		out := TaintStepTest_SyncAtomicLoadPointer_B0I0O0(source)
		sink(4, out)
	}
	{
		source := newSource(5)
		out := TaintStepTest_SyncAtomicLoadUintptr_B0I0O0(source)
		sink(5, out)
	}
	{
		source := newSource(6)
		out := TaintStepTest_SyncAtomicStorePointer_B0I0O0(source)
		sink(6, out)
	}
	{
		source := newSource(7)
		out := TaintStepTest_SyncAtomicStoreUintptr_B0I0O0(source)
		sink(7, out)
	}
	{
		source := newSource(8)
		out := TaintStepTest_SyncAtomicSwapPointer_B0I0O0(source)
		sink(8, out)
	}
	{
		source := newSource(9)
		out := TaintStepTest_SyncAtomicSwapPointer_B1I0O0(source)
		sink(9, out)
	}
	{
		source := newSource(10)
		out := TaintStepTest_SyncAtomicSwapUintptr_B0I0O0(source)
		sink(10, out)
	}
	{
		source := newSource(11)
		out := TaintStepTest_SyncAtomicSwapUintptr_B1I0O0(source)
		sink(11, out)
	}
	{
		source := newSource(12)
		out := TaintStepTest_SyncAtomicValueLoad_B0I0O0(source)
		sink(12, out)
	}
	{
		source := newSource(13)
		out := TaintStepTest_SyncAtomicValueStore_B0I0O0(source)
		sink(13, out)
	}
	{
		source := newSource(14)
		out := TaintStepTest_SyncAtomicValueSwap(source)
		sink(14, out)
	}
	{
		source := newSource(15)
		out := TaintStepTest_SyncAtomicValueSwap2(source)
		sink(15, out)
	}
	{
		source := newSource(16)
		out := TaintStepTest_SyncAtomicPointerLoad_B0I0O0(source)
		sink(16, out)
	}
	{
		source := newSource(17)
		out := TaintStepTest_SyncAtomicPointerStore_B0I0O0(source)
		sink(17, out)
	}
	{
		source := newSource(18)
		out := TaintStepTest_SyncAtomicPointerSwap(source)
		sink(18, out)
	}
	{
		source := newSource(19)
		out := TaintStepTest_SyncAtomicPointerSwap2(source)
		sink(19, out)
	}
	{
		source := newSource(20)
		out := TaintStepTest_SyncAtomicUintptrLoad_B0I0O0(source)
		sink(20, out)
	}
	{
		source := newSource(21)
		out := TaintStepTest_SyncAtomicUintptrStore_B0I0O0(source)
		sink(21, out)
	}
	{
		source := newSource(22)
		out := TaintStepTest_SyncAtomicUintptrSwap(source)
		sink(22, out)
	}
	{
		source := newSource(23)
		out := TaintStepTest_SyncAtomicUintptrSwap2(source)
		sink(23, out)
	}
}
