require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << "test"

  task.test_files = Dir['test/**/test_*.rb'].reject {|path| path.end_with?("test_explore.rb") }
  task.verbose    = true
  task.warning    = true
end

Rake::TestTask.new("test:explore") do |task|
  task.libs << "test"
  task.pattern = 'test/tree_spell/test_explore.rb'
  task.verbose = true
  task.warning = true
end

task default: %i(test)

namespace :test do
  namespace :accuracy do
    desc "Download Wiktionary's Simple English data and save it as a dictionary"
    task :prepare do
      sh 'ruby evaluation/dictionary_generator.rb'
    end
  end

  desc "Calculate accuracy of the gem's spell checker"
  task :accuracy do
    if !File.exist?("evaluation/dictionary.yml")
      puts 'Generating dictionary for evaluation:'
      Rake::Task["test:accuracy:prepare"].execute
      puts "\n"
    end

    sh 'ruby evaluation/calculator.rb'
  end
end

namespace :benchmark do
  namespace :ips do
    desc "Measure performance of the gem's Jaro distance implementation"
    task :jaro do
      sh "ruby benchmark/jaro_winkler/speed.rb"
    end

    desc "Benchmark performance of the gem's Levenshtein distance implementation"
    task :levenshtein do
      sh "ruby benchmark/levenshtein/speed.rb"
    end
  end

  desc "Benchmark memory usage in the gem's spell checker"
  task :memory do
    sh "ruby benchmark/memory_usage.rb"
  end

  namespace :memory do
    desc "Benchmark memory usage in the gem's Jaro distance implementation"
    task :jaro do
      sh "ruby benchmark/jaro_winkler/memory_usage.rb"
    end

    desc "Benchmark memory usage in the gem's Levenshtein distance implementation"
    task :levenshtein do
      sh "ruby benchmark/levenshtein/memory_usage.rb"
    end
  end
end
