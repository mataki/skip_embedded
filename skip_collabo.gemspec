# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{skip_collabo}
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["MOROHASHI Kyosuke"]
  s.date = %q{2009-03-03}
  s.description = %q{Utilities to collabolate SKIP, opensource buisiness SNS.}
  s.email = %q{k-morohashi@esm.co.jp}
  s.extra_rdoc_files = ["README.rdoc", "ChangeLog"]
  s.files = ["README.rdoc", "ChangeLog", "Rakefile", "lib/skip_collabo", "lib/skip_collabo/fulltext_search_cache", "lib/skip_collabo/fulltext_search_cache/builder_base.rb", "lib/skip_collabo/fulltext_search_cache/mediator.rb", "lib/skip_collabo/fulltext_search_cache/partial_loader.rb", "lib/skip_collabo/fulltext_search_cache.rb", "lib/skip_collabo/op_fixation.rb", "lib/skip_collabo.rb", "spec/skip_collabo/fulltext_search_cache/builder_base_spec.rb", "spec/skip_collabo/fulltext_search_cache/mediator_spec.rb", "spec/skip_collabo/fulltext_search_cache/partial_loader_spec.rb", "spec/skip_collabo/op_fixation_spec.rb", "spec/spec_helper.rb", "rails/init.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/moro/scope_do/tree/master}
  s.rdoc_options = ["--title", "skip_collabo documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Utilities to collabolate SKIP, opensource buisiness SNS.}
  s.test_files = ["spec/skip_collabo/fulltext_search_cache/builder_base_spec.rb", "spec/skip_collabo/fulltext_search_cache/mediator_spec.rb", "spec/skip_collabo/fulltext_search_cache/partial_loader_spec.rb", "spec/skip_collabo/op_fixation_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
