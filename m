From: Anatoly Pugachev <matorola@gmail.com>
Subject: disable loading f2fs module on PAGE_SIZE > 4KB
Date: Wed, 16 May 2018 14:14:20 +0300
Message-ID: <CADxRZqwoXGgm-n0jFa19CnCrsso7ASoLw9a_j=M-h5jnWOMvwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <matorola@gmail.com>) id 1fIuO4-0006y4-UF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 May 2018 11:14:28 +0000
Received: from mail-wm0-f68.google.com ([74.125.82.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fIuO3-005rLV-7g
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 May 2018 11:14:28 +0000
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so690682wmt.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 May 2018 04:14:27 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hello!

The following patch disables loading of f2fs module on architectures
which have PAGE_SIZE > 4096 , since it is impossible to mount f2fs on
such architectures , log messages are:

root@ttip:/1/mator/xfstests-dev# mount -t f2fs /dev/vdiskb1 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on
/dev/vdiskb1, missing codepage or helper program, or other error.
root@ttip:/1/mator/xfstests-dev# file -s /dev/vdiskb1
/dev/vdiskb1: F2FS filesystem,
UUID=1d8b9ca4-2389-4910-af3b-10998969f09c, volume name ""

May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
filesystem in 1th superblock
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
filesystem in 2th superblock
May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
page_cache_size (8192), supports only 4KB

which was introduced by git commit 5c9b469295fb6b10d98923eab5e79c4edb80ed20

tested on git kernel v4.17-rc5-20-g21b9f1c7e319

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42d564c5ccd0..3071771bf261 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3063,6 +3063,11 @@ static int __init init_f2fs_fs(void)
 {
        int err;

+       if (PAGE_SIZE > 4096) {
+               printk("F2FS not supported on PAGE_SIZE > 4096\n");
+               return -1;
+       }
+
        f2fs_build_trace_ios();

        err = init_inodecache();

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
