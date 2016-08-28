From: Chao Yu <chao@kernel.org>
Subject: [PATCH] fscrypto: fix to null-terminate encrypted
	filename in fname_encrypt
Date: Sun, 28 Aug 2016 09:13:28 +0800
Message-ID: <1472346808-3213-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bdohS-0001S4-G0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 01:15:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdohQ-0003uF-1t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 28 Aug 2016 01:15:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: tytso@mit.edu, jaegeuk@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch fixes to add null character at the end of encrypted filename
in fname_encrypt, in order to avoid incorrectly traversing random data
located after target filename. The call stack is as below:

- f2fs_add_link
 - __f2fs_add_link
  - fscrypt_setup_filename
   - fscrypt_fname_alloc_buffer		allocate buffer for @fname
   - fname_encrypt			didn't set null character for @fname
  - f2fs_add_regular_entry		init qstr with @fname
   - init_inode_metadata
    - f2fs_init_security
     - security_inode_init_security
      - selinux_inode_init_security
       - selinux_determine_inode_label
        - security_transition_sid
	 - security_compute_sid
	  - filename_compute_type
	   - hashtab_search
	    - filenametr_hash		traverse @fname as one which has null character

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/crypto/fname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 5d6d491..5c356c0 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -110,6 +110,7 @@ static int fname_encrypt(struct inode *inode,
 				"%s: Error (error code %d)\n", __func__, res);
 
 	oname->len = ciphertext_len;
+	oname->name[oname->len] = 0;
 	return res;
 }
 
-- 
2.7.2


------------------------------------------------------------------------------
