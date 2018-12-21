From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] f2fs: fix sanity_check_raw_super on big endian machines
Date: Fri, 21 Dec 2018 20:28:19 +0100
Message-ID: <20181221192820.26222-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

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


Martin Blumenstingl (1):
  f2fs: fix validation of the block count in sanity_check_raw_super

 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1
