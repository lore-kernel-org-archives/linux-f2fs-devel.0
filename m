Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BECC5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AwUNP41WW2Exa2vLK2EzluF+4GtIu22jk/LlA+dYyUo=; b=EHPjmRyjaYUTUfdePhWKqudfMI
	Qw8NJYO6xcBaCPu+fQvq1EgerProwulJA4A2UsI5MXOIUuCcfrWzae7jHZYl0n11KhVHcETfHfPT/
	3bZqgZ5tqkr+sCSN9lI/ANUhjaPFDh/sU83qdRdW3M7eLU7x1zQ+M1cH/Zyyfx4/LhH4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzFgS-0000cd-9f;
	Wed, 26 Aug 2026 15:36:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wzFgR-0000cT-7u
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRMb7/mGwLP34fLJtfMaGqpTh24hDTQbJ1slGxBXJ5c=; b=UZwyF7qgQDCsfIXm4a4hbHSo97
 WssfASXbp7e9ZfKg6sRlMqnSqX9aVRlm2bHUdFkL4NNAl7wUGyqkPk4nHwHA1UfL7KpcFJrRYfwss
 Rlb6QIGLatxu3XUruDavG/SyOqft+TkRQ/owOnfTCJHCRJadFWGw1iPaN4jvcKv/a7Sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mRMb7/mGwLP34fLJtfMaGqpTh24hDTQbJ1slGxBXJ5c=; b=I
 gnbnrcHueagr/7GerdGX5qIau0LtZbtcqOGb34ceY2O3QN8OousElDFJjGYmeb9Oo/0EOhKXdAW+B
 gSeVKMPFyQ/2newuaGk/QGrGeHkZVQlx5mrQAh+wJ+RaIk8ZpUAaxzRw6hfqo+h+hrPcvatbaA0TI
 /KvHsI9+8AIljYt4=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFgN-0007bN-8d for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:36:56 +0000
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so829131a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787758609; x=1788363409; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mRMb7/mGwLP34fLJtfMaGqpTh24hDTQbJ1slGxBXJ5c=;
 b=srW+9xSEjBp4bzfQS/YikykQCiBxxV0/Jf+rnA4aLd0vPp+ssxI/6Tr+sI5KQc0WsS
 9LNzVkLbdzcRyXgmLhSMPaU+xIZf0xO+2T0flK1d2YSgBu7l/ci9d8VGi9yW4OHRxn1d
 U7opMRbtRrqTJbbIPm+tuHAYtPJ7sNhz+jDF0l6apZAZ/UeSeAdlpw33qPRn6jSMa5f/
 UHKI0VI00qY+iy0u/FuOC0P2gPxP89zHaobzsN7IHVJEWho3IzY8fIt5PPqKJbGK3bph
 Bsh7lW8GWnxwe0KT/0fv6XxRhGj+scBEct/ENaRAGsfM4sPfGDWSmC2MIh6w/vWhRGRP
 5UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758609; x=1788363409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mRMb7/mGwLP34fLJtfMaGqpTh24hDTQbJ1slGxBXJ5c=;
 b=mJ59gr3DvS0Gf8JBQ6mMePv7vRsVxiFUL90YqIuHxcTqVoLdk5KUSO8EAnyhue5ggJ
 1G5VZ9++BFOOqeFnhtjwan5GueSDU0JnTHr7k+Co4BqTjbzdMq3z3s0rH0kZ0WTALGRH
 ELsBhIh8GwLvPjIVmxcAKJIBzXxBcHqwIlHYlFcV5DKWz+iqpaaU+djwm7R/Oq5k0NWq
 7RptLvFeh0dWA9i+yX3a/oUwQJZTEiHu/9GgyodmtrlqlRC3+i67dplRZFjAHTtiXyR2
 c2lSfZ0GhsH6BlDAq8uDwXDzZA67unYKM0zUMGlS2ritbK9eUAM+qkVZ3EWuNJTE3K4v
 jyiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRRHdsmjn7+UYTYaD7VCciqJzXAWbCpFhBZc8kxAYYDBMfDnR4w8e/QZFZ1UoBgm0N+HFt7Eoya4Wss54+0JxX@lists.sourceforge.net
X-Gm-Message-State: AFuF++kezykwBe6hNKcZW2Nb6kSXueYZrkzw4oPThUbLoTTamaIsSZvT
 MA9fONoz/m70/kcIHd0tMSkPja7RXhaTRrmmifFvMyrOgRhG0nxfeqxr
X-Gm-Gg: AR+sD12J/SKNortedG/PAh+0oixVG2iSneDZeo1xrKklmsl7VfmaA80stDmNZhpfPLf
 EnnUtFubx+bQeOS873E274S7Ap0mau97/BZmluPkhwuFJW1smJqCfSVRWrJA41Pmnk5hXZzyIsP
 2xvJ2AOxSPqkNYRcslV5n+c/rw0t/hQNhYWCRiIb7di18bMpBTPGfWdilydZMbJ5nUWa84sKmP0
 iu8iIxkh6bOnAtBFTZP6Qr/GmWAGdRPKAoyvswNlHYDjoCOHxecy5m1o7uANWrxTLswZ2rbLpJH
 NCQ1BCXKF+25RvyH9O0aMRJnysGfqhVzTw7Ursev/uvgGRgpAU4vG7GiFRFDzNOQ4ZT7F22NfU/
 HI7aXriGAtbuYdo9GLbqajefH0Fzakn17qQ7TjpQ4btZUTSkinT3OodSGQ/6wXrz1z098Eo3trZ
 XayoPyzEvhXzKYMQyzqkE0KmBrW+8kjfY25Eyp3t/plVsGMdCecDoraJbvehguiV0BbDZnlDZz6
 zl0SkCrVsQoDwVLDN60pB/jT05YU35rmqLG4dW+g03LRxR34JunaGLAzHvV+O5scpDAddagM+8p
 jqAokdDQKr/6oUhQshMt6go=
X-Received: by 2002:a17:90b:440e:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3966d161355mr14873945a91.2.1787758609216; 
 Wed, 26 Aug 2026 08:36:49 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:d10e:986a:5a1c:babc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60c2b4sm14703567eec.5.2026.08.26.08.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:36:48 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 26 Aug 2026 08:36:44 -0700
Message-ID: <20260826153644.3726384-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
MIME-Version: 1.0
X-Headers-End: 1wzFgN-0007bN-8d
Subject: [f2fs-dev] [PATCH v2] f2fs: support resizable tail section and
 unify pinned allocation
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

Currently, zoned block devices restrict pinned file allocations to
conventional zones at the beginning of the storage (before
first_seq_zone_segno), triggering range GC when conventional space is
exhausted.

On regular block devices, when preparing for future online filesystem
resizing (e.g. partition shrinking), pinned files must not be allocated
in the tail area that will be truncated, as pinned files cannot be
relocated by GC. Specifying the resizable tail area size (in sections)
allows uniform mount configuration across devices of different storage
capacities.

To support this, introduce a unified `pinned_area_max_secno` boundary
abstraction in `f2fs_sb_info`:
1. Add `-o resizable_tail_secno=%u` mount option to specify the number
   of sections at the tail of the filesystem reserved for resizing.
2. In `f2fs_fill_super()`, initialize `sbi->pinned_area_max_secno` as:
   min(MAIN_SECS(sbi) - resizable_tail_sec, zoned_max_sec).
3. In `get_new_segment()`, restrict segment allocation for pinned files
   (`pinning == true`) to `0 .. sbi->pinned_area_max_secno - 1`. If no
   free section is available in the pinned area, return -EAGAIN.
4. In `f2fs_allocate_pinning_section()`, unify the range GC trigger to
   run `f2fs_gc_range()` up to `sbi->pinned_area_max_secno` whenever
   `sbi->pinned_area_max_secno < MAIN_SECS(sbi)` and allocation
   returns -EAGAIN.
5. Expose `/sys/fs/f2fs/<dev>/pinned_area_max_secno` as a read-only
   sysfs node.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
v2: rename has_pinned_area() to has_unpinned_area().
    merge resizable_tail_secno sanity check into f2fs_sanity_check_options().
    fix missing F2FS_SPEC_resizable_tail_secno in fs_context mount parsing
    and apply logic, reported by Wenjie Qi <qiwenjie@xiaomi.com>.
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++
 Documentation/filesystems/f2fs.rst      |  8 +++++-
 fs/f2fs/f2fs.h                          |  2 ++
 fs/f2fs/segment.c                       | 33 ++++++++++++-----------
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/super.c                         | 36 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         |  2 ++
 7 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 85194e4c7f01..0cebc89799dd 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -1013,3 +1013,10 @@ Description:	Every time a write operation completes f2fs_write_end_io() is
 		the maximum size of a write bio that is completed in atomic
 		(atc) context. The default value for this attribute is UINT_MAX
 		which means that this functionality is disabled by default.
+
+What:		/sys/fs/f2fs/<disk>/pinned_area_max_secno
+Date:		August 2026
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	This is a read-only entry to show the upper bound section number
+		for pinned files. Pinned files will only be allocated within
+		sections 0 to pinned_area_max_secno - 1.
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 1a5fd4afe609..a3c3b6948734 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -417,7 +417,13 @@ lookup_mode=%s		 Control the directory lookup behavior for casefolded
 			     auto               F2FS determines the mode based on the
 					        on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
 					        flag.
-			     ================== ========================================
+resizable_tail_secno=%u  Control the number of sections at the tail of the
+			 filesystem reserved for online resizing. Pinned files
+			 will only be allocated within sections 0 to
+			 (MAIN_SECS - resizable_tail_secno) - 1. If set to 0
+			 (default), there is no tail restriction unless running
+			 on a zoned block device where conventional zones are
+			 used.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0a9c14de595..16720f1f0a9c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -255,6 +255,7 @@ struct f2fs_mount_info {
 	block_t unusable_cap;		/* Amount of space allowed to be
 					 * unusable when disabling checkpoint
 					 */
+	unsigned int resizable_tail_secno;	/* number of resizable tail sections */
 
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
@@ -2005,6 +2006,7 @@ struct f2fs_sb_info {
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
 	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
+	unsigned int pinned_area_max_secno;	/* upper bound section for pinned files */
 	unsigned int bggc_io_aware;		/* For adjust the BG_GC priority when pending IO */
 	unsigned int allocate_section_hint;	/* the boundary position between devices */
 	unsigned int allocate_section_policy;	/* determine the section writing priority */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 56decf9c691c..1e7e745be71d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2877,6 +2877,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
 	unsigned int alloc_policy = sbi->allocate_section_policy;
 	unsigned int alloc_hint = sbi->allocate_section_hint;
+	unsigned int max_secno = MAIN_SECS(sbi);
 	bool init = true;
 	bool looped = false;
 	int i, devi;
@@ -2908,7 +2909,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		/* Prioritize writing to conventional zones */
-		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
+		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV)
 			segno = 0;
 		else
 			segno = max(sbi->first_seq_zone_segno, *newseg);
@@ -2924,19 +2925,24 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		alloc_hint > MAIN_SECS(sbi))
 		alloc_hint = MAIN_SECS(sbi);
 
-	if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
-		hint < alloc_hint)
+	if (pinning) {
+		max_secno = sbi->pinned_area_max_secno;
+		hint = 0;
+	} else if (alloc_policy == ALLOCATE_FORWARD_FROM_HINT &&
+		hint < alloc_hint) {
 		hint = alloc_hint;
-	else if (alloc_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
-			hint >= alloc_hint)
+	} else if (alloc_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
+			hint >= alloc_hint) {
 		hint = 0;
+	}
 
 find_other_zone:
-	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+	secno = find_next_zero_bit(free_i->free_secmap, max_secno, hint);
 
-	if (secno >= MAIN_SECS(sbi)) {
+	if (secno >= max_secno) {
 		if (looped) {
-			ret = -ENOSPC;
+			ret = (pinning && has_unpinned_area(sbi)) ?
+					-EAGAIN : -ENOSPC;
 			f2fs_bug_on(sbi, !pinning);
 			goto out_unlock;
 		}
@@ -3001,12 +3007,6 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		goto out_unlock;
 	}
 
-	/* no free section in conventional device or conventional zone */
-	if (new_sec && pinning &&
-		f2fs_is_sequential_zone_area(sbi, START_BLOCK(sbi, segno))) {
-		ret = -EAGAIN;
-		goto out_unlock;
-	}
 	__set_inuse(sbi, segno);
 	*newseg = segno;
 out_unlock:
@@ -3472,8 +3472,9 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 	err = f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
 	f2fs_unlock_op(sbi, &lc);
 
-	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
-		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
+	if (has_unpinned_area(sbi) && err == -EAGAIN && gc_required) {
+		err = f2fs_gc_range(sbi, 0,
+				sbi->pinned_area_max_secno * SEGS_PER_SEC(sbi) - 1,
 				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db1079169a23..5949aa5200ac 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -43,6 +43,7 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 
 #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
 #define MAIN_SECS(sbi)	((sbi)->total_sections)
+#define has_unpinned_area(sbi)	((sbi)->pinned_area_max_secno < MAIN_SECS(sbi))
 
 #define TOTAL_SEGS(sbi)							\
 	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3bdb0f891c35..253a579e9d5b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -235,6 +235,7 @@ enum {
 	Opt_jqfmt,
 	Opt_checkpoint,
 	Opt_lookup_mode,
+	Opt_resizable_tail_secno,
 	Opt_err,
 };
 
@@ -366,6 +367,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
 	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
 	fsparam_enum("lookup_mode", Opt_lookup_mode, f2fs_param_lookup_mode),
+	fsparam_u32("resizable_tail_secno", Opt_resizable_tail_secno),
 	{}
 };
 
@@ -404,6 +406,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_errors			(1 << 23)
 #define F2FS_SPEC_lookup_mode			(1 << 24)
 #define F2FS_SPEC_reserve_node			(1 << 25)
+#define F2FS_SPEC_resizable_tail_secno		(1 << 26)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -551,6 +554,17 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
 			F2FS_OPTION(sbi).unusable_cap_perc);
 }
 
+static inline void adjust_pinned_area_boundary(struct f2fs_sb_info *sbi)
+{
+	sbi->pinned_area_max_secno = MAIN_SECS(sbi);
+	if (f2fs_sb_has_blkzoned(sbi) && sbi->first_seq_zone_segno != NULL_SEGNO)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+				GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno));
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		sbi->pinned_area_max_secno = min(sbi->pinned_area_max_secno,
+				MAIN_SECS(sbi) - F2FS_OPTION(sbi).resizable_tail_secno);
+}
+
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -1235,6 +1249,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
 		break;
+	case Opt_resizable_tail_secno:
+		F2FS_CTX_INFO(ctx).resizable_tail_secno = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_resizable_tail_secno;
+		break;
 	}
 	return 0;
 }
@@ -1763,6 +1781,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
 	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
 		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
+	if (ctx->spec_mask & F2FS_SPEC_resizable_tail_secno)
+		F2FS_OPTION(sbi).resizable_tail_secno =
+					F2FS_CTX_INFO(ctx).resizable_tail_secno;
 
 	f2fs_apply_compression(fc, sb);
 	f2fs_apply_test_dummy_encryption(fc, sb);
@@ -1771,6 +1792,13 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 
 static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi, bool remount)
 {
+	unsigned int total_sections = le32_to_cpu(sbi->raw_super->section_count);
+
+	if (F2FS_OPTION(sbi).resizable_tail_secno >= total_sections) {
+		f2fs_err(sbi, "Option resizable_tail_secno is larger than or equal to total sections (%u >= %u)",
+				F2FS_OPTION(sbi).resizable_tail_secno, total_sections);
+		return -EINVAL;
+	}
 	if (f2fs_sb_has_device_alias(sbi) &&
 	    !test_opt(sbi, READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
@@ -2544,6 +2572,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
 		seq_show_option(seq, "lookup_mode", "auto");
 
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		seq_printf(seq, ",resizable_tail_secno=%u",
+				F2FS_OPTION(sbi).resizable_tail_secno);
+
 	return 0;
 }
 
@@ -2586,6 +2618,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
+	F2FS_OPTION(sbi).resizable_tail_secno = 0;
 
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
@@ -3045,6 +3078,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
+	adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5287,6 +5321,8 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
+	adjust_pinned_area_boundary(sbi);
+
 	sbi->reserved_pin_section = f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi));
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3201e2185fea..811e350a1430 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1313,6 +1313,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
 F2FS_SBI_GENERAL_RW_ATTR(carve_out);
 F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
+F2FS_SBI_GENERAL_RO_ATTR(pinned_area_max_secno);
 F2FS_SBI_GENERAL_RW_ATTR(bggc_io_aware);
 F2FS_SBI_GENERAL_RW_ATTR(max_lock_elapsed_time);
 F2FS_SBI_GENERAL_RW_ATTR(lock_duration_priority);
@@ -1525,6 +1526,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_read_extent_count),
 	ATTR_LIST(carve_out),
 	ATTR_LIST(reserved_pin_section),
+	ATTR_LIST(pinned_area_max_secno),
 	ATTR_LIST(allocate_section_hint),
 	ATTR_LIST(allocate_section_policy),
 	ATTR_LIST(max_lock_elapsed_time),
-- 
2.55.0.860.g4b6b3295ed-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
