Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490F7C87FD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Aug 2025 06:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Kq7ULyiz1Kt7BKEPzi34CPclmKDQEnBGb+pRvQVdK2M=; b=XRWVpbUdgRKIXtnefp5fDNRarh
	LNUspazbgxm6V9uZRx7g33ev08ygRfZ+UF7p2Pejwo3AT2WFB5K8M7ib+iK8JMW7fLe3zNgCH6SPn
	sCH6ZGN2GwYH2OCGd+3zQ0q9G0RLZ6V43dOYPG+3XkgUEZGfwc+nihpezd+rYce1/WpY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uioIN-00046X-Tc;
	Mon, 04 Aug 2025 06:03:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3M02QaAcKAFo49MDD668GG8D6.4GE@flex--chullee.bounces.google.com>)
 id 1uioIL-00046R-Uz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 06:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=; b=BmyCuLTHgn4RBuCgH7EKg79Akk
 7PdsOHWQcyXFJVmeajs9QweX3JCCeG5Roz/UelIYXRSrgf7sobHdpUly6LaS2MvgriotC1fzkdY2j
 Vl/eoI5pZ9GBDqgxRwCM1rKII+fQUkOm264XXMJPCmrZ+QDEC5vi680WLNDCYeixj5W4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=; b=b
 AaCWSOtei+toGl3na1pxH5/p1JTNB3RedXTQVsGfkGEsc+1YDS8hoKhhEwLwlxvbdZ+HfqtXs60lf
 DPPRzF/b5N6Ts+B1pjdSqXujx0MgMA07znmbdPJ8mbJQnPtDR07jvwUrWQMBGraVqFKOw5NZcuImt
 JGmS/dPSqWNqyXbQ=;
Received: from mail-pf1-f202.google.com ([209.85.210.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uioIL-0007a4-ED for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 06:03:37 +0000
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-76bd1cd5ae9so5474106b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 03 Aug 2025 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1754287412; x=1754892212;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=;
 b=MRjuRyzxz93FhilFws4Dw66igIHiz2fJCHMeUS792Hr2/DkhtZcwBJIVx4OIZ+MDQZ
 OjljE8efcIgLrs8bBnnIpfej4kLmYXhWsFfOzWp4+UQ0Za0qdktKul+5+z6bL0NeHz9c
 xo1HFS+XTFroefx+TsqMEjoSRk7OqvCB1wYtw+DofEEBiCxkDktXYC+nE/SoHxk7dqL9
 prf1KyUISlGZnNh07h+baay2EHUVHF/RRIcITJ5ba0fSOebxhro87CMztZ3IDc0VCCo9
 ahKPsd/Mx35IdlvO8FP7dZ6MbANqt0UnH7weq80gH9c+uvcxHvrLQfiz+3/p89/9YqPN
 YoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754287412; x=1754892212;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=;
 b=OxIU6jSCNJ9vTZ41xgrI2k/iPtabXn7bAOMHRza+7N1JNhFFKCE2rt72+i51ySMSL0
 Q3uIaXGq5rZ4yPl6UCIGjtv+DokLwEX96SeOnUUB0fg/9E26FchUxxqD/GR6HF/VywiU
 sTcjxj17a0bD++xO3RW6LKepD1q5Y4VvGCmmcNC89nadD0jhWjZSb7AhMQk5iU72Z2XA
 KBb5vI2sd5VdMCumWxZPdKQj3N+ecdrcrM8zwGgFysP1j97DnqP3lP3w9vPVT+ktghGa
 NCkPAOtyGInPqtEIivo2DY1hUNLpP2BhrEOEoP4/LfbF790tMWJVaz4CBRM1w30F8LNE
 WsfQ==
X-Gm-Message-State: AOJu0Yxu02ZZOyzITvu+mHaqJOX5EEFcZeseyciXvZdJG4Ujd+khxmRJ
 o+YZh0k6FkQCThADIEQa1bjowj8EDfha7k8DGDoIWmBZMCFOUoYHD2V5VGfA97fEuqD/Tgl4OX3
 g6FaBVLGFKw==
X-Google-Smtp-Source: AGHT+IHMBbHQiqqtxuRJj5ec5P70FJZ0/coPwj7FXCqLACpqnSQ89lwhXMyLuSH0E1eTQ4YaofJ7abWXCnGI
X-Received: from pfbg17.prod.google.com ([2002:a05:6a00:ae11:b0:76b:f876:772e])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210c:b0:21f:5598:4c2c
 with SMTP id adf61e73a8af0-23df8fa5edemr12542666637.13.1754287411768; Sun, 03
 Aug 2025 23:03:31 -0700 (PDT)
Date: Sun,  3 Aug 2025 23:03:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804060327.512247-1-chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1uioIL-0007a4-ED
Subject: [f2fs-dev] [PATCH 1/2] f2fs: add lookup_mode mount option
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
From: Daniel Lee via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Lee <chullee@google.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For casefolded directories, f2fs may fall back to a linear search if
a hash-based lookup fails. This can cause severe performance
regressions.

While this behavior can be controlled by userspace tools (e.g. mkfs,
fsck) by setting an on-disk flag, a kernel-level solution is needed
to guarantee the lookup behavior regardless of the on-disk state.

This commit introduces the 'lookup_mode' mount option to provide this
kernel-side control.

The option accepts three values:
- perf: (Default) Enforces a hash-only lookup. The linear fallback
  is always disabled.
- compat: Enables the linear search fallback for compatibility with
  directory entries from older kernels.
- auto: Determines the mode based on the on-disk flag, preserving the
  userspace-based behavior.

Signed-off-by: Daniel Lee <chullee@google.com>
---
 Documentation/filesystems/f2fs.rst | 19 ++++++++++++++
 fs/f2fs/dir.c                      | 17 ++++++++++++-
 fs/f2fs/f2fs.h                     | 41 ++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    | 20 +++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 440e4ae74e44..01c657ff7ae2 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -370,6 +370,25 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			 ====================== =============== =============== ========
 nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
 			 by default it's disabled.
+lookup_mode=%s		 Control the directory lookup behavior for casefolded
+			 directories. This option has no effect on directories
+			 that do not have the casefold feature enabled.
+
+			 ================== ========================================
+			 Value		    Description
+			 ================== ========================================
+			 perf		    (Default) Enforces a hash-only lookup.
+					    The linear search fallback is always
+					    disabled, ignoring the on-disk flag.
+			 compat		    Enables the linear search fallback for
+					    compatibility with directory entries
+					    created by older kernel that used a
+					    different case-folding algorithm.
+					    This mode ignores the on-disk flag.
+			 auto		    F2FS determines the mode based on the
+					    on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
+					    flag.
+			 ================== ========================================
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c36b3b22bfff..ba032d21a997 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,21 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
+static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	switch (f2fs_get_lookup_mode(sbi)) {
+	case LOOKUP_PERF:
+		return false;
+	case LOOKUP_COMPAT:
+		return true;
+	case LOOKUP_AUTO:
+		return !sb_no_casefold_compat_fallback(sbi->sb);
+	}
+	return false;
+}
+
 #if IS_ENABLED(CONFIG_UNICODE)
 extern struct kmem_cache *f2fs_cf_name_slab;
 #endif
@@ -366,7 +381,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 out:
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
+	if (f2fs_should_fallback_to_linear(dir) &&
 		IS_CASEFOLDED(dir) && !de && use_hash) {
 		use_hash = false;
 		goto start_find_entry;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9333a22b9a01..fed588f4fa3d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -132,6 +132,12 @@ extern const char *f2fs_fault_name[FAULT_MAX];
  */
 #define F2FS_MOUNT_LAZYTIME		0x40000000
 
+enum f2fs_lookup_mode {
+	LOOKUP_PERF,
+	LOOKUP_COMPAT,
+	LOOKUP_AUTO,
+};
+
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(F2FS_OPTION(sbi).opt |= F2FS_MOUNT_##option)
@@ -1355,6 +1361,8 @@ enum {
 	SBI_IS_RESIZEFS,			/* resizefs is in process */
 	SBI_IS_FREEZING,			/* freezefs is in process */
 	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
+	SBI_LOOKUP_COMPAT,			/* enable compat/auto lookup modes */
+	SBI_LOOKUP_AUTO,			/* enable auto lookup mode */
 	MAX_SBI_FLAG,
 };
 
@@ -4897,6 +4905,39 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
 }
 
+/*
+ * The lookup mode is stored in two bits within sbi->s_flag:
+ *
+ * SBI_LOOKUP_COMPAT | SBI_LOOKUP_AUTO | Mode
+ * ------------------|-----------------|--------
+ *          0        |         0       | perf
+ *          1        |         0       | compat
+ *          1        |         1       | auto
+ *
+ */
+static inline enum f2fs_lookup_mode f2fs_get_lookup_mode(struct f2fs_sb_info *sbi)
+{
+	if (!is_sbi_flag_set(sbi, SBI_LOOKUP_COMPAT))
+		return LOOKUP_PERF;
+	if (is_sbi_flag_set(sbi, SBI_LOOKUP_AUTO))
+		return LOOKUP_AUTO;
+	return LOOKUP_COMPAT;
+}
+
+static inline void f2fs_set_lookup_mode(struct f2fs_sb_info *sbi,
+						enum f2fs_lookup_mode mode)
+{
+	clear_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+	clear_sbi_flag(sbi, SBI_LOOKUP_AUTO);
+
+	if (mode == LOOKUP_COMPAT)
+		set_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+	else if (mode == LOOKUP_AUTO) {
+		set_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+		set_sbi_flag(sbi, SBI_LOOKUP_AUTO);
+	}
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..09cdd4c22e58 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -196,6 +196,7 @@ enum {
 	Opt_age_extent_cache,
 	Opt_errors,
 	Opt_nat_bits,
+	Opt_lookup_mode,
 	Opt_err,
 };
 
@@ -276,6 +277,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_age_extent_cache, "age_extent_cache"},
 	{Opt_errors, "errors=%s"},
 	{Opt_nat_bits, "nat_bits"},
+	{Opt_lookup_mode, "lookup_mode=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1317,6 +1319,22 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 		case Opt_nat_bits:
 			set_opt(sbi, NAT_BITS);
 			break;
+		case Opt_lookup_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "perf")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_PERF);
+			} else if (!strcmp(name, "compat")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_COMPAT);
+			} else if (!strcmp(name, "auto")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_AUTO);
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2220,6 +2238,8 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 #endif
 
 	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
+
+	f2fs_set_lookup_mode(sbi, LOOKUP_PERF);
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.50.1.565.gc32cd1483b-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
