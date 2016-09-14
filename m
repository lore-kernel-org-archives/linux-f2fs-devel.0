From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] fscrypto: make fname_encrypt() actually return length of ciphertext
Date: Wed, 14 Sep 2016 13:57:13 -0700
Message-ID: <1473886634-24627-2-git-send-email-ebiggers@google.com>
References: <1473886634-24627-1-git-send-email-ebiggers@google.com>
Return-path: <linux-ext4-owner@vger.kernel.org>
In-Reply-To: <1473886634-24627-1-git-send-email-ebiggers@google.com>
Sender: linux-ext4-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu, jaegeuk@kernel.org, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This makes the return value match the comment.  Previously it would
actually return 0 if encryption was successful.  No callers currently
care, but this change should reduce the chance of future bugs.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fname.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3108806..7f3239c 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -103,12 +103,13 @@ static int fname_encrypt(struct inode *inode,
 	}
 	kfree(alloc_buf);
 	skcipher_request_free(req);
-	if (res < 0)
+	if (res < 0) {
 		printk_ratelimited(KERN_ERR
 				"%s: Error (error code %d)\n", __func__, res);
