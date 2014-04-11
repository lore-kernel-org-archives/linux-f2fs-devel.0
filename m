From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/7] f2fs: put the bio when issue_flush completed
Date: Fri, 11 Apr 2014 17:49:35 +0800
Message-ID: <5347BAAF.9030004@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Put the bio when the flush cmd issued, it also can fix the following
kmemleak:
unreferenced object 0xffff8800270c73c0 (size 200):
  comm "f2fs_flush-7:0", pid 27161, jiffies 4312127988 (age 988.503s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 40 07 81 19 01 88 ff ff  ........@.......
    01 00 00 00 00 00 00 f0 11 14 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81559866>] kmemleak_alloc+0x72/0x96
    [<ffffffff81156f7e>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff811595b1>] kmem_cache_alloc+0xec/0x157
    [<ffffffff8111924d>] mempool_alloc_slab+0x15/0x17
    [<ffffffff81119513>] mempool_alloc+0x71/0x138
    [<ffffffff81193548>] bio_alloc_bioset+0x93/0x18c
    [<ffffffffa040f857>] issue_flush_thread+0x8d/0x145 [f2fs]
    [<ffffffff8107ac16>] kthread+0xba/0xc2
    [<ffffffff81571b2c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/segment.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 085f548..524b7ed 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -226,6 +226,7 @@ repeat:
 			next = cmd->next;
 			complete(&cmd->wait);
 		}
+		bio_put(bio);
 		sm_i->dispatch_list = NULL;
 	}
 
-- 
1.7.7
