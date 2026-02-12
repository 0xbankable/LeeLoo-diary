/**
 * Test MCP Tools Integration
 */

const { registerMcpTools, isMcpToolCall, executeMcpTool, getMcpTools } = require('./mcp-tools-loader.js');

// Mock OpenClaw tool registry
const mockRegistry = {
  registered: [],
  register(tool) {
    this.registered.push(tool);
    console.log('✓ Registered:', tool.name);
  }
};

console.log('\n=== MCP Tools Integration Test ===\n');

// Register tools
console.log('Registering MCP tools with OpenClaw...\n');
registerMcpTools(mockRegistry);

console.log('\n--- Registered Tools ---');
mockRegistry.registered.forEach(t => {
  console.log(`  • ${t.name}`);
  console.log(`    ${t.description.slice(0, 80)}...`);
});

console.log('\n--- Testing isMcpToolCall ---');
console.log('isMcpToolCall("send_message"):', isMcpToolCall('send_message'));
console.log('isMcpToolCall("unknown_tool"):', isMcpToolCall('unknown_tool'));

console.log('\n--- Testing executeMcpTool ---');
executeMcpTool('send_message', { text: 'Test message', channel: 'current' })
  .then(result => {
    console.log('send_message result:', result);
    
    return executeMcpTool('schedule_task', { 
      prompt: 'Test task', 
      schedule: '0 9 * * *',
      context: 'isolated'
    });
  })
  .then(result => {
    console.log('schedule_task result:', result);
    console.log('\n=== All Tests Passed ===\n');
  })
  .catch(err => {
    console.error('Test failed:', err);
    process.exit(1);
  });
