/**
 * Test OpenClaw MCP Plugin
 */

const path = require('path');

// Mock OpenClaw API
const mockApi = {
  registeredTools: [],
  registerTool(tool, options) {
    this.registeredTools.push({ tool, options });
    console.log('✓ Registered:', tool.name);
  }
};

console.log('\n=== Testing OpenClaw MCP Plugin ===\n');

try {
  // Load the plugin
  const plugin = require('/Users/joshuamcmenamin/.openclaw/extensions/mcp-tools/index.js');
  
  console.log('Plugin loaded:', typeof plugin.register);
  
  // Register with mock API
  plugin.register(mockApi);
  
  console.log('\n--- Registered Tools ---');
  mockApi.registeredTools.forEach(({ tool }) => {
    console.log(`  • ${tool.name}`);
    console.log(`    ${tool.description.slice(0, 80)}...`);
  });
  
  console.log('\n=== All Tests Passed ===\n');
} catch (err) {
  console.error('Test failed:', err.message);
  console.error(err.stack);
  process.exit(1);
}
