From: Fan Li <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: optimize __update_nat_bits
Date: Mon, 30 Oct 2017 15:19:48 +0800
Message-ID: <000e01d3514f$a93addf0$fbb099d0$@samsung.com>
References: <CGME20171030072058epcas2p153d0b5c921ea4d3f3da6c6fd9baa5124@epcas2p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Make three modification for __update_nat_bits:
1. Take the codes of dealing the nat with nid 0 out of the loop
    Such nat only needs to be dealt with once at beginning.
2. Use " nat_index == 0" instead of " start_nid == 0" to decide if it's the first nat block
    It's better that we don't assume @start_nid is the first nid of the nat block it's in.
3. Use " if (nat_blk->entries[i].block_addr != NULL_ADDR)" to explicitly comfirm the value of block_addr
    use constant to make sure the codes is right, even if the value of NULL_ADDR changes.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ac629d6..b97a031 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2407,15 +2407,17 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
        unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
        struct f2fs_nat_block *nat_blk = page_address(page);
        int valid = 0;
-       int i;
+       int i = 0;

        if (!enabled_nat_bits(sbi, NULL))
                return;

-       for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
-               if (start_nid == 0 && i == 0)
-                       valid++;
-               if (nat_blk->entries[i].block_addr)
+       if (nat_index == 0) {
+               valid = 1;
+               i = 1;
+       }
+       for (; i < NAT_ENTRY_PER_BLOCK; i++) {
+               if (nat_blk->entries[i].block_addr != NULL_ADDR)
                        valid++;
        }
        if (valid == 0) {
--
2.7.4
