Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74560C79F9F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vgjWjmcmi9ybFzad9hEACXGOK0YMdaIO57ys81L2SZU=; b=Ewbx6TAjfj+LC3vg0eDxJ2Dc9n
	91kF4S2nJYWIqbSaG7RYTLDPYPjPTexDQ2kQcZgPoGTEJPZ0oQEMvG4TTHMAOz6lUwiCrgFIlgRYQ
	HzUmKnnS9s02VHe2QETWJ4mYckseX7g09FqJ7qaXEls+hHN64A2ttWWrefPwDzU71OAY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4jLv-0006oZ-D5;
	Thu, 10 Sep 2026 18:18:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4jLu-0006oP-JR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 18:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jMuTEYKkyyrLqeX97xIC/Z56ogCyVEt8VnZlLfJ3DOI=; b=O3fiGikwlOpsVvE7HmPbjBb2F1
 FFPH/7LT9963BL/yMv0oPxRWdc1R2Vd3XqJ8uBDZEFg3DnrD0/Zv0AtvDT3nhrsiWCmBLaKPuOv4n
 7PUH06MsKggLhpVDhiPS+Fkebyf4Wsv9VOSfEUbIPuOS/oaYRAoeEDfx1w0pVRhbtKj4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jMuTEYKkyyrLqeX97xIC/Z56ogCyVEt8VnZlLfJ3DOI=; b=D
 XlqYD2BVbtF2VmlhKqsAMU3/vUJwCWv2KuQMFGNvlat95Uzw2E7F+yKIgsuC8aDHThFbR3hr1Hst6
 91FpMhoI4/ARLxcEWtIVQ/vjxSe2BqCgpB2xfax6aaQgRNSp0qR8Tu4266f8lBKI2EgkCIRmBnH7/
 1A9s8Ed7qa5yf0Ig=;
Received: from mail-pz2-f12.google.com ([74.125.228.12])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4jLs-0001PA-QK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 18:18:27 +0000
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-868cfc5c244so1048167b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789064299; x=1789669099; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jMuTEYKkyyrLqeX97xIC/Z56ogCyVEt8VnZlLfJ3DOI=;
 b=kjk13DEzZpQKBrvDaHLQDPn2mGxbjgrKxN7hzoSLXd/PIZ9zPnoVpkeyZlPtbR/9B8
 YtQL5VYE4aM2yd0u8gfIBaEqrBpC/2kw0SMuhdCWHP1KytpQ+mX7dvd7RvZiF2szUN90
 YB0A8KLd8AOU5h/iuzleDn7ge0IefK6aJ3CJpdNEIhamXUMg5eCNh1zKgT1aj2pJHgZE
 dH2ikLkZMAIRH/UnQGEdzwORhFXy/XNGzjHnOAZP86MozqvCiV123lipIusAncAw/yti
 TYHX9CdUeUZl1Sq0p2CjVOWtrQWBfkTe7XjfsxIO/RzNpyhFvHCu5TuD7MXLVA68C1qC
 OZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064299; x=1789669099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jMuTEYKkyyrLqeX97xIC/Z56ogCyVEt8VnZlLfJ3DOI=;
 b=N+k8bKQvGBILkf39QvB5JGx2KFAAc2/jtgnIy4LTys3NXlQwFf4SM+ETDxcRn4iYDm
 f6GNAckrKDTMZ00aBL7uVGWzrYTyXfKlvpAdzylPyQh0uDEvBJNimfjN9BhnPs4uSSN4
 HGLj31YKkE8vhxzrlOHITy6mQ/5FFLgzWS3SxXOtmaTpKx2Y7hhKCaxY5OUIb1CxJJrf
 52IY3ArzzSLiJNHmU6Y5jNLripVtA1KIwW3Jx7KCQ7//Xf41V4JFvUTgCUhoV91X8BFb
 b/oFOkKJvrWyHMEdzHwQX33X6cbxprKAFF7coOWUZBvttn8M3xif3GE/WoqHp1bdM91y
 scFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5MfNSh4sHSsB9qNVZiTbdeixkQXMoGUZRzpyz26w/VD5vgMptLA528IOEjMJRR8o4lAJ008NUTruV3RVYVUBX@lists.sourceforge.net
X-Gm-Message-State: AFuF++lxYTV7Op0+R+YG1ZRrucrFuT9BrEMqiGv6wPtMKov78cZPyRLl
 nwPuRzmACtmypbFrR3TtDakqPLbMghkSABcVbf+7ciy0OPPyE3zC4JjBxdbHGTxj
X-Gm-Gg: AYBFou0qtDf9EAqFT2FbPA5DQ9BSodGBj7hlkg16EnfCRx3d2wszSuLM1add22yaqt8
 RbqXh1K7SGrwlJp+FQt4rqztSH7UbTJUrTWJlszgK88fn94Bw0SDNUpnMQ41bE8TOOqM1CPiMb4
 QhhrHEvOKLszt07o7NjxPiOBSk58e4yJL3JVuzWJ8EOdE0b/XeCVIeGf7lejqoc+1adA5LvzFG7
 IK9JyJx2abugHSzKf5AU1PKqqxWsopO5XxO4uOsMyyyWPQY1kE3sUiDi4F/OpPrkpHS/iECt7l/
 V6b/urtPlAjUKyVK4rriuA65g6/yp5toOQTguGtXjul/7cUauHwREBrtrqv8T/kg2TSOOTMpzcH
 QLwYHFO7+LYv+tRzf80vzzPDPYLHILxHliq8N8V9H7/e/HsLJDNvOqxzlXiDBwWLdFd4QktF3ou
 UMBcZLWoL1szwHTPUS5y8unophl8BFZtfwsqTMfdV4Pvz7tYKBVb43sotfdSobJWjApMIrebvFR
 RnU/HHvFeKb1z+wOrI3AZK/sJETSBxHiEuGzfLkbo4aDomyJg0yfPU7Fsds1g8oLd9HJV+HXBB3
 62sfZkYH0Q+uQ8DxtJUnag==
X-Received: by 2002:a05:6a20:be8f:b0:3d3:adbf:7782 with SMTP id
 adf61e73a8af0-3daed4a71damr233450637.23.1789064298963; 
 Thu, 10 Sep 2026 11:18:18 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:4a5b:802b:c0b:d1d7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-336c2571039sm32309407eec.25.2026.09.10.11.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:18:17 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 10 Sep 2026 11:10:56 -0700
Message-ID: <20260910181057.640203-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
MIME-Version: 1.0
X-Headers-End: 1x4jLs-0001PA-QK
Subject: [f2fs-dev] [PATCH] f2fs: introduce reserve_shrink mount option for
 filesystem shrinkage
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

When preparing for subsequent online filesystem shrinkage (e.g., during
partition resizing or FOTA updates), sufficient free space must be
preserved so that valid data blocks can be evacuated and the filesystem
can safely shrink.

Existing reserve_root cannot prevent space exhaustion by privileged root
processes (such as OTA updaters, package managers, and system daemons
running with CAP_SYS_RESOURCE), which can allocate blocks from the root
reserve and lead to resize failures due to lack of space. Moreover,
runtime configurable reserved_blocks represents permanent GC and metadata
headroom that must persist after resize, which would cause double-counting
if inflated for shrinkage.

To resolve this, introduce a dedicated reserve_shrink=<blocks>
mount option:
1. Symmetrically mirrors reserve_root=<blocks> in block units to
   pre-reserve space specifically for subsequent filesystem shrinkage.
2. In get_available_block_count(), unconditionally deducts
   reserve_shrink_blocks for all callers, strictly rejecting all
   allocations (including root / CAP_SYS_RESOURCE) once available blocks
   are exhausted.
3. In f2fs_statfs(), deducts reserve_shrink_blocks from f_bfree (and
   f_bavail) so that filesystem statistics accurately reflect usable space.
4. In f2fs_resize_fs(), automatically resets reserve_shrink_blocks to 0
   and clears F2FS_MOUNT_RESERVE_SHRINK upon successful shrink completion,
   releasing any remaining reservation.
5. In sysfs: reserved_blocks, subtracts reserve_shrink_blocks when
   validating the upper limit of configurable reserved blocks.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst |  7 +++++
 fs/f2fs/f2fs.h                     |  9 ++++++
 fs/f2fs/gc.c                       |  5 ++++
 fs/f2fs/super.c                    | 47 ++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c                    | 13 +++++++--
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 771216f45207..dbdc5d5a83ad 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -191,6 +191,13 @@ reserve_node=%d		 Support configuring reserved nodes which are used for
 			 gid, the default limit is 12.5% of all nodes.
 resuid=%d		 The user ID which may use the reserved blocks and nodes.
 resgid=%d		 The group ID which may use the reserved blocks and nodes.
+reserve_shrink=%d	 Support pre-reserving space for subsequent filesystem
+			 shrinkage (e.g. during partition resizing or FOTA),
+			 unit: blocks. Unlike reserve_root, allocations from
+			 this reserved space strictly reject all callers
+			 (including root / CAP_SYS_RESOURCE). Once the
+			 filesystem is successfully shrunk via resize, this
+			 value is automatically reset to 0.
 fault_injection=%d	 Enable fault injection in all supported types with
 			 specified injection rate.
 fault_type=%d		 Support configuring fault injection type, should be
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62efc25cd107..c21ed3eacc6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -145,6 +145,7 @@ enum f2fs_mount_opt {
 	 */
 	F2FS_MOUNT_LAZYTIME,
 	F2FS_MOUNT_RESERVE_NODE,
+	F2FS_MOUNT_RESERVE_SHRINK,
 };
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
@@ -226,6 +227,7 @@ struct f2fs_mount_info {
 	unsigned long long opt;
 	block_t root_reserved_blocks;	/* root reserved blocks */
 	block_t root_reserved_nodes;	/* root reserved nodes */
+	block_t reserve_shrink_blocks;	/* reserve blocks for shrink */
 	kuid_t s_resuid;		/* reserved blocks for uid */
 	kgid_t s_resgid;		/* reserved blocks for gid */
 	int active_logs;		/* # of active logs */
@@ -2658,6 +2660,13 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
+	if (test_opt(sbi, RESERVE_SHRINK)) {
+		if (avail_user_block_count > F2FS_OPTION(sbi).reserve_shrink_blocks)
+			avail_user_block_count -= F2FS_OPTION(sbi).reserve_shrink_blocks;
+		else
+			avail_user_block_count = 0;
+	}
+
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 		if (avail_user_block_count > sbi->unusable_block_count)
 			avail_user_block_count -= sbi->unusable_block_count;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bc22dde1cb30..556c4793478d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2492,6 +2492,11 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 		spin_lock(&sbi->stat_lock);
 		sbi->user_block_count += shrunk_blocks;
 		spin_unlock(&sbi->stat_lock);
+	} else if (test_opt(sbi, RESERVE_SHRINK)) {
+		spin_lock(&sbi->stat_lock);
+		F2FS_OPTION(sbi).reserve_shrink_blocks = 0;
+		clear_opt(sbi, RESERVE_SHRINK);
+		spin_unlock(&sbi->stat_lock);
 	}
 out_err:
 	f2fs_up_write_trace(&sbi->cp_global_sem, &clc);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f96abecb3c55..f7f82a32f99f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -196,6 +196,7 @@ enum {
 	Opt_data_flush,
 	Opt_reserve_root,
 	Opt_reserve_node,
+	Opt_reserve_shrink,
 	Opt_resgid,
 	Opt_resuid,
 	Opt_mode,
@@ -328,6 +329,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag("data_flush", Opt_data_flush),
 	fsparam_u32("reserve_root", Opt_reserve_root),
 	fsparam_u32("reserve_node", Opt_reserve_node),
+	fsparam_u32("reserve_shrink", Opt_reserve_shrink),
 	fsparam_gid("resgid", Opt_resgid),
 	fsparam_uid("resuid", Opt_resuid),
 	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
@@ -407,6 +409,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_lookup_mode			(1 << 24)
 #define F2FS_SPEC_reserve_node			(1 << 25)
 #define F2FS_SPEC_resizable_tail_secno		(1 << 26)
+#define F2FS_SPEC_reserve_shrink		(1 << 27)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -538,6 +541,27 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 					   F2FS_OPTION(sbi).s_resgid));
 }
 
+static inline void limit_reserve_shrink(struct f2fs_sb_info *sbi)
+{
+	block_t block_limit;
+
+	if (!test_opt(sbi, RESERVE_SHRINK))
+		return;
+
+	block_limit = sbi->user_block_count - sbi->reserved_blocks;
+	if (test_opt(sbi, RESERVE_ROOT)) {
+		if (block_limit > F2FS_OPTION(sbi).root_reserved_blocks)
+			block_limit -= F2FS_OPTION(sbi).root_reserved_blocks;
+		else
+			block_limit = 0;
+	}
+	if (F2FS_OPTION(sbi).reserve_shrink_blocks > block_limit) {
+		F2FS_OPTION(sbi).reserve_shrink_blocks = block_limit;
+		f2fs_info(sbi, "Reduce reserved blocks for shrink = %u",
+			  F2FS_OPTION(sbi).reserve_shrink_blocks);
+	}
+}
+
 static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 {
 	if (!F2FS_OPTION(sbi).unusable_cap_perc)
@@ -941,6 +965,14 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_reserve_node;
 		break;
+	case Opt_reserve_shrink:
+		if (result.uint_32)
+			ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_SHRINK);
+		else
+			ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_SHRINK);
+		F2FS_CTX_INFO(ctx).reserve_shrink_blocks = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_reserve_shrink;
+		break;
 	case Opt_resuid:
 		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
 		ctx->spec_mask |= F2FS_SPEC_resuid;
@@ -1763,6 +1795,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
 		F2FS_OPTION(sbi).root_reserved_nodes =
 					F2FS_CTX_INFO(ctx).root_reserved_nodes;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_shrink)
+		F2FS_OPTION(sbi).reserve_shrink_blocks =
+					F2FS_CTX_INFO(ctx).reserve_shrink_blocks;
 	if (ctx->spec_mask & F2FS_SPEC_resgid)
 		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
 	if (ctx->spec_mask & F2FS_SPEC_resuid)
@@ -2288,6 +2323,13 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
 
+	if (test_opt(sbi, RESERVE_SHRINK)) {
+		if (buf->f_bfree > F2FS_OPTION(sbi).reserve_shrink_blocks)
+			buf->f_bfree -= F2FS_OPTION(sbi).reserve_shrink_blocks;
+		else
+			buf->f_bfree = 0;
+	}
+
 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
 		buf->f_bfree = 0;
 	else
@@ -2512,6 +2554,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 					F2FS_OPTION(sbi).s_resuid),
 				from_kgid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resgid));
+	if (test_opt(sbi, RESERVE_SHRINK))
+		seq_printf(seq, ",reserve_shrink=%u",
+				F2FS_OPTION(sbi).reserve_shrink_blocks);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (test_opt(sbi, FAULT_INJECTION)) {
 		seq_printf(seq, ",fault_injection=%u",
@@ -3093,6 +3138,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 
 	adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
+	limit_reserve_shrink(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
 	sbi->umount_lock_holder = NULL;
@@ -5310,6 +5356,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->current_reserved_blocks = 0;
 	sbi->alias_reserved_blocks = 0;
 	limit_reserve_root(sbi);
+	limit_reserve_shrink(sbi);
 	adjust_unusable_cap_perc(sbi);
 
 	f2fs_init_extent_cache_info(sbi);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index aaca9ed9b169..d61940d095b4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -591,9 +591,18 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	}
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
+		unsigned long limit;
+
 		spin_lock(&sbi->stat_lock);
-		if (t > (unsigned long)(sbi->user_block_count -
-				F2FS_OPTION(sbi).root_reserved_blocks)) {
+		limit = sbi->user_block_count -
+				F2FS_OPTION(sbi).root_reserved_blocks;
+		if (test_opt(sbi, RESERVE_SHRINK)) {
+			if (limit > F2FS_OPTION(sbi).reserve_shrink_blocks)
+				limit -= F2FS_OPTION(sbi).reserve_shrink_blocks;
+			else
+				limit = 0;
+		}
+		if (t > limit) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
-- 
2.55.0.1007.g17ff1f9808-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
