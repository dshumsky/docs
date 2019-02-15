// Code generated by protoc-gen-go.
// source: rpc.proto
// DO NOT EDIT!

/*
Package main is a generated protocol buffer package.

It is generated from these files:
	rpc.proto

It has these top-level messages:
	WatchRequest
	WatchCreateRequest
*/
package main

import proto "github.com/golang/protobuf/proto"
import fmt "fmt"
import math "math"

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion2 // please upgrade the proto package

type WatchRequest struct {
	// Types that are valid to be assigned to RequestUnion:
	//	*WatchRequest_CreateRequest
	RequestUnion isWatchRequest_RequestUnion `protobuf_oneof:"request_union"`
}

func (m *WatchRequest) Reset()                    { *m = WatchRequest{} }
func (m *WatchRequest) String() string            { return proto.CompactTextString(m) }
func (*WatchRequest) ProtoMessage()               {}
func (*WatchRequest) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{0} }

type isWatchRequest_RequestUnion interface {
	isWatchRequest_RequestUnion()
}

type WatchRequest_CreateRequest struct {
	CreateRequest *WatchCreateRequest `protobuf:"bytes,1,opt,name=create_request,json=createRequest,oneof"`
}

func (*WatchRequest_CreateRequest) isWatchRequest_RequestUnion() {}

func (m *WatchRequest) GetRequestUnion() isWatchRequest_RequestUnion {
	if m != nil {
		return m.RequestUnion
	}
	return nil
}

func (m *WatchRequest) GetCreateRequest() *WatchCreateRequest {
	if x, ok := m.GetRequestUnion().(*WatchRequest_CreateRequest); ok {
		return x.CreateRequest
	}
	return nil
}

// XXX_OneofFuncs is for the internal use of the proto package.
func (*WatchRequest) XXX_OneofFuncs() (func(msg proto.Message, b *proto.Buffer) error, func(msg proto.Message, tag, wire int, b *proto.Buffer) (bool, error), func(msg proto.Message) (n int), []interface{}) {
	return _WatchRequest_OneofMarshaler, _WatchRequest_OneofUnmarshaler, _WatchRequest_OneofSizer, []interface{}{
		(*WatchRequest_CreateRequest)(nil),
	}
}

func _WatchRequest_OneofMarshaler(msg proto.Message, b *proto.Buffer) error {
	m := msg.(*WatchRequest)
	// request_union
	switch x := m.RequestUnion.(type) {
	case *WatchRequest_CreateRequest:
		b.EncodeVarint(1<<3 | proto.WireBytes)
		if err := b.EncodeMessage(x.CreateRequest); err != nil {
			return err
		}
	case nil:
	default:
		return fmt.Errorf("WatchRequest.RequestUnion has unexpected type %T", x)
	}
	return nil
}

func _WatchRequest_OneofUnmarshaler(msg proto.Message, tag, wire int, b *proto.Buffer) (bool, error) {
	m := msg.(*WatchRequest)
	switch tag {
	case 1: // request_union.create_request
		if wire != proto.WireBytes {
			return true, proto.ErrInternalBadWireType
		}
		msg := new(WatchCreateRequest)
		err := b.DecodeMessage(msg)
		m.RequestUnion = &WatchRequest_CreateRequest{msg}
		return true, err
	default:
		return false, nil
	}
}

func _WatchRequest_OneofSizer(msg proto.Message) (n int) {
	m := msg.(*WatchRequest)
	// request_union
	switch x := m.RequestUnion.(type) {
	case *WatchRequest_CreateRequest:
		s := proto.Size(x.CreateRequest)
		n += proto.SizeVarint(1<<3 | proto.WireBytes)
		n += proto.SizeVarint(uint64(s))
		n += s
	case nil:
	default:
		panic(fmt.Sprintf("proto: unexpected type %T in oneof", x))
	}
	return n
}

type WatchCreateRequest struct {
	Key []byte `protobuf:"bytes,1,opt,name=key,proto3" json:"key,omitempty"`
}

func (m *WatchCreateRequest) Reset()                    { *m = WatchCreateRequest{} }
func (m *WatchCreateRequest) String() string            { return proto.CompactTextString(m) }
func (*WatchCreateRequest) ProtoMessage()               {}
func (*WatchCreateRequest) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{1} }

func init() {
	proto.RegisterType((*WatchRequest)(nil), "main.WatchRequest")
	proto.RegisterType((*WatchCreateRequest)(nil), "main.WatchCreateRequest")
}

func init() { proto.RegisterFile("rpc.proto", fileDescriptor0) }

var fileDescriptor0 = []byte{
	// 133 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x09, 0x6e, 0x88, 0x02, 0xff, 0xe2, 0xe2, 0x2c, 0x2a, 0x48, 0xd6,
	0x2b, 0x28, 0xca, 0x2f, 0xc9, 0x17, 0x62, 0xc9, 0x4d, 0xcc, 0xcc, 0x53, 0x4a, 0xe2, 0xe2, 0x09,
	0x4f, 0x2c, 0x49, 0xce, 0x08, 0x4a, 0x2d, 0x2c, 0x4d, 0x2d, 0x2e, 0x11, 0x72, 0xe4, 0xe2, 0x4b,
	0x2e, 0x4a, 0x4d, 0x2c, 0x49, 0x8d, 0x2f, 0x82, 0x88, 0x48, 0x30, 0x2a, 0x30, 0x6a, 0x70, 0x1b,
	0x49, 0xe8, 0x81, 0x94, 0xeb, 0x81, 0xd5, 0x3a, 0x83, 0x15, 0x40, 0x75, 0x78, 0x30, 0x04, 0xf1,
	0x26, 0x23, 0x0b, 0x38, 0xf1, 0x73, 0xf1, 0x42, 0xf5, 0xc6, 0x97, 0xe6, 0x65, 0xe6, 0xe7, 0x29,
	0xa9, 0x71, 0x09, 0x61, 0xea, 0x13, 0x12, 0xe0, 0x62, 0xce, 0x4e, 0xad, 0x04, 0x1b, 0xcf, 0x13,
	0x04, 0x62, 0x26, 0xb1, 0x81, 0x1d, 0x66, 0x0c, 0x08, 0x00, 0x00, 0xff, 0xff, 0x07, 0x06, 0x64,
	0xdf, 0xa5, 0x00, 0x00, 0x00,
}
