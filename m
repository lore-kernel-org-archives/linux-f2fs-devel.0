Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E5CC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DuIMau5N0o/F6XWDxkeKW6j97BvZXbb8zrByohPgxLE=; b=FXAohviDBz1TgcNdUDiR99q3cA
	/QlacrmDUbKdkOCwEe+OFj3vo1LB274YTd++GUG/Z1xiJEmX6RwxE1eW9Sn5pWe93/0qw2wM9vtng
	i0jBy772Yz5pWVISRjxI6eaeuEsdfNvhgefo4TGRx/qls2ilZt1QdFxHBaIVUTFLCrYI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGpKf-0006A3-Su;
	Wed, 14 Oct 2026 03:07:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xGpKU-00069j-CE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 03:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kuk32lWpMV6ZwKFcz9qRaaCn7MtYw/EVPpC7v5/C/V0=; b=Tr8/f09u9kUjgupJE1eRrtNamG
 lxh12GoHQ5JrMgiS3FMeZ8X4RFQRCPobqmm2+xI+C5bYUDxrLQPpr1UDxZJiSlflLB2psaR31sTbM
 YGPjuWEXo0AV1RkWdo9f/dQQzML31g1a5biVVj7rr4YExBXpAiw7rWU9urLQK1keIgYc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kuk32lWpMV6ZwKFcz9qRaaCn7MtYw/EVPpC7v5/C/V0=; b=J
 QlpXR2c8gaTEw2evvhd/REW6ph0wOJWfEiA85qxteqIg9Vy9K6xyrmMFsnuW344z4oDkIXsFJ+Q2Z
 N945DySpFCL/UC3OkERD4rb4re67qnY206Mg9iT2MaFHIETE/EYqcrHKHbIsmIuaDyM/lUiOqNPaJ
 wxtYBhbyt0e4iACU=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGpKU-0007AX-Fq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 03:06:59 +0000
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc4b62d118aso2308401a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 20:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791947213; x=1792552013; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuk32lWpMV6ZwKFcz9qRaaCn7MtYw/EVPpC7v5/C/V0=;
 b=lXAXZoUeiGv6RxZf+S3X8cJPbv0x/obe1LKGQSI392/BMo2EgPkp8rseY5k89spyXG
 1HSpIR4Qq7sC0MAwIZQ6jl9JDRbBED6pg1+4CStCIzu7GzFb56e3m573ASHY6A1b382T
 paOD23I8CSqzl7h3XsoVLge+JSRTKkG/W6NJbBwHZajWN/Hor9WV1XaoLr5qKRV740mv
 oOUx5xjlVFozjGMGYygSxduhjB5Ag1HsvBa3885OzX67JqxJQCRqJUQTZ2pafzhzIj+F
 mjX2JtXNhhtHol7V/abb3e8sNCtqn1sLMRD+4wNqOVuMc43xUlptksN5she/IPS64Eqe
 AhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791947213; x=1792552013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kuk32lWpMV6ZwKFcz9qRaaCn7MtYw/EVPpC7v5/C/V0=;
 b=hNbjNpVzBYW2N48m50GPgHu9PbfmIbVkcn9ZVv6rc3si/swoBxM7m20pfPN10VQYz8
 adeDRcuFcfP5z4ainRnX4DQGNBZF/Zz/cq+dRIO1FkwkyZ+9/cZCdhcmegbRkSVxbUyu
 w609VT8VHyGpQ0Ny80GQIas0Yl0+PuMkIbLjlxmBysjHWW7BwlpMRLQmRk3LfWEiBM6X
 dVEIK2kiH0xkkIZHUSOgB5f7duY2Y7ZAETTZOzhiwI5UlU06T8M3s0WhBej2uOe6rF7N
 hMp0FIptUpE9QWzF3YI//Swwk3DlHtNcwlTQhCmKmkoIILyk6z3NPXkyHntIrkYq3xOP
 FFeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrYz+Tqdu4X1DP8n4M2XhShFuzqJF9uFCNT8ORmKM4KvqcMTU06GGpN4nI23ZADFb0+bb4NtFl5qB/GSW9ZtIT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKPQHRvtsnA/Jhb+GM24a73oLKbCq5uRyvnYGkrmcO/40efrfau
 3A+7rv30tInDB9IrfOzKo+en3y9HVXbcOB7+O3hqXwkwsn+svaytZyCe
X-Gm-Gg: AYBFou2UVdpGdGw5SfKn4Mc7edbL6AjBdVccdFyA3LuJE/fC8GkWT8aIIU1hncpIMNP
 /xUZynrvUG+e+KJ7/bDpxG2qhA9pw4+lndF0kbQ5ulFPmvbZDZLUP54wi/FoZQfdRnEq483/ZrN
 0CQbmR22Tupx2sOaan12J1eZhlWAw4Ig7TFiBcWDNxXmygLhrt5YtROW37yJ2wP5Px7svlmpSeJ
 eXwLsSu1wjnLu/Vy3UPXSRvfdDigvcSnBpMC1txhnej5MBPsuXZzFRGb10WsLcHEEh2EHm8pHcr
 vSALQd+hUv+UNranVfD6bgBBYEg+Clt4QP1DpiedKxz36aBtwy132RtlFN7z67v/ohTOqf2xTx0
 VVGKN1d7a9y+rMoJpin6I4k1DgzvgrNKbSWnc00anXLbXyvrY8Fmw96ex4MikE7mPSVkvcGQ5fi
 I/IptEfEaTM9kn6RZ2m9Wpfm+FNn31HzVv4TwrTyBabuLwI+Lio8GxvGhf3K/A9H5GKHz2Y+UYi
 j4qgjyONy90Yulv3pNgeoke39mpgUeYk+U3C9H4cVAU+vdVYQWjTU1QgesOd0loXd1zev/KoVMy
 bBRMoFz8a6bxxRzZ
X-Received: by 2002:a17:90b:258f:b0:3a6:dc51:cce9 with SMTP id
 98e67ed59e1d1-3ab3a96634dmr11835182a91.57.1791947212597; 
 Tue, 13 Oct 2026 20:06:52 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61171feesm2112139a91.17.2026.10.13.20.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:06:51 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 14 Oct 2026 03:06:46 +0000
Message-ID: <20261014030646.662661-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xGpKU-0007AX-Fq
Subject: [f2fs-dev] [PATCH] f2fs: reserve space to be shrunk during resize_fs
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

f2fs_resize_fs() checks whether there is enough free space for the
shrink, runs a dry-run GC to migrate blocks out of the target range,
and then drops gc_lock and the cp lock before freeze_super(). During
that window, other processes, including root ones that are allowed to
use root reserved blocks, can still allocate the free space, so the
second check after freeze_super() fails with -ENOSPC even though the
first check passed. This is easy to hit when the shrink is triggered
on a live, busy filesystem, e.g. by an updater at OTA install time.

Fix this by reserving the space to be shrunk once the first check
passes. Add resize_reserved_blocks and deduct it in
__get_available_block_count() for all callers, like
alias_reserved_blocks, so that no one can allocate the reserved space
until the shrink is done. The reservation is released together with
the user_block_count update on success, or on any error.

Also factor out __get_available_block_count() and use it in
f2fs_resize_fs() to share the available block calculation, which takes
alias_reserved_blocks into account as well.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h  | 18 ++++++++++++++----
 fs/f2fs/gc.c    | 41 +++++++++++++++++++++++++++++------------
 fs/f2fs/super.c |  1 +
 3 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054e..6b9e1d0e71c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1897,6 +1897,7 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 	block_t alias_reserved_blocks;		/* reserved blocks for device alias */
+	block_t resize_reserved_blocks;		/* reserved blocks for resize_fs */
 
 	/* Additional tracking for no checkpoint mode */
 	block_t unusable_block_count;		/* # of blocks saved by last cp */
@@ -2666,16 +2667,18 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 	return false;
 }
 
-static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
-						struct inode *inode, bool cap)
+static inline unsigned int __get_available_block_count(
+					struct f2fs_sb_info *sbi,
+					bool allow_root)
 {
 	block_t avail_user_block_count;
 
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks -
-					sbi->alias_reserved_blocks;
+					sbi->alias_reserved_blocks -
+					sbi->resize_reserved_blocks;
 
-	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !allow_root)
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -2688,6 +2691,13 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	return avail_user_block_count;
 }
 
+static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
+						struct inode *inode, bool cap)
+{
+	return __get_available_block_count(sbi,
+				__allow_reserved_root(sbi, inode, cap));
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 926e6976bc2..5bfdaeae794 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2374,6 +2374,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	struct f2fs_lock_context glc;
 	struct f2fs_lock_context clc;
 	unsigned int secs;
+	bool reserved = false;
 	int err = 0;
 	__u32 rem;
 
@@ -2425,10 +2426,17 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	f2fs_lock_op(sbi, &lc);
 
 	spin_lock(&sbi->stat_lock);
-	if (shrunk_blocks + valid_user_blocks(sbi) +
-		sbi->current_reserved_blocks + sbi->unusable_block_count +
-		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+	if (shrunk_blocks + valid_user_blocks(sbi) >
+			__get_available_block_count(sbi, false)) {
 		err = -ENOSPC;
+	} else {
+		/*
+		 * Reserve the space to be shrunk so that no one, including
+		 * root, can allocate it until the shrink is done.
+		 */
+		sbi->resize_reserved_blocks += shrunk_blocks;
+		reserved = true;
+	}
 	spin_unlock(&sbi->stat_lock);
 
 	if (err)
@@ -2442,29 +2450,32 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 out_drop_write:
 	mnt_drop_write_file(filp);
 	if (err)
-		return err;
+		goto out_release;
 
 	err = freeze_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
 	if (err)
-		return err;
+		goto out_release;
 
 	if (f2fs_readonly(sbi->sb)) {
 		err = thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
-		if (err)
-			return err;
-		return -EROFS;
+		if (!err)
+			err = -EROFS;
+		goto out_release;
 	}
 
 	f2fs_down_write_trace(&sbi->gc_lock, &glc);
 	f2fs_down_write_trace(&sbi->cp_global_sem, &clc);
 
 	spin_lock(&sbi->stat_lock);
-	if (shrunk_blocks + valid_user_blocks(sbi) +
-		sbi->current_reserved_blocks + sbi->unusable_block_count +
-		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+	/* shrunk_blocks is already accounted in resize_reserved_blocks */
+	if (valid_user_blocks(sbi) >
+			__get_available_block_count(sbi, false)) {
 		err = -ENOSPC;
-	else
+	} else {
 		sbi->user_block_count -= shrunk_blocks;
+		sbi->resize_reserved_blocks -= shrunk_blocks;
+		reserved = false;
+	}
 	spin_unlock(&sbi->stat_lock);
 	if (err)
 		goto out_err;
@@ -2510,5 +2521,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	f2fs_up_write_trace(&sbi->cp_global_sem, &clc);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
 	thaw_super(sbi->sb, FREEZE_HOLDER_KERNEL, NULL);
+out_release:
+	if (reserved) {
+		spin_lock(&sbi->stat_lock);
+		sbi->resize_reserved_blocks -= shrunk_blocks;
+		spin_unlock(&sbi->stat_lock);
+	}
 	return err;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d683240040f..28e49e8d71e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5345,6 +5345,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
 	sbi->alias_reserved_blocks = 0;
+	sbi->resize_reserved_blocks = 0;
 	limit_reserve_root(sbi);
 	adjust_unusable_cap_perc(sbi);
 
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
