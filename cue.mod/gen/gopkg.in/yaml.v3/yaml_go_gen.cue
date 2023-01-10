// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go gopkg.in/yaml.v3

// Package yaml implements YAML support for the Go language.
//
// Source code and other details for the project are available at GitHub:
//
//   https://github.com/go-yaml/yaml
//
package yaml

// The Unmarshaler interface may be implemented by types to customize their
// behavior when being unmarshaled from a YAML document.
#Unmarshaler: _

_#obsoleteUnmarshaler: _

// The Marshaler interface may be implemented by types to customize their
// behavior when being marshaled into a YAML document. The returned value
// is marshaled in place of the original value implementing Marshaler.
//
// If an error is returned by MarshalYAML, the marshaling procedure stops
// and returns with the provided error.
#Marshaler: _

// A TypeError is returned by Unmarshal when one or more fields in
// the YAML document cannot be properly decoded into the requested
// types. When this error is returned, the value is still
// unmarshaled partially.
#TypeError: {
	Errors: [...string] @go(,[]string)
}

#Kind: uint32 // #enumKind

#enumKind:
	#DocumentNode |
	#SequenceNode |
	#MappingNode |
	#ScalarNode |
	#AliasNode

#values_Kind: {
	DocumentNode: #DocumentNode
	SequenceNode: #SequenceNode
	MappingNode:  #MappingNode
	ScalarNode:   #ScalarNode
	AliasNode:    #AliasNode
}

#DocumentNode: #Kind & 1
#SequenceNode: #Kind & 2
#MappingNode:  #Kind & 4
#ScalarNode:   #Kind & 8
#AliasNode:    #Kind & 16

#Style: uint32 // #enumStyle

#enumStyle:
	#TaggedStyle |
	#DoubleQuotedStyle |
	#SingleQuotedStyle |
	#LiteralStyle |
	#FoldedStyle |
	#FlowStyle

#values_Style: {
	TaggedStyle:       #TaggedStyle
	DoubleQuotedStyle: #DoubleQuotedStyle
	SingleQuotedStyle: #SingleQuotedStyle
	LiteralStyle:      #LiteralStyle
	FoldedStyle:       #FoldedStyle
	FlowStyle:         #FlowStyle
}

#TaggedStyle:       #Style & 1
#DoubleQuotedStyle: #Style & 2
#SingleQuotedStyle: #Style & 4
#LiteralStyle:      #Style & 8
#FoldedStyle:       #Style & 16
#FlowStyle:         #Style & 32

// Node represents an element in the YAML document hierarchy. While documents
// are typically encoded and decoded into higher level types, such as structs
// and maps, Node is an intermediate representation that allows detailed
// control over the content being decoded or encoded.
//
// It's worth noting that although Node offers access into details such as
// line numbers, colums, and comments, the content when re-encoded will not
// have its original textual representation preserved. An effort is made to
// render the data plesantly, and to preserve comments near the data they
// describe, though.
//
// Values that make use of the Node type interact with the yaml package in the
// same way any other type would do, by encoding and decoding yaml data
// directly or indirectly into them.
//
// For example:
//
//     var person struct {
//             Name    string
//             Address yaml.Node
//     }
//     err := yaml.Unmarshal(data, &person)
// 
// Or by itself:
//
//     var person Node
//     err := yaml.Unmarshal(data, &person)
//
#Node: {
	// Kind defines whether the node is a document, a mapping, a sequence,
	// a scalar value, or an alias to another node. The specific data type of
	// scalar nodes may be obtained via the ShortTag and LongTag methods.
	Kind: #Kind

	// Style allows customizing the apperance of the node in the tree.
	Style: #Style

	// Tag holds the YAML tag defining the data type for the value.
	// When decoding, this field will always be set to the resolved tag,
	// even when it wasn't explicitly provided in the YAML content.
	// When encoding, if this field is unset the value type will be
	// implied from the node properties, and if it is set, it will only
	// be serialized into the representation if TaggedStyle is used or
	// the implicit tag diverges from the provided one.
	Tag: string

	// Value holds the unescaped and unquoted represenation of the value.
	Value: string

	// Anchor holds the anchor name for this node, which allows aliases to point to it.
	Anchor: string

	// Alias holds the node that this alias points to. Only valid when Kind is AliasNode.
	Alias?: null | #Node @go(,*Node)

	// Content holds contained nodes for documents, mappings, and sequences.
	Content: [...null | #Node] @go(,[]*Node)

	// HeadComment holds any comments in the lines preceding the node and
	// not separated by an empty line.
	HeadComment: string

	// LineComment holds any comments at the end of the line where the node is in.
	LineComment: string

	// FootComment holds any comments following the node and before empty lines.
	FootComment: string

	// Line and Column hold the node position in the decoded YAML text.
	// These fields are not respected when encoding the node.
	Line:   int
	Column: int
}

// structInfo holds details for the serialization of fields of
// a given struct.
_#structInfo: {
	FieldsMap: {[string]: _#fieldInfo} @go(,map[string]fieldInfo)
	FieldsList: [..._#fieldInfo] @go(,[]fieldInfo)

	// InlineMap is the number of the field in the struct that
	// contains an ,inline map, or -1 if there's none.
	InlineMap: int

	// InlineUnmarshalers holds indexes to inlined fields that
	// contain unmarshaler values.
	InlineUnmarshalers: [...[...int]] @go(,[][]int)
}

_#fieldInfo: {
	Key:       string
	Num:       int
	OmitEmpty: bool
	Flow:      bool

	// Id holds the unique field identifier, so we can cheaply
	// check for field duplicates without maintaining an extra map.
	Id: int

	// Inline holds the field index if the field is part of an inlined struct.
	Inline: [...int] @go(,[]int)
}

// IsZeroer is used to check whether an object is zero to
// determine whether it should be omitted when marshaling
// with the omitempty flag. One notable implementation
// is time.Time.
#IsZeroer: _