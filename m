Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FADC88E50
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqILHjIOzBDRPhk5VwMKUN+OP/c/6ymFed3ELtCvKGg=; b=AfRT64+I8fndzY+zHPdSckqdTE
	G/gCOLTW0i6ciaZRBLYKdPL+VvdeNP1J5Ly/gmEdvhWUWt8CB7vaDPgIYXQrcjbuw5S5sG7Nys52I
	Z3UrAq6OuNUE8G9+gHwqqdGn48fS8kIEOCTEoCzNWSfJNAxbEFG3Uwz2GXYj9CgOtM6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x52MK-0004os-0p;
	Fri, 11 Sep 2026 14:36:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x52MI-0004ob-Nm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 14:36:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9nmlV1RetPQeAutS6jDocxh3htEhmcFudZu/wAAqidc=; b=NZErkf3FnmXZp/54oxNZCw74Rj
 JObD0x0jAGOjrxysXmWrumAqZG83krIIY0p/tpmRgDVONDuqApibzlTlpLzgvfoEBuE9kygmz8TN4
 eu+y82awMxCCGbK2uKYKdPxegSlsGsZFx5x53fRLrbP17GuIhwU1/BTgV2WFNI2aRrfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9nmlV1RetPQeAutS6jDocxh3htEhmcFudZu/wAAqidc=; b=KKRyzc+GgqZ7E6cHNCp6e3JQe4
 prluMyp2BhuZydolWecrltKTOvZqz5je1l+aKthPqcSrtcXwMCr2n+cPln1pWM6z8SkadH9UNh8Ma
 bUFMYIyPQEa+0gBgK6wCweWHlDvPcxh07eCAQaA5ZAAOb9ki+ErmGoVDtgw4KDF5Ouhg=;
Received: from mail-pj2-f12.google.com ([74.125.227.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52MG-0007z4-OC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 14:36:07 +0000
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb750so942790a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789137359; x=1789742159; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9nmlV1RetPQeAutS6jDocxh3htEhmcFudZu/wAAqidc=;
 b=IGjBNyJp8JQqTah3B35E2PZkP+zFRvJXf0hUMG5YejPvuLyNuBpDcnBGLGWQ1NIggZ
 DJveQevOTj1zOoiwaWVq6nEnCyhNYUzY7LVFKof9S13W0AVI+5mO7BIsmNy6wg22IF5m
 46VoqCUQCEove5E7JElabPAUXgnIgf8B7SVy4VRS8eRPhOI7yJWS6/1UdcwrRY5XuzH3
 QmCHlBPskyPuznuX1A5jewKbG24XlQvt1RLtU+77qZ+ulznSsDZSOU0FfkAhPUD3QtBW
 8tNbNZYl/b9/+9YOEAxdwtAr9SfFKvadzgGPoybaeR3LXehmjd1hRFvK4k5Elfiydr5y
 r1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789137359; x=1789742159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9nmlV1RetPQeAutS6jDocxh3htEhmcFudZu/wAAqidc=;
 b=osKKOx2qrvIpd8QsLjpF4rrgo7nU2RNCCEcFoyhArfTvZY0yyy9rt9lVgE28Rd65Ew
 7/n/8Z0s3yRSu1kuc5vCir6V9U6xboMOFE/tePS74jkuqRbAp3SerhsThS/pblAspyvi
 sS9eVLxUmUBKzbwaWP+Hhmqxcn1MmEPQGhfdJP5Wcq0bwzMJLV+uN/7n4qK2GOp0TJQ9
 Wt8A3jIRI7vYQhyyuFtG/FJSstLGdr0CTrPN7WM3lI/0/kI91eyrKg/V0FNocVWqsad3
 F4yet5yu+q9tiv1P8JumDC902g6MjE7pgtdWQGcSj7RZOvuVYfD9GomGDmh6MlvM5Di8
 JQxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfSEQGoESckWzr8b+0ISnNGDCISfb3B5p2OgwQEHQiXx0zqWxgmRC4O3QAnL0HqMdSxaHU4TJ9nEkAWVGZnN9D@lists.sourceforge.net
X-Gm-Message-State: AFuF++lnZX0sxsewqiKkaVVVesAn5I9hhbeTWXr7xAYtyGBmVsQw9dbs
 EQRuq9CyDduR8/KVk2hV8eTiXDRrUw9hIIX5AFK2Lon3k8Svsff4zqGo
X-Gm-Gg: AYBFou2WvX7gj7CRlRuuZ6iZRe4G8FnpMk9vxsZTRKYFognW8EoTfbh4JdNJg2Qbd68
 NtFKnUom7zUSEP3g6HGzxSHikaiaOkxh5bR7Nu3Nl8aENEENnuMJ/LVS0hwT6n+DQe8zkF2//W/
 8B24FIec9ir0tDW2wZAqx9IaxcuhEF3cLbXpFU1zawYgKgLCh7SPrDoyvCsz9IOa2MWHa5W0Crh
 JKm+doQU57MUG9eVnmIo9sE1SDYG1AmA0P4pZTw8cZNwv2S/3RGzNmySWmclGOHQQAX1Qd9vS64
 T1u2SQ5j5JYgKSBthSlwF9xlOzasaGQZqVajPEGkIhW+ZvXNxu2WmPhIgTNGBeL34GBR0SCCbQS
 d7ws2+dn6qZNwcXFh5+sT0ceFRu5LC36nw7FVLawg2AXQsPdzfFkajb/KRetulSX8Q7+Nw1jz7G
 lUnLeUgufjG7Y+yBu718Zyhf0I/u22CETjwCzmnlxH9h1t6mWSjsvth3GMqaOUOo4Ek0rzR+wl1
 8NanAR7pVoC6D059Px9t9PMw4y5jfaU50Zo885Fe3t6ItrD1YevMfgh37pCAMrNRYiE72CIdFZS
 Z2FtMu6LdI4jsTkPpeTFsA==
X-Received: by 2002:a17:90b:2588:b0:38d:fda6:4873 with SMTP id
 98e67ed59e1d1-39d9bd99cc7mr8452274a91.10.1789137358064; 
 Fri, 11 Sep 2026 07:35:58 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:4a5b:802b:c0b:d1d7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm7156371eec.25.2026.09.11.07.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:35:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 11 Sep 2026 07:35:49 -0700
Message-ID: <20260911143549.909867-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260911143549.909867-1-daeho43@gmail.com>
References: <20260911143549.909867-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x52MG-0007z4-OC
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: introduce reserve_shrink mount
 option for filesystem shrinkage
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
v2:
 - Split out mount option bitmask expansion (BIT_ULL) into a separate
   prerequisite patch (Patch 1/2).
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
index 4aaf29de3f6f..48a91771be95 100644
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
index a5e109bdcebc..58f33750b2a8 100644
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
@@ -550,6 +553,27 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
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
@@ -953,6 +977,14 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
@@ -1775,6 +1807,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
 		F2FS_OPTION(sbi).root_reserved_nodes =
 					F2FS_CTX_INFO(ctx).root_reserved_nodes;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_shrink)
+		F2FS_OPTION(sbi).reserve_shrink_blocks =
+					F2FS_CTX_INFO(ctx).reserve_shrink_blocks;
 	if (ctx->spec_mask & F2FS_SPEC_resgid)
 		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
 	if (ctx->spec_mask & F2FS_SPEC_resuid)
@@ -2300,6 +2335,13 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -2524,6 +2566,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 					F2FS_OPTION(sbi).s_resuid),
 				from_kgid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resgid));
+	if (test_opt(sbi, RESERVE_SHRINK))
+		seq_printf(seq, ",reserve_shrink=%u",
+				F2FS_OPTION(sbi).reserve_shrink_blocks);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (test_opt(sbi, FAULT_INJECTION)) {
 		seq_printf(seq, ",fault_injection=%u",
@@ -3105,6 +3150,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 
 	adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
+	limit_reserve_shrink(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
 	sbi->umount_lock_holder = NULL;
@@ -5322,6 +5368,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
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
