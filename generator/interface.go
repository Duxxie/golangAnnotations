package generator

import (
	"github.com/Duxxie/golangAnnotations/generator/annotation"
	"github.com/Duxxie/golangAnnotations/model"
)

const (
	GenfilePrefix       = "gen_"
	GenfileExcludeRegex = GenfilePrefix + ".*"
)

type Generator interface {
	GetAnnotations() []annotation.AnnotationDescriptor
	Generate(inputDir string, parsedSources model.ParsedSources) error
}
