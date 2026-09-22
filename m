Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2BC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rHGlmIPO8udPXDtwiw0uE+n0JsdQao8q3isBzWANvlU=; b=f0JUUA2BSHqk5TLp8Nn7Z9oDkt
	Kiy5ERpH5V4zLKA2LO9lKun55dNQsmDfgfBZ7WqGsqDeEtN4NcyRdI9iTIg86gMlRMH+kXe70gRBc
	ACv1OjRCCk0f9M4Ny7R+zbBQ1zn5fSWYDkJCP3N+qHQUU/XBKxH90Klt7zK33Wop8sIs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8zi8-0006eG-SJ;
	Tue, 22 Sep 2026 12:34:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1x8zi6-0006e9-U0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hYbTUzxgLFYzRvow5p9EwmLSvpRGotQ2Sjd88D9qtFc=; b=O2vob/MNLysgNwPQ9ezZoron+n
 LifRe6AWc6pzo3gjTI2EEuzQ4Wq+SFOckE4UafdbQg6uOOkSpoM0jU+gyBP2XLrSU+U2P2ZQ1EbPW
 T7fI/b8dqKSaOdv/0/GwV8fdfEdoUXocbvFjLlOroUh2N1uzQChZsof9FAEhhzBwNfls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hYbTUzxgLFYzRvow5p9EwmLSvpRGotQ2Sjd88D9qtFc=; b=Y
 kbVEoN8dPqhdNo2gs1J5+IwOrbb7XyUm0YHPJBE3XTU0W1iqsjE1mP9PqSoGKSxm73Nbyezki0sTR
 J4d20uIZ4+ELTBx8KkC9lzClidbPs+nKrwjabcnq/wvMtIOYtB5AUPHRQsXsRVsJBbw8zJwl/bAPM
 pAZrV2CWCxgculvQ=;
Received: from mail-pj2-f12.google.com ([74.125.227.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8zi3-0008DT-1y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 12:34:56 +0000
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so3010149a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790080489; x=1790685289; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hYbTUzxgLFYzRvow5p9EwmLSvpRGotQ2Sjd88D9qtFc=;
 b=Q/lLeHAROtGyIYgt8A2thDnNBnBsKYdPUB2SaRL6mTppPHIE/gIqH5J+QuIwNU5DnW
 W/mBl5OyWqHPZMOGQmI9is3/OZsG3HmDfcYX8yj/BYTQ0Aayuw0EZH+EytlscAQTcaVS
 D7ORJgZdDd/GH/boB5k+mCknTCnp17M7c19Xj7mqUyrToggDGKInVsSKihqI3LgLCYzP
 Huk4wXTEOhPx1uS0Tl2INIzrp/vNAlPCwRBG0eCfNVPSjkxQMUpr7AdHstDtOsRSPA2R
 39g3tisk97unAAGrEYHTnxC3LRUbJgsoB/HHCTxOoYLjPjlhT6hqIl1wDtD4yYkR9Cdr
 MWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080489; x=1790685289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYbTUzxgLFYzRvow5p9EwmLSvpRGotQ2Sjd88D9qtFc=;
 b=FNDjzgYapw62cgTcvdsepbfLwSDrnMhR5KepIl8WxE05e9TUSQ3+++F/pIkNr+SAyy
 A+p8koQTcu5f3E/gw5R+I1Il5g8bpboA7hb9KqjsHOzKoDbsM3wy9WVx/m5HdujSpdOc
 30OmwPrDa94YsRFce1hXcmhkxNC15iCewgnBbgEnMLonQFf+9H7htQTSF7+/oY6lzigo
 kkqh2AyS3s00ovAXK5YtpYTaLybyXRb+3/j+exV52rjRpAwFjHwMphFIW4Er4HBjcHRP
 F8eYwmuNmCKhMMiOq2xYdWPw/zDJcG9CJczkkf5xgVM3ja5jau7Rzn1kqq1Nc9qGZZGE
 6Kew==
X-Gm-Message-State: AFuF++nELris/d7+AfMIpHnOUIB+bj3BN4J7MvL1INujY30Z9z4GSOv2
 346RE1B2ODatm9011U/sM6jeSfukpXvRyOpXO9SXVdy8oaYOiTzwwUpqVNV0SQ==
X-Gm-Gg: AYBFou0JA9ZX59HExAze+IYaJV35SXlxFzWeS12MN132gfBvmUrbqrTRSil5kFiayR2
 HZMcnWFwGgA5gNxX3IEn1pXsabPzvLvRFCLzcwtQhgfe18kxdJNJ9iZpR8hB9CCA/ZA2b3rx7fU
 s/puky4IMBK7c1qWQ+UbrWiRqPhGTSdUhKeBIShy5n7JI0ZO98fmZwr8x/Ma/kQObDWe+YCyDqK
 8Jw+V2HirwYLeE2QNPLmjnHMYgAzoqvkSII2PO3zCm2qJkCP1MT9IbnqBUzVpnHRLmro8cKtg/I
 6U4D3lq898MPSC1QHb09scJT61+YnOvg2nMNKsTQYTCBupmuUcr7tFsgn+xkz/Y/vkNCHXBRVgf
 ds4WUwMMg1wBI4uO7FSxGSLDQfSJ+35/PHTuQgdT2Nk0iyzDU1jx4E06Pbt5lnZwiUXdeFxiI+M
 5Dt3s+m99QPSESVt+/L5t9GGDTC7mScU3pp7xkoLojcTElZSM/lh7Ej1RuNehz///2kS3Lro+kh
 +n/TGa3y+FmLtXVCRtjUIQ=
X-Received: by 2002:a17:90b:1850:b0:39e:6c69:f47d with SMTP id
 98e67ed59e1d1-3a073272586mr1106189a91.60.1790080489152; 
 Tue, 22 Sep 2026 05:34:49 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674df8bdsm4626478a91.16.2026.09.22.05.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:34:48 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 s_min.jeong@samsung.com
Date: Tue, 22 Sep 2026 20:34:43 +0800
Message-ID: <20260922123443.2908902-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x8zi3-0008DT-1y
Subject: [f2fs-dev] [PATCH] f2fs: recompute the pinned area boundary after
 resizing
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
Cc: zhanxusheng@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

sbi->pinned_area_max_secno is computed at mount and remount time only.
f2fs_resize_fs() shrinks MAIN_SECS(sbi) without recomputing it:

  mount -o resizable_tail_secno=4    MAIN_SECS 248, boundary 244
  F2FS_IOC_RESIZE_FS, -24 sections   MAIN_SECS 224, boundary 244

get_new_segment() scans free_secmap up to that boundary for pinned
allocations, and the removed sections are free there: the bitmap is sized
once in build_free_segmap() and free_segment_range() requires the range to
be free before it completes.  Nothing between the find_next_zero_bit() and
got_it compares secno against MAIN_SECS(sbi), so a pinned section can land
past the end of the shrunk filesystem.  has_unpinned_area() also turns
false, which disables the range GC retry in
f2fs_allocate_pinning_section().

update_fs_metadata() already clamps allocate_section_hint when MAIN_SECS()
changes; recompute the pinned boundary there too.  Recomputing rather than
clamping keeps what resizable_tail_secno asks for: the boundary becomes 220
at MAIN_SECS 224, so a further shrink is still protected.

Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Measured on x86_64 under QEMU with a 512 MiB image (1 segment per
section); the boundary values above are read from
/sys/fs/f2fs/<dev>/pinned_area_max_secno before and after the resize.
I did not fill sections 0..223 to make a pinned allocation actually
select one of the removed sections; that part is from reading
get_new_segment().
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/gc.c    | 1 +
 fs/f2fs/super.c | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9940a6cecf1a..07387be40f65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3979,6 +3979,7 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
+void f2fs_adjust_pinned_area_boundary(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a00180c21dc..a20ac70d53b8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2328,6 +2328,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	MAIN_SECS(sbi) += secs;
 	if (sbi->allocate_section_hint > MAIN_SECS(sbi))
 		sbi->allocate_section_hint = MAIN_SECS(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 	FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
 	FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
 	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..65ef8be2a614 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -554,7 +554,7 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 			F2FS_OPTION(sbi).unusable_cap_perc);
 }
 
-static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
+void f2fs_adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
 {
 	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
 	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
@@ -3078,7 +3078,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5321,7 +5321,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
-	adjust_pinned_area_boundary(sbi);
+	f2fs_adjust_pinned_area_boundary(sbi);
 
 	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
