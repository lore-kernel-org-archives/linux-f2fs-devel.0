Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85CEC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Mar 2022 15:22:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nWJje-00059g-Ev; Mon, 21 Mar 2022 15:22:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nWJjc-00059Z-QU
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Mar 2022 15:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GMvAPCwY2BE+i2t9uPhrloGfRUs+Qd6QIj8Iqez+fQg=; b=Hijg9gz0MnqEEv2edNZMWe9VtG
 xKrV0061hY0AaM8fngtMqBOlEGSZ1voWcuXCMGWYu6N5pG1t6mIxs5HV2WgSCh0QB/YJaOj/yScw1
 MzzeBN6ZQpnpkhFjzdJoMtyDY7Pf5onQRTO+Bsc58EO7Sxn7FpZUW0XW3xzz7lpD+28E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GMvAPCwY2BE+i2t9uPhrloGfRUs+Qd6QIj8Iqez+fQg=; b=c
 6huZ4FmVbShLUemJ7sYU9Y07xGEKnypXXb0mN3WtfsalAxLPy40yb/P1BbjY7FS+0dUsUguFPtHSu
 QQ/s1uZWKrOnntgs4pQfK1UTR50OF6oEcewq6P47CEdFmbaDAoHEM1FkUvAV94dO3WfdXwODnVczS
 3YJWpqkqgMaDJ1hQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nWJrX-0000X7-Kp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Mar 2022 15:22:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 96C3660F7F;
 Mon, 21 Mar 2022 15:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B33C340E8;
 Mon, 21 Mar 2022 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647876140;
 bh=BmDckR9oVCj0Dpd4A7Tl1cnWlUNuPswQxFdMCV/VB28=;
 h=From:To:Cc:Subject:Date:From;
 b=MVQLwBvoPv739CozYeYWtmsjiElxLsHftJW0CyEqAFU8TDqKf/lZ0pr44OTuhBXku
 UasA+zKlU4VFI+8EB34OUZkR+m9XuD6v7IWgcQX8LSDtmUvGEVp+Vz85Nz9lezM4Lq
 NlKnH5UQdxesNjrkU5yhmAmVgJvQaH3DaEpk9B7muO6TMB+XtFgh9ddla872vCJvCD
 0evxGiuwkFwFvrrgrfL6Y9uYYgH+EAZDFQehNLqbgycTaVYBJFuT8JGM83Bs6JRUXD
 ENQ+rCL/vZvU/b32WEZ9nbsqbyNxywLB1VIUqaQh8iYa1ziKAHNnjn7S3ALVjeb4D1
 c6WqHvhOWMPRQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 21 Mar 2022 23:22:11 +0800
Message-Id: <20220321152211.5656-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1nWJrX-0000X7-Kp
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on
 .cp_pack_total_block_count
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As bughunter reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215709

f2fs may hang when mounting a fuzzed image, the dmesg shows as below:

__filemap_get_folio+0x3a9/0x590
pagecache_get_page+0x18/0x60
__get_meta_page+0x95/0x460 [f2fs]
get_checkpoint_version+0x2a/0x1e0 [f2fs]
validate_checkpoint+0x8e/0x2a0 [f2fs]
f2fs_get_valid_checkpoint+0xd0/0x620 [f2fs]
f2fs_fill_super+0xc01/0x1d40 [f2fs]
mount_bdev+0x18a/0x1c0
f2fs_mount+0x15/0x20 [f2fs]
legacy_get_tree+0x28/0x50
vfs_get_tree+0x27/0xc0
path_mount+0x480/0xaa0
do_mount+0x7c/0xa0
__x64_sys_mount+0x8b/0xe0
do_syscall_64+0x38/0xc0
entry_SYSCALL_64_after_hwframe+0x44/0xae

The root cause is cp_pack_total_block_count field in checkpoint was fuzzed
to one, as calcuated, two cp pack block locates in the same block address,
so then read latter cp pack block, it will block on the page lock due to
the lock has already held when reading previous cp pack block, fix it by
adding sanity check for cp_pack_total_block_count.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/checkpoint.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 871eee35a32f..aba1b8a1ce66 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -875,6 +875,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
 	struct f2fs_checkpoint *cp_block = NULL;
 	unsigned long long cur_version = 0, pre_version = 0;
+	unsigned int cp_blocks;
 	int err;
 
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
@@ -882,15 +883,16 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	if (err)
 		return NULL;
 
-	if (le32_to_cpu(cp_block->cp_pack_total_block_count) >
-					sbi->blocks_per_seg) {
+	cp_blocks = le32_to_cpu(cp_block->cp_pack_total_block_count);
+
+	if (cp_blocks > sbi->blocks_per_seg || cp_blocks <= F2FS_CP_PACKS) {
 		f2fs_warn(sbi, "invalid cp_pack_total_block_count:%u",
 			  le32_to_cpu(cp_block->cp_pack_total_block_count));
 		goto invalid_cp;
 	}
 	pre_version = *version;
 
-	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	cp_addr += cp_blocks - 1;
 	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
 					&cp_page_2, version);
 	if (err)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
