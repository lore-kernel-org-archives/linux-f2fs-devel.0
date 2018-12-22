From: Martin Blumenstingl via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH v2 0/1] f2fs: fix sanity_check_raw_super on big
 endian machines
Date: Sat, 22 Dec 2018 11:22:25 +0100
Message-ID: <20181222102226.10050-1-martin.blumenstingl@googlemail.com>
Reply-To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <martin.blumenstingl@googlemail.com>)
 id 1gaeQa-0003Vz-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 10:22:40 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gaeQY-00DR4h-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Dec 2018 10:22:40 +0000
Received: by mail-wm1-f67.google.com with SMTP id c126so7914457wmh.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 22 Dec 2018 02:22:38 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Big endian machines (at least the one I have access to) cannot mount
f2fs filesystems anymore.
This is with Linux 4.14.89 but I suspect that 4.9.144 (and later) is
affected as well.

commit 0cfe75c5b01199 ("f2fs: enhance sanity_check_raw_super() to avoid
potential overflows") treats the "block_count" from struct
f2fs_super_block as 32-bit little endian value instead of a 64-bit
little endian value.

I tested this fix on top of Linux 4.14.49 but it seems that all stable
and mainline kernel versions are affected:
- 4.9.144 and later because 0cfe75c5b01199 was backported there
- 4.14.86 and later because 0cfe75c5b01199 was backported there
- 4.19
- 4.20-rcX


changes since v1 at [0]:
- change the printk format for block_count from "%u" to "%llu" (thanks
  to "kbuild test robot" for spotting this)
- added Chao Yu's reviewed by


[0] https://lore.kernel.org/patchwork/cover/1027285/


Martin Blumenstingl (1):
  f2fs: fix validation of the block count in sanity_check_raw_super

 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1
