package parser

import "github.com/Duxxie/golangAnnotations/model"

type Parser interface {
	ParseSourceDir(dirName string, includeRegex string, excludeRegex string) (model.ParsedSources, error)
}
