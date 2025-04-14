Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F93CC369B2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:55:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u4HTj-0001sE-BG;
	Mon, 14 Apr 2025 10:55:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u4HTi-0001s5-T8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Apr 2025 10:55:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3wQI6FodML0Z8gLcs2iEJrAK4l4Qfn4sT15ekZPtHvg=; b=R/0mAd2kwf/bYxly3QiBtjLXkD
 hpH3kkTa5hwHwZjlPsRGdoHU7Rx9DrXVmK8+qHxn91bY9FYEBgof4Axi/U+msUbtPozUg7FWH3qJJ
 5dIbevG+leYfJNJZawnsygFEOGtNnIPcrSDMV3uTCW9fvahdaKt10gR9gNndqgCdJ+lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3wQI6FodML0Z8gLcs2iEJrAK4l4Qfn4sT15ekZPtHvg=; b=E
 cOKBCvxvoJ6JYsnGM0Su/gmCJfS9RpwR2E0XgBkoHaicFMoA/TDuAGA9/PWOTgTe5qa9En2KQ3b7o
 MjP94g7NB/DULzwS4FM4hl8MlUT2CXX/lHh8nnNTEtgeAHJ/A7GwBO2c+65q/CL0Xl1FVq9/lvz9g
 dk9WnlD8dJrdQSwU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u4HTT-0005gh-OQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Apr 2025 10:55:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5B7DA5C54EC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Apr 2025 10:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8850C4CEE5;
 Mon, 14 Apr 2025 10:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744628125;
 bh=sFL0SY01M0ooEAeGm2+7EY2DjKRjMJosXfbO3upoTZ8=;
 h=From:To:Cc:Subject:Date:From;
 b=PCtwJialYxjcGhDjswA24RqBthBGn8Hu88xXZqhpSWtXgeyqCI3IrLJHkhbEGBq/g
 N6JplGA0xTImKlX6ldfmqjWbqsHObkpp/9A8E+LYX08WrE7nJzUNZeRA8E5G0JdEKi
 DpFOjH6KOAArRIMqWJ1NPIo0jyjsG6ObR0t1RCy796OHBebGCKi5vc7ZB95spmUnOI
 cqNEKNXX6vOdG/pmp8ueb9vqMctHGVMC5zjDHsDs/R6Sz51bcHVM0Nx4akZFEwSECV
 uiQPpWa7+jClJ+bDTiXJN7KzGALPTHxhkBmFggtO6E3lS5a6NH8ibhihGwrxYIyERQ
 ddH8IRUuN20eA==
To: jaegeuk@kernel.org
Date: Mon, 14 Apr 2025 18:55:20 +0800
Message-ID: <20250414105520.729616-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
MIME-Version: 1.0
X-Headers-End: 1u4HTT-0005gh-OQ
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on sit_bitmap_size
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

w/ below testcase, resize will generate a corrupted image which
contains inconsistent metadata, so when mounting such image, it
will trigger kernel panic:

touch img
truncate -s $((512*1024*1024*1024)) img
mkfs.f2fs -f img $((256*1024*1024))
resize.f2fs -s -i img -t $((1024*1024*1024))
mount img /mnt/f2fs

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.h:863!
Oops: invalid opcode: 0000 [#1] SMP PTI
CPU: 11 UID: 0 PID: 3922 Comm: mount Not tainted 6.15.0-rc1+ #191 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f2fs_ra_meta_pages+0x47c/0x490

Call Trace:
 f2fs_build_segment_manager+0x11c3/0x2600
 f2fs_fill_super+0xe97/0x2840
 mount_bdev+0xf4/0x140
 legacy_get_tree+0x2b/0x50
 vfs_get_tree+0x29/0xd0
 path_mount+0x487/0xaf0
 __x64_sys_mount+0x116/0x150
 do_syscall_64+0x82/0x190
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fdbfde1bcfe

The reaseon is:

sit_i->bitmap_size is 192, so size of sit bitmap is 192*8=1536, at maximum
there are 1536 sit blocks, however MAIN_SEGS is 261893, so that sit_blk_cnt
is 4762, build_sit_entries() -> current_sit_addr() tries to access
out-of-boundary in sit_bitmap at offset from [1536, 4762), once sit_bitmap
and sit_bitmap_mirror is not the same, it will trigger f2fs_bug_on().

Let's add sanity check in f2fs_sanity_check_ckpt() to avoid panic.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index eb1275616d8c..8abfbee13204 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3716,6 +3716,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	block_t user_block_count, valid_user_blocks;
 	block_t avail_node_count, valid_node_count;
 	unsigned int nat_blocks, nat_bits_bytes, nat_bits_blocks;
+	unsigned int sit_blk_cnt;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -3827,6 +3828,13 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	if (sit_bitmap_size * 8 < sit_blk_cnt) {
+		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
+			 sit_bitmap_size, sit_blk_cnt);
+		return 1;
+	}
+
 	cp_pack_start_sum = __start_sum_addr(sbi);
 	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
