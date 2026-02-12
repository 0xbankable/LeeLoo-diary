/**
 * OpenClaw MCP Tools Loader
 * 
 * This file loads MCP tools into OpenClaw's tool system.
 * Add to OpenClaw's initialization to enable MCP tools.
 */

const path = require('path');

// Load the compiled MCP tools
const mcpPath = path.join(__dirname, '..', '.claude', 'skills', 'mcp-tools', 'dist');
const { getAllTools, executeTool, isMcpTool } = require(mcpPath);

/**
 * Register MCP tools with OpenClaw
 * @param {Object} toolRegistry - OpenClaw's tool registry
 */
function registerMcpTools(toolRegistry) {
  const tools = getAllTools();
  
  console.log('[MCP] Registering', tools.length, 'tools with OpenClaw');
  
  for (const tool of tools) {
    // Register each tool with OpenClaw
    toolRegistry.register({
      name: tool.name,
      description: tool.description,
      parameters: tool.parameters,
      handler: async (args) => {
        const result = await executeTool(tool.name, args);
        
        if (result.isError) {
          throw new Error(result.content[0]?.text || 'Tool execution failed');
        }
        
        return result.content[0]?.text || 'Done';
      }
    });
    
    console.log('[MCP] Registered:', tool.name);
  }
}

/**
 * Check if a tool call is for an MCP tool
 */
function isMcpToolCall(toolName) {
  return getAllTools().some(t => t.name === toolName);
}

/**
 * Execute an MCP tool by name
 */
async function executeMcpTool(toolName, args) {
  const result = await executeTool(toolName, args);
  
  if (result.isError) {
    throw new Error(result.content[0]?.text || 'Tool execution failed');
  }
  
  return result.content[0]?.text || 'Done';
}

module.exports = {
  registerMcpTools,
  isMcpToolCall,
  executeMcpTool,
  getMcpTools: getAllTools
};
