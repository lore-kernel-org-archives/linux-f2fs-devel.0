From: Anatoly Pugachev <matorola@gmail.com>
Subject: Re: disable loading f2fs module on PAGE_SIZE > 4KB
Date: Mon, 28 May 2018 02:06:37 +0300
Message-ID: <CADxRZqy-fgty4j74DhJ1dS1M9m50hdj_yBkc2KBdHF4xW4qqPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <matorola@gmail.com>) id 1fN4kP-0000CN-J5
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 27 May 2018 23:06:45 +0000
Received: from mail-wm0-f68.google.com ([74.125.82.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fN4kO-003Kfc-52
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 27 May 2018 23:06:45 +0000
Received: by mail-wm0-f68.google.com with SMTP id a67-v6so27388833wmf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 May 2018 16:06:43 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Thanks for your comments.

The following patch disables loading of f2fs module on architectures
which have PAGE_SIZE > 4096 , since it is impossible to mount f2fs on
such architectures , log messages are:

# mount -t f2fs /dev/vdiskb1 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on
/dev/vdiskb1, missing codepage or helper program, or other error.
# file -s /dev/vdiskb1
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

tested on git kernel 4.17.0-rc6-00309-gec30dcf7f425

with patch applied:

# modprobe f2fs
modprobe: ERROR: could not insert 'f2fs': Invalid argument
# journalctl -e -k
May 28 01:40:28 v215 kernel: F2FS not supported on PAGE_SIZE(8192) != 4096

v2 changes:
- compare page size to f2fs BLKSIZE
- print current page size on error


Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42d564c5ccd0..fd9868f8ed4d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3063,6 +3063,12 @@ static int __init init_f2fs_fs(void)
 {
        int err;

+       if (PAGE_SIZE != F2FS_BLKSIZE) {
+               printk("F2FS not supported on PAGE_SIZE(%lu) != %d\n",
+                       PAGE_SIZE, F2FS_BLKSIZE);
+               return -EINVAL;
+       }
+
        f2fs_build_trace_ios();

        err = init_inodecache();

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
