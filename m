Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6B3C61DE2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cb5C6LLVdP9HZcGxyirNczc8Mme7Oz629hwhUBAyfr8=; b=CXdEVdGvxUqG8moO9T05M4VRj7
	6GfsoFJCd372N5m5u+PX5hlBEr3GVs0dAgG3zKBSToAAaD8pHfvndAAYoOHpjJ1f71dKRILdZZNic
	9L+EF1B7TekC6c52o4B8Cq8QIqlv4N6FXRu4n46owa5Cj5xbEJixCrWHRAzoSdpu8Wvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0ytM-0007zb-D4;
	Mon, 31 Aug 2026 10:05:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0ytK-0007zT-DQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 10:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GSdgQ8YpORdVLMN01UmDGzOAso4WKOxEvC71N1mRoKU=; b=bHldjqkxntw43huSD3FDjey48N
 wvNxfk3XanarcdQLxJl2vF4aka6oY/6GsC+R6ZUuGdD5ZVk2Hw2lM9mazGRQnJeSg/k5nOxyQNYY2
 dOvaoiky0K6FgH6pSAP5J8iNdPNv4f7I01GOLoAf0GWPkVoIrKpxm2ySQEMwShjShtv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GSdgQ8YpORdVLMN01UmDGzOAso4WKOxEvC71N1mRoKU=; b=l
 sDVV3/FHh67CU0VP8XU2XvmgZR0mFumkOXMHWUxpsyLji+pogobcRSIhv734waIVeT3U+pDlKAI4R
 JEeAZGBtIXkeckIBIUESkB3aLaexymu9nHp14EEKVYcJlX+9ek4x3j8oPOJ4O6FE1Jbbdu8Hv+THJ
 z52NX1KbNeo9t/N8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0ytH-0006zV-50 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 10:05:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5170560120
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9E1F000E9;
 Mon, 31 Aug 2026 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788170717;
 bh=GSdgQ8YpORdVLMN01UmDGzOAso4WKOxEvC71N1mRoKU=;
 h=From:To:Cc:Subject:Date;
 b=fHw4KzMWLrYnYyVShPBHeHIKtzVg5p2hrecnOQ+WS5Yn4BPExqmAPJXq7Hq+eTbp/
 nArhIQV23dabSnWQwZUXqKNtnrGh95uDcaAmlCr7HuMeWSWATJQdIjVTSHXsoMVVWr
 Y3+KNCje2AsgRYIfDWusYfveCXlT3DObywODxdemwAIkNiO0HYt9a/yP9eBUOBIjcV
 8d85M2iX+sTu0ccHVV9lkk+EG0MQxob9OI6dOpNtzRoRG7M7ZQSAHwmPXpevMjmaxW
 jdv8oVqEF3bqmhO6suFFUD3GNFGk13Wa0Dppj1yjlXNLx2gvZnZT3+seym/0Qe8uZy
 pCJe888AcjHhg==
To: jaegeuk@kernel.org
Date: Mon, 31 Aug 2026 10:05:05 +0000
Message-ID: <20260831100505.3078649-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
MIME-Version: 1.0
X-Headers-End: 1x0ytH-0006zV-50
Subject: [f2fs-dev] [PATCH] fsck.f2fs: do not repair quota file in dry-run
 mode
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

Info: Dry run
Info: MKFS version
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: checkpoint stop reason: shutdown(16)
Info: Device[0] : /dev/vdd blkaddr = 0--ffffff
Info: Device[1] : /dev/vdb blkaddr = 1000000--11fffff
Info: Device[2] : /dev/vdc blkaddr = 1200000--14fffff
Info: Host-managed zoned block device:
      32 zones, 134217728u zone size(bytes), 0 randomly writeable zones
      32768 blocks per zone
Info: Device[3] : /dev/nullb0 blkaddr = 1500000--15fffff
Info: Segments per section = 64
Info: Sections per zone = 1
Info: total FS sectors = 184549376 (90112 MB)
Info: CKPT version = 25fc6ba
Info: Casefold: linear_lookup [enable]
Info: checkpoint state = 844 :  quota_need_fsck crc compacted_summary sudden-power-off
[FIX] (move_one_curseg_info:3235)  --> Move curseg[0] 4f7 -> 12c0 after 28000
[FIX] (move_one_curseg_info:3235)  --> Move curseg[1] 1284 -> 1300 after 28000
[FIX] (move_one_curseg_info:3235)  --> Move curseg[2] b2 -> 1340 after 28000
[FIX] (move_one_curseg_info:3235)  --> Move curseg[3] ed -> 1380 after 28000
[FIX] (move_one_curseg_info:3235)  --> Move curseg[4] cf7 -> 13c0 after 28000
[FIX] (move_one_curseg_info:3235)  --> Move curseg[5] 140 -> 1400 after 28000

[ASSERT] (is_valid_ssa_node_blk: 197)  --> Summary footer indicates a node segment: 0xcf7
[ASSERT] (is_valid_ssa_node_blk: 224)  --> Set node summary 0xcf7 -> [0x4] [0x1c6ec5]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x0]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x1]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x2]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x5]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x29]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x34]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x46]
[ASSERT] (is_valid_ssa_data_blk: 359)  --> Set data summary 0x4f7 -> [0x4] [0x0] [0x9e]

In dry-run mode, physical disk writes are skipped by dev_write().
If fsck_chk_quota_files() attempts to rebuild quota files, subsequent
reads on newly allocated blocks will fetch stale, unwritten disk data,
triggering assertion failures or false corruptions.

Skip updating quota files when dry-run mode is enabled, and report
inconsistent quota files as informational messages without flagging
unrepairable filesystem corruptions.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c  | 7 +++++--
 fsck/mount.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6872b00..e47f7be 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2411,7 +2411,7 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 		}
 
 		/* Something is wrong */
-		if (c.fix_on) {
+		if (c.fix_on && !c.dry_run) {
 			DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
 							qtype, ino);
 			fsck_disconnect_file(sbi, ino, true);
@@ -2424,6 +2424,9 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 			} else {
 				ASSERT_MSG("Unable to write quota file");
 			}
+		} else if (c.dry_run) {
+			MSG(0, "Info: Quota file is inconsistent (dry-run, repair skipped)\n");
+			ret = 0;
 		} else {
 			ASSERT_MSG("Quota file is missing or invalid"
 					" quota file content found.");
@@ -3709,7 +3712,7 @@ void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
 	if (c.zoned_model != F2FS_ZONED_HM)
 		return;
 
-	if (c.fix_on) {
+	if (c.fix_on && !c.dry_run) {
 		flush_nat_journal_entries(sbi);
 		flush_sit_journal_entries(sbi);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 26f213e..a202f3d 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -4222,7 +4222,7 @@ out:
 	print_ckpt_info(sbi);
 
 	if (c.quota_fix) {
-		if (get_cp(ckpt_flags) & CP_QUOTA_NEED_FSCK_FLAG)
+		if ((get_cp(ckpt_flags) & CP_QUOTA_NEED_FSCK_FLAG) && !c.dry_run)
 			c.fix_on = 1;
 	}
 	if (c.layout)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
