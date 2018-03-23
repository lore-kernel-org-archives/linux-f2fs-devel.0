From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 04/14] fscrypt: remove stale comment from
 fscrypt_d_revalidate()
Date: Fri, 23 Mar 2018 12:23:48 -0700
Message-ID: <20180323192358.95691-5-ebiggers3@gmail.com>
References: <20180323192358.95691-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1ezSPK-0002tg-Af
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Mar 2018 19:31:22 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-pg0-f66.google.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1ezSPI-00GdYD-V8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Mar 2018 19:31:22 +0000
Received: by mail-pg0-f66.google.com with SMTP id f10so4786309pgs.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Mar 2018 12:31:20 -0700 (PDT)
In-Reply-To: <20180323192358.95691-1-ebiggers3@gmail.com>
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 58761d816751..d22887f689ad 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -322,7 +322,6 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 		return 0;
 	}
 
-	/* this should eventually be an flag in d_flags */
 	spin_lock(&dentry->d_lock);
 	cached_with_key = dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY;
 	spin_unlock(&dentry->d_lock);
-- 
2.17.0.rc0.231.g781580f067-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
