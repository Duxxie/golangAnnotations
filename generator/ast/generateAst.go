package ast

import (
	"encoding/json"
	"io/ioutil"

	"github.com/Duxxie/golangAnnotations/generator"
	"github.com/Duxxie/golangAnnotations/generator/annotation"
	"github.com/Duxxie/golangAnnotations/generator/event/eventAnnotation"
	"github.com/Duxxie/golangAnnotations/generator/generationUtil"
	"github.com/Duxxie/golangAnnotations/model"
)

type Generator struct {
}

func NewGenerator() generator.Generator {
	return &Generator{}
}

func (eg *Generator) GetAnnotations() []annotation.AnnotationDescriptor {
	return eventAnnotation.Get()
}

func (eg *Generator) Generate(inputDir string, parsedSources model.ParsedSources) error {

	marshalled, err := json.MarshalIndent(parsedSources, "", "\t")
	if err != nil {
		panic(err)
	}
	targetFilename := generationUtil.Prefixed(inputDir + "/" + "ast.json")
	err = ioutil.WriteFile(targetFilename, marshalled, 0644)
	if err != nil {
		panic(err)
	}

	return nil
}
