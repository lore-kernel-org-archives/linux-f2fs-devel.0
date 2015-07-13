From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/4] f2fs: correct return value of ->setxattr
Date: Mon, 13 Jul 2015 17:45:19 +0800
Message-ID: <008101d0bd50$b8bc83e0$2a358ba0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to return correct error number of ->setxattr, which
is reported by xfstest tests/generic/026 as below:

generic/026      - output mismatch
    --- tests/generic/026.out
    +++ results/generic/026.out.bad
    @@ -4,6 +4,6 @@
     1 below acl max
     acl max
     1 above acl max
    -chacl: cannot set access acl on "largeaclfile": Argument list too long
    +chacl: cannot set access acl on "largeaclfile": Numerical result out of range
     use 16 aces
     use 17 aces
    ...
Ran: generic/026
Failures: generic/026
Failed 1 of 1 tests

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 07449b98..4de2286 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -499,9 +499,12 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 
 	len = strlen(name);
 
-	if (len > F2FS_NAME_LEN || size > MAX_VALUE_LEN(inode))
+	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
+	if (size > MAX_VALUE_LEN(inode))
+		return -E2BIG;
+
 	base_addr = read_all_xattrs(inode, ipage);
 	if (!base_addr)
 		goto exit;
-- 
2.4.2
