// Tab Switching for Room Selector
function switchRoomTab(roomType) {
    // Remove active class from all tabs
    const tabs = document.querySelectorAll('.room-tab');
    tabs.forEach(tab => tab.classList.remove('active'));

    // Add active class to clicked tab
    event.target.classList.add('active');

    // Hide all room contents
    const contents = document.querySelectorAll('.room-content');
    contents.forEach(content => content.classList.remove('active'));

    // Show selected room content
    const selectedContent = document.getElementById(roomType);
    if (selectedContent) {
        selectedContent.classList.add('active');
    }
}

// FAQ Accordion Functionality
function toggleFAQ(element) {
    const faqItem = element.parentElement;
    const answer = faqItem.querySelector('.faq-answer');
    const isActive = faqItem.classList.contains('active');

    // Close all FAQ items
    const allFaqItems = document.querySelectorAll('.faq-item');
    allFaqItems.forEach(item => {
        item.classList.remove('active');
        item.querySelector('.faq-answer').style.maxHeight = null;
    });

    // Toggle current item
    if (!isActive) {
        faqItem.classList.add('active');
        answer.style.maxHeight = answer.scrollHeight + 'px';
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function () {
    // Set first room tab as active by default
    const firstTab = document.querySelector('.room-tab');
    const firstContent = document.querySelector('.room-content');

    if (firstTab && firstContent) {
        firstTab.classList.add('active');
        firstContent.classList.add('active');
    }
});
