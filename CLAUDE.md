# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code CLI configuration repository that provides 25 specialized development commands with session-based intelligence. The system is designed for AI-assisted development with automatic pattern recognition, session continuity, and comprehensive quality assurance.

## Key Commands

### Core Development
- `/implement` - Smart feature implementation with session continuity and auto-resume
- `/scaffold` - Intelligent project scaffolding that follows existing code patterns
- `/test` - Context-aware test runner with automatic failure analysis and fixes
- `/refactor` - Systematic code restructuring with functionality preservation validation
- `/security-scan` - Comprehensive security analysis with remediation tracking

### Workflow Management
- `/session-start` - Begin documented coding sessions with state tracking
- `/session-end` - Complete sessions with automatic summaries
- `/commit` - Git commit with standardized messages (no AI attribution)
- `/review` - Code review assistance with quality checks

### Code Quality
- `/format` - Intelligent code formatting following project conventions
- `/fix-imports` - Import statement optimization and cleanup
- `/fix-todos` - TODO management and systematic resolution

## Architecture

### Session-Based Design
All commands create session directories in the current project (e.g., `implement/`, `scaffold/`, `refactor/`) with:
- `plan.md` - Detailed execution plan and progress tracking
- `state.json` - Session state for resuming work across interruptions
- Automatic detection and resume of existing sessions

### Configuration Structure
```
commands/           # 25 command definitions (.md files)
projects/           # Session logs per project (.jsonl)
todos/             # Todo tracking with unique session IDs
settings.json      # Main CLI configuration
statusline.sh      # Git-aware custom status line
```

### Git Integration
- Custom status line showing branch, diff stats, and working tree status
- Standardized commit messages without AI attribution
- Never modifies git config or user credentials
- Built-in git hygiene enforcement

## Development Guidelines

### File Creation Policy
- **Never create files unless absolutely necessary** - always prefer editing existing files
- **No documentation files** unless explicitly requested by user
- Session files are created in current project directory, never in parent/home directories

### Session Continuity
- All commands support automatic resume from interruptions
- Session state preserved across Claude Code instances
- Progress tracking through structured todo lists and state files

### Code Quality Standards
- Comprehensive validation after every change
- Pattern-based approach that matches existing code style
- Built-in testing with auto-fix capabilities
- Security scanning with remediation tracking

### Git Standards
- No AI attribution in commits (no "Co-authored-by Claude" signatures)
- Clean commit messages following project conventions
- Automatic staging of relevant files
- Never modify git configuration

## Command Patterns

### Phase-Based Execution
Commands follow structured phases:
1. **Analysis** - Deep pattern recognition and project understanding
2. **Planning** - Detailed execution plan with validation steps
3. **Implementation** - Systematic code changes with progress tracking
4. **Validation** - Comprehensive testing and quality assurance
5. **Completion** - Session summary and state cleanup

### Intelligence Features
- **Auto-detection** of existing sessions and work-in-progress
- **Pattern matching** to follow existing code conventions
- **Context awareness** for project-specific requirements
- **Dependency tracking** for complex refactoring operations
- **Rollback capabilities** when validation fails

## Special Considerations

### Session Management
- Sessions are project-specific and isolated
- Multiple simultaneous sessions supported across different projects
- Session state includes full context for seamless resume
- Automatic cleanup of completed sessions

### Integration Points
- Statsig analytics for feature flag management
- Todo system with unique session IDs for progress tracking
- Shell integration via custom status line
- Project memory through CLAUDE.md generation

### Quality Assurance
- Every command includes built-in validation steps
- Automatic rollback on test failures
- Security scanning with remediation guidance
- Pattern compliance verification before completion