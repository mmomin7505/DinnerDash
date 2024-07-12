document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.remove-cart-item').forEach(button => {
      button.addEventListener('click', () => {
        const itemId = button.dataset.itemId;
        fetch(`/cart_items/${itemId}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': Rails.csrfToken()
          }
        })
        .then(response => {
          if (response.ok) {
            window.location.reload();
          } else {
            console.error('Failed to remove item:', response.status);
          }
        })
        .catch(error => {
          console.error('Error:', error);
        });
      });
    });
  });