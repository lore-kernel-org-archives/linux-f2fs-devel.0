From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 11/15] fscrypt: remove unnecessary check for
 non-logon key type
Date: Mon, 30 Apr 2018 15:51:45 -0700
Message-ID: <20180430225149.183514-12-ebiggers3@gmail.com>
References: <20180430225149.183514-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1fDHj5-0002y0-LL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Apr 2018 22:56:55 +0000
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fDHj4-00E6uT-DZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Apr 2018 22:56:55 +0000
Received: by mail-pg0-f66.google.com with SMTP id g20-v6so580669pgv.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 Apr 2018 15:56:54 -0700 (PDT)
In-Reply-To: <20180430225149.183514-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

We're passing 'key_type_logon' to request_key(), so the found key is
guaranteed to be of type "logon".  Thus, there is no reason to check
later that the key is really a "logon" key.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyinfo.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 0f6a65c6483b..0b48aa469453 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -89,12 +89,6 @@ static int validate_user_key(struct fscrypt_info *crypt_info,
 		return PTR_ERR(keyring_key);
 	down_read(&keyring_key->sem);
 
-	if (keyring_key->type != &key_type_logon) {
-		printk_once(KERN_WARNING
-				"%s: key type must be logon\n", __func__);
-		res = -ENOKEY;
-		goto out;
-	}
 	ukp = user_key_payload_locked(keyring_key);
 	if (!ukp) {
 		/* key was revoked before we acquired its semaphore */
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
