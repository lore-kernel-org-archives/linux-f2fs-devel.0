From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 24/24] fscrypt: document symlink length
 restriction
Date: Fri, 15 Dec 2017 09:42:25 -0800
Message-ID: <20171215174225.31583-25-ebiggers3@gmail.com>
References: <20171215174225.31583-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ebiggers3@gmail.com>) id 1ePu4l-0005RN-Lj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:47:11 +0000
Received: from mail-pg0-f67.google.com ([74.125.83.67])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1ePu4k-00055b-SJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Dec 2017 17:47:11 +0000
Received: by mail-pg0-f67.google.com with SMTP id o2so6251127pgc.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Dec 2017 09:47:10 -0800 (PST)
In-Reply-To: <20171215174225.31583-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document that encryption reduces the maximum length of a symlink target
slightly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 776ddc655f79..cfbc18f0d9c9 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -448,8 +448,14 @@ astute users may notice some differences in behavior:
 
 - The st_size of an encrypted symlink will not necessarily give the
   length of the symlink target as required by POSIX.  It will actually
-  give the length of the ciphertext, which may be slightly longer than
-  the plaintext due to the NUL-padding.
+  give the length of the ciphertext, which will be slightly longer
+  than the plaintext due to NUL-padding and an extra 2-byte overhead.
+
+- The maximum length of an encrypted symlink is 2 bytes shorter than
+  the maximum length of an unencrypted symlink.  For example, on an
+  EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
+  to 4095 bytes long, while encrypted symlinks can only be up to 4093
+  bytes long (both lengths excluding the terminating null).
 
 Note that mmap *is* supported.  This is possible because the pagecache
 for an encrypted file contains the plaintext, not the ciphertext.
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
