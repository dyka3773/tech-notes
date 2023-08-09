<!-- omit in toc -->
# Useful PHP Snippets

<!-- omit in toc -->
## Table of Contents


## Send email to Someone by POSTing data to a PHP script

The snippet below can be used to send an email to someone by POSTing data to it (usually by a form).

The snippet can be used as follows:

```html
<form method="post" action="send-email.php">
    <input type="text" name="page-title" value="Page Title" hidden> <!-- The title of the page or the form should be passed in here -->
    <textarea name="data"></textarea>
    <button type="submit">Send</button>
</form>
```

```php
<?php
    // NOTE: This could also be set by the caller of the script
    $email_to = "example@email.com"; // The message will be sent to this email
    $email_subject = "New Form submission"; // The subject of the email

    $message = $_POST['data']; // The message/body of the email that will be sent
    
    if (isset($_POST['page-title'])){ // In case the page title is passed, append it to the end of the email subject (usually this snippet is used on multiple pages)
        $page_title = $_POST['page-title'];
        $email_subject = $email_subject . " - " . $page_title;
    }

    // An example message format. You can change this to whatever you want.
    $email_message = "Form details below.\n\n";
    $email_message .= "Message: " . $message . "\n";

    // The required headers for the email
    $headers = 'From: my@mail.com' . "\r\n" .
    'Reply-To: my@mail.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

    @mail($email_to, $email_subject, $email_message, $headers); // The actual command that sends the email
?>
```