Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D65DC88E45
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cBS+lMkrLMe6KHmdU21RvEHtotMj7PLBBmZHGKXg43Q=; b=H8K7xcr44dvvsk3gxuiOOPCCex
	Dgl5lyg8Yc5bV6raAZ3c0CyjrWeBZOOisv6FmgDRjrHRWtVxewILdo08FgovFg9fojtNPx121JtPI
	hWl8M9FvD6KD8M1/nSbq2/ZF0eYTcOp9//YCevxnB6dfOQf6FlwRs0nu6tfveUsIoSK4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x52MJ-0004Si-Dv;
	Fri, 11 Sep 2026 14:36:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x52MI-0004Sc-S3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 14:36:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CAF1AyJzEXRi17wzAYu3TkYA3d413Tq6GeGUnMS210s=; b=bBbraleiKfk5uPLRaKpNl5+ZVQ
 ogU8sQRKJI1mhBcVEKcb0IpQueJi8vAIT1wVnQJrkkhd7IIPdSDMwCJqeyZcCx0TjThdozc3TK22Y
 ekCDPc9IdlQEpWfOh08JYclyv8FS/lywXJSz3/0dh4BR9kX/+Pjao4rdlt5yhewYZDFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CAF1AyJzEXRi17wzAYu3TkYA3d413Tq6GeGUnMS210s=; b=O
 Py8vsYb6nZlKh5csu5tg8E8Rt8QPmf3+p+joYgxoqOMAfJTqEF2yEzCPAm9RFCzwOuE23Ga4EsH3D
 WsZZV2vNooDx4TluGsPr85cj0FxKBi0XLsenL09vXihRG3KwgjetvZqCuoMv0gYBGKtOS7coigmdG
 FffIA9rvejWJ3vRM=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52MD-0007ym-Bv for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 14:36:04 +0000
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc4c1210748so782026a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789137356; x=1789742156; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAF1AyJzEXRi17wzAYu3TkYA3d413Tq6GeGUnMS210s=;
 b=Kw1PkVdJqBoH9OU6wsbp0rg1EPyjsnf5G+4E0U7Dkf7EKupLrfehVVc8ex021SrJ5u
 Uw9SUkLaE6O7WVvlhyFhT3/Kfe1QFBH2lLQLCtFZ9qGCasgnio3srFIWABskcVAFiNd2
 BDMpeqZaUyNl/YpMEwaLKLUIpXo5swqAsPtlNOP6Fv7I4OR1WdUu0G5hyUPkj8PHG9FK
 xbnFVgMhzqUNWiFicVAKSGww1DyZYCK0qcX7Q/uBVH1/sKVNJGfarynhS+L64WgYhA31
 ZeMHAVxsXwBi+0AIVyS7WQyVkboRHQ3EoBIV8MiELCw36Mt3mqhrv6PsT7lQhAKmHtVN
 fobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789137356; x=1789742156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAF1AyJzEXRi17wzAYu3TkYA3d413Tq6GeGUnMS210s=;
 b=jiYAPkNjJcpacinzEsyOyHuWC9x2l0yKHExrfvlS0hjrvVa5PvLbqNcSvezphXRKx+
 lPxacoUQ29sizDtatMFTFTOYl0Ej9QRjJ/ZEwL1PprzsAC0EIt9eIZ+pJ//UgOZK9x8F
 RCADYzLOAOJgsSRy6doTD5DETbhhHX3J9Q0V0j4pcvENtmIdz9P3NKQybb7J2KejLVpA
 YFhb3yhxH4IOlW3/IuVkeTMuVCf0A31HFKLDFzSv4JdZt7h+VkWIWaPGlAiC4l3glLGr
 fsN4qHi1daNT+UmpPp9ZGrtkKO0ypPtgybWE2ksII+ECRR+qe7Dbz96evgNW3zLIMpGR
 uepg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfO8ln2eKgtkcxYIef9RBUsgf5euvq2aPdmVey8J89vzhw5rciLmPj7CS3yEyuzR86qvk/6TUQqqzY7gwNswjp@lists.sourceforge.net
X-Gm-Message-State: AFuF++lTbYZWER8TBU3Ufo4WsJFDP90arSozpaqRUDa09zeqwNvO+/0P
 cMwXHP1cu3JAKL0ArMCtURlyocTG5PIWZAgKzswBswzupB2QE3N1rmPh
X-Gm-Gg: AYBFou2R5c1YJdY6nEyDhpfzSPInf/B3gDbmr6ft2UZ8EI5D0ygdwAo6qpeKOcaNurg
 MfAwR02Vd2XKYbNSK6p0/fIb/cuOBK+Z174iYo8vl8P5omo1H3+xWACfWigfSOn9ZcggkcgjOEA
 Dw8/5ajQ1pE0rLPIfu0zc/B7mLbq8k7rVpu/tgVmyNqlnilD0cv2ASRPjA3CFgHT3BtSvTCZaCY
 OMU9QXSuitC+PA78Ac6TKS5PdxiII6w5CWCGFIzoRGsXxpY4GYGfLE8/8xezcxiKqgHcq4f+dHA
 Ae3DsJeepnah34++CFrpLtgs/HFj6yu/Vi7kH39Zk7QrjB9GR/0uXwRypGHw4qt59cvhq1RvtJE
 vOl5FM3x2T/wUWDLFMs+Hd8EQT3GaQYFqS+Is1VQLrhaovdMUfo7R96/wlHr6V70ElFtP1xwRzz
 KLNCwkQZNL297e4F1W5cX7frpl+B8Sx/xaFwFlCkDHykyqTyBCRcv8K6AH0dtaTQYgRbmuYm4II
 HTM8fbrhYc1Ng+62TCDaPulFYS8C1L3w68Iv6MCHTxta1MIndYRDJLGI4BJHP5ajgIIXrxOqP7K
 NnRFy9PpST1Em+CE3V0zWw==
X-Received: by 2002:a17:90b:4a8c:b0:398:9c0c:7c72 with SMTP id
 98e67ed59e1d1-39d9c3891d8mr7572423a91.25.1789137355496; 
 Fri, 11 Sep 2026 07:35:55 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:4a5b:802b:c0b:d1d7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm7156371eec.25.2026.09.11.07.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:35:54 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 11 Sep 2026 07:35:48 -0700
Message-ID: <20260911143549.909867-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
MIME-Version: 1.0
X-Headers-End: 1x52MD-0007ym-Bv
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: use BIT_ULL for mount option
 bitmasks
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Although f2fs_mount_info.opt and f2fs_fs_context.opt_mask are declared as
unsigned long long (64 bits), the option bit manipulation macros
(clear_opt, set_opt, test_opt) and context helpers (ctx_set_opt,
ctx_clear_opt, ctx_test_opt) use BIT(), which expands to (UL(1) << nr).

On 32-bit architectures, sizeof(unsigned long) is 32 bits, causing shift
count overflow warnings and functional truncation if mount option indices
reach or exceed 32.

Replace BIT() with BIT_ULL() for mount option bitmasks and helpers.
Additionally, introduce ctx_clear_opt_mask() and ctx_test_opt_mask()
helpers to avoid open-coded bitwise manipulations on ctx->opt_mask.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609111633.uyRbsEUB-lkp@intel.com/
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2:
 - Newly added in v2 to fix 32-bit shift count overflow reported by
   the kernel test robot, and introduce ctx_{test,clear}_opt_mask() helpers.
---
 fs/f2fs/f2fs.h  |  6 +++---
 fs/f2fs/super.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62efc25cd107..4aaf29de3f6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -149,11 +149,11 @@ enum f2fs_mount_opt {
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)		\
-	(F2FS_OPTION(sbi).opt &= ~BIT(F2FS_MOUNT_##option))
+	(F2FS_OPTION(sbi).opt &= ~BIT_ULL(F2FS_MOUNT_##option))
 #define set_opt(sbi, option)		\
-	(F2FS_OPTION(sbi).opt |= BIT(F2FS_MOUNT_##option))
+	(F2FS_OPTION(sbi).opt |= BIT_ULL(F2FS_MOUNT_##option))
 #define test_opt(sbi, option)		\
-	(F2FS_OPTION(sbi).opt & BIT(F2FS_MOUNT_##option))
+	(F2FS_OPTION(sbi).opt & BIT_ULL(F2FS_MOUNT_##option))
 
 #define ver_after(a, b)	(typecheck(unsigned long long, a) &&		\
 		typecheck(unsigned long long, b) &&			\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f96abecb3c55..a5e109bdcebc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -420,21 +420,33 @@ struct f2fs_fs_context {
 static inline void ctx_set_opt(struct f2fs_fs_context *ctx,
 			       enum f2fs_mount_opt flag)
 {
-	ctx->info.opt |= BIT(flag);
-	ctx->opt_mask |= BIT(flag);
+	ctx->info.opt |= BIT_ULL(flag);
+	ctx->opt_mask |= BIT_ULL(flag);
 }
 
 static inline void ctx_clear_opt(struct f2fs_fs_context *ctx,
 				 enum f2fs_mount_opt flag)
 {
-	ctx->info.opt &= ~BIT(flag);
-	ctx->opt_mask |= BIT(flag);
+	ctx->info.opt &= ~BIT_ULL(flag);
+	ctx->opt_mask |= BIT_ULL(flag);
 }
 
 static inline bool ctx_test_opt(struct f2fs_fs_context *ctx,
 				enum f2fs_mount_opt flag)
 {
-	return ctx->info.opt & BIT(flag);
+	return ctx->info.opt & BIT_ULL(flag);
+}
+
+static inline void ctx_clear_opt_mask(struct f2fs_fs_context *ctx,
+				      enum f2fs_mount_opt flag)
+{
+	ctx->opt_mask &= ~BIT_ULL(flag);
+}
+
+static inline bool ctx_test_opt_mask(struct f2fs_fs_context *ctx,
+				     enum f2fs_mount_opt flag)
+{
+	return ctx->opt_mask & BIT_ULL(flag);
 }
 
 void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate,
@@ -1443,7 +1455,7 @@ static int f2fs_check_compression(struct fs_context *fc,
 			ctx_test_opt(ctx, F2FS_MOUNT_COMPRESS_CACHE))
 			f2fs_info(sbi, "Image doesn't support compression");
 		clear_compression_spec(ctx);
-		ctx->opt_mask &= ~BIT(F2FS_MOUNT_COMPRESS_CACHE);
+		ctx_clear_opt_mask(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		return 0;
 	}
 	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
@@ -1511,43 +1523,43 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 		return -EINVAL;
 
 	if (f2fs_hw_should_discard(sbi) &&
-			(ctx->opt_mask & BIT(F2FS_MOUNT_DISCARD)) &&
+			ctx_test_opt_mask(ctx, F2FS_MOUNT_DISCARD) &&
 			!ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
 		f2fs_warn(sbi, "discard is required for zoned block devices");
 		return -EINVAL;
 	}
 
 	if (!f2fs_hw_support_discard(sbi) &&
-			(ctx->opt_mask & BIT(F2FS_MOUNT_DISCARD)) &&
+			ctx_test_opt_mask(ctx, F2FS_MOUNT_DISCARD) &&
 			ctx_test_opt(ctx, F2FS_MOUNT_DISCARD)) {
 		f2fs_warn(sbi, "device does not support discard");
 		ctx_clear_opt(ctx, F2FS_MOUNT_DISCARD);
-		ctx->opt_mask &= ~BIT(F2FS_MOUNT_DISCARD);
+		ctx_clear_opt_mask(ctx, F2FS_MOUNT_DISCARD);
 	}
 
 	if (f2fs_sb_has_device_alias(sbi) &&
-			(ctx->opt_mask & BIT(F2FS_MOUNT_READ_EXTENT_CACHE)) &&
+			ctx_test_opt_mask(ctx, F2FS_MOUNT_READ_EXTENT_CACHE) &&
 			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
 		return -EINVAL;
 	}
 
 	if (test_opt(sbi, RESERVE_ROOT) &&
-			(ctx->opt_mask & BIT(F2FS_MOUNT_RESERVE_ROOT)) &&
+			ctx_test_opt_mask(ctx, F2FS_MOUNT_RESERVE_ROOT) &&
 			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_ROOT)) {
 		f2fs_info(sbi, "Preserve previous reserve_root=%u",
 			F2FS_OPTION(sbi).root_reserved_blocks);
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
-		ctx->opt_mask &= ~BIT(F2FS_MOUNT_RESERVE_ROOT);
+		ctx_clear_opt_mask(ctx, F2FS_MOUNT_RESERVE_ROOT);
 		ctx->spec_mask &= ~F2FS_SPEC_reserve_root;
 	}
 	if (test_opt(sbi, RESERVE_NODE) &&
-			(ctx->opt_mask & BIT(F2FS_MOUNT_RESERVE_NODE)) &&
+			ctx_test_opt_mask(ctx, F2FS_MOUNT_RESERVE_NODE) &&
 			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
 		f2fs_info(sbi, "Preserve previous reserve_node=%u",
 			F2FS_OPTION(sbi).root_reserved_nodes);
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
-		ctx->opt_mask &= ~BIT(F2FS_MOUNT_RESERVE_NODE);
+		ctx_clear_opt_mask(ctx, F2FS_MOUNT_RESERVE_NODE);
 		ctx->spec_mask &= ~F2FS_SPEC_reserve_node;
 	}
 
-- 
2.55.0.1007.g17ff1f9808-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
