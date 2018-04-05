From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [xfstests-bld PATCH] test-appliance: support f2fs-tools
 v1.9 and later
Date: Thu,  5 Apr 2018 15:21:41 -0700
Message-ID: <20180405222141.42376-1-ebiggers@google.com>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f4DHC-0006rV-9h
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 22:22:38 +0000
Received: from mail-pl0-f67.google.com ([209.85.160.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f4DHA-005Eev-KR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Apr 2018 22:22:38 +0000
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so21281515plq.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 05 Apr 2018 15:22:36 -0700 (PDT)
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

Pass the -f option to mkfs.f2fs when it appears to support it.  This is
required by f2fs-tools v1.9 and later in order to format the filesystem
even when an existing filesystem is detected.  But earlier versions did
not accept this option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 45fb2dd..0efcb76 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -20,6 +20,10 @@ function format_filesystem()
     local dev="$1"
     local opts="$2"
 
+    if grep -q 'force overwrite' /sbin/mkfs.f2fs; then
+	# f2fs-tools v1.9+
+	opts+=" -f"
+    fi
     /sbin/mkfs.f2fs -q $opts "$dev"
     return $?
 }
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
