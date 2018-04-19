From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH 1/2] test-appliance: fix specifying
 f2fs mount options in config file
Date: Thu, 19 Apr 2018 13:50:19 -0700
Message-ID: <20180419205020.16868-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers3@gmail.com>) id 1f9GXH-0003wn-HR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:52:07 +0000
Received: from mail-pl0-f65.google.com ([209.85.160.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f9GXF-002zCC-Uu
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Apr 2018 20:52:07 +0000
Received: by mail-pl0-f65.google.com with SMTP id e7-v6so3945473plt.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Apr 2018 13:52:05 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

setup_mount_opts() is supposed to prepend "-o " to the mount options,
but it failed to do so in the case where mount options are specified in
a config file rather than on the command line.  Fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index b0c2196..94c402b 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -31,12 +31,9 @@ function format_filesystem()
 function setup_mount_opts()
 {
     if test -n "$MNTOPTS" ; then
-	if test -n "$F2FS_MOUNT_OPTIONS" ; then
-	    export F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
-	else
-	    export F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
-	fi
+	F2FS_MOUNT_OPTIONS+="${F2FS_MOUNT_OPTIONS:+,}$MNTOPTS"
     fi
+    export F2FS_MOUNT_OPTIONS="${F2FS_MOUNT_OPTIONS:+-o }$F2FS_MOUNT_OPTIONS"
 }
 
 function get_mkfs_opts()
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
