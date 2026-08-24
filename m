Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2971BC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sIjEczSHKuk2aJ5d2ZwLNuPQEgo4/Kf3/6ReVZsgvVI=; b=lr/F1kjGrHYEK/MFq3iaIObjeR
	xVMbWczd+DkpKBM9R9bBw2oa+xRDsFNlhFEuZHd7kUFfrHxgti9tl25D8yGiCXAx9oJ+8xUEaoA5p
	prXeG8qPlnGwXE/p9ped8tw6sMgxQB5xMsL5CHeviQ8uD5666MDeAcy0GN4jZ8LIor0M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wya7e-0006e9-JG;
	Mon, 24 Aug 2026 19:14:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wya7d-0006e1-EN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 19:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HwEmGpNnubULZ/Imu8B0ivaUrl++1sf5ko/a4GxI6c=; b=ED6mrFDwWnvROl06q44chySIzH
 uHHlnFVe3YwJ4P5htAPJ0a9Jb2FoV87+07HARxY1gSEnuC0CeBjdwFjDV6iKePTTXei3MN978BmDx
 8cZgu1hbyYR0sZdXZQIlcLfRfbPwNb9wEuKztsr29RrAtBBsCyEt4yXkH+dzo6mRlITg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0HwEmGpNnubULZ/Imu8B0ivaUrl++1sf5ko/a4GxI6c=; b=M
 KuVZHI3Y+gddJAD7CYrTPXrL5YxyiqIKqiKYaua9jgyuz0tH8n+U/Ya9+mAq52oBCaIX94dFzcb2m
 YODa6sLowS8eflhrHCULcGW63junClJXIqrsw9bI5gDdx02I5FQWti3xMCslpIT/wCrtmOTY+wfm9
 8tJK0DFw2+IG7ovc=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wya7b-0000aO-Sm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 19:14:17 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so4154799a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787598850; x=1788203650; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0HwEmGpNnubULZ/Imu8B0ivaUrl++1sf5ko/a4GxI6c=;
 b=ic9naQ3bmloIM6dW4ltK6iD9pSfCjteSJnHe/o4QIjOnC8X8Z/mTV8GpvC+piWJw4L
 fwO7n9cJzCGyZnmXWNAJsOzA4SaEvg41Zldr9gFqORbrBgKQDuMWrhiGK/1PjdM4uCMa
 zyo1aKepSN1XCkjJbzaBUJ7dcWvzMVQ5dqk+we9UwSro7FRYU6387VniWNfaUmZHKqk9
 zBFKGjTd2PT/v1zMh+Uo5hqfVmxKT4T5+bT+fibHLy/BajAmVceay/H83vqasv7BRB8p
 UHgE4tBiEfZ+bTU13VOLygcWpKwvyWy/D0Pv9DCZisXmWquknmpA2xuWjeCJ3SbElR9z
 lYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787598850; x=1788203650;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0HwEmGpNnubULZ/Imu8B0ivaUrl++1sf5ko/a4GxI6c=;
 b=O38IcQXFPs4vI1saCN/+IID+UYXfNBE7fSLBF5V+4eW5C46E6U793RHZgOfIB5o/kH
 M+D8A7rYFkUWFYqpKsoyi1RN/ZMzhnnRf85x6K8nS4hPX0G5itrzeT+mpECfglnr51Do
 6RdZ5X2fHpbw7DElG9cRM6SDmlV2fW02PmvWfu0t/rOHdEgT3hGcmicuwaUxm6yJfqBc
 hp9zfRPY+JnM/ZL/1OTuhcHH46c36lWrmnKBN5ZhAfHiNPKQ7cY7Rnh2TY6MyXfuJPZa
 Dhv9OMQv8aUZW2wGC5smpKrDEOJamGqDTwe12vrbY+DPFz6sgivYbH2galvt3UADn8Rf
 MCqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjwsenpFPOo2/YxfUjzkwsVs+O1dvZ8061gVWWoPzaUqMJEw7Vkyvivc4Vufn5ncaXvWvHEwItbX7Th9ZnbwV3@lists.sourceforge.net
X-Gm-Message-State: AFuF++mY1u8VyF9ido6DUfpX4VHyCM4IuMYQpoOVCRddTrhhcT9k+kp2
 5EgDFY8YN3B4spt4q0peh7/UZ2r2N8rBLC/diWATXRKoynsWhW4ozIr5EDrXMjik
X-Gm-Gg: AR+sD12Q2Xp39rOvcnxNJWy91E3uJ0z3w0YS6ziOjMrD6ZrgS4wg9Rv6X7K0LhsQw9q
 0QRyDzAd471uGWHcGJ5hZU75u8w2LTFVaxeiaheyUE2UWZ7IsmRHswK9Sk8dKEjq7GMDnSMVmdG
 twHpXlQ+4ZnBiuXJoYFMrNpraZIOSBVSoJKyXaW1znSxaQU4Ub6U1n+RcOEQPwNfdCmeBKb6wXL
 R77NgKqemsV4pu3bn5gCihsXi0gy7sUHEoxgmQgHiwvbxgAmFenSgywOSqp7QN5Eh4lHIVEW/4h
 baZhCtJgEssN3nua1ff2qBOcbrapr67fAroBu8PE+gjlVtvUnpPqjUyzHwIhwCdK/jEAlPSHgfK
 frhrtiWTVJa0ir4HX2PYWQhLbovp5vgI7FW1W7fMH5QkD9tajCwLn5EQZ2VjJhfmD0mLI4B+FzP
 NJf0IwOjxIajBBWtTHPagUyKhXybOEqRfwMahtgWY6G1KqA9Ch4L0at1HOu1ovQ0RYAPfPGO+o9
 Z5NUUt/vPX8nlSL6i3vTJfC9z2y4Zakb3dIAApyipGdEmkx6g6JvXUUfjU2PiFWKSwRFEHDVjTc
 rXiFtzEoFeaq
X-Received: by 2002:a17:90b:3811:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-395df24f20cmr35413670a91.10.1787598849834; 
 Mon, 24 Aug 2026 12:14:09 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:c953:f8f9:5ea5:a893])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32801d7f812sm25813698eec.1.2026.08.24.12.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:14:08 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 24 Aug 2026 12:14:04 -0700
Message-ID: <20260824191404.2558269-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
MIME-Version: 1.0
X-Headers-End: 1wya7b-0000aO-Sm
Subject: [f2fs-dev] [PATCH] f2fs: support resizable tail section and unify
 pinned allocation
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
index 56decf9c691c..ed6f2947210b 100644
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
+			ret = (pinning && has_pinned_area(sbi)) ?
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
+	if (has_pinned_area(sbi) && err == -EAGAIN && gc_required) {
+		err = f2fs_gc_range(sbi, 0,
+				sbi->pinned_area_max_secno * SEGS_PER_SEC(sbi) - 1,
 				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db1079169a23..1dd8a2fa929d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -43,6 +43,7 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 
 #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
 #define MAIN_SECS(sbi)	((sbi)->total_sections)
+#define has_pinned_area(sbi)	((sbi)->pinned_area_max_secno < MAIN_SECS(sbi))
 
 #define TOTAL_SEGS(sbi)							\
 	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3bdb0f891c35..c1e315282ec6 100644
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
 
@@ -551,6 +553,17 @@ static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
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
@@ -1235,6 +1248,9 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
 		break;
+	case Opt_resizable_tail_secno:
+		F2FS_CTX_INFO(ctx).resizable_tail_secno = result.uint_32;
+		break;
 	}
 	return 0;
 }
@@ -1771,6 +1787,12 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 
 static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi, bool remount)
 {
+	if (remount &&
+	    F2FS_OPTION(sbi).resizable_tail_secno >= MAIN_SECS(sbi)) {
+		f2fs_err(sbi, "Option resizable_tail_secno is larger than or equal to total sections (%u >= %u)",
+				F2FS_OPTION(sbi).resizable_tail_secno, MAIN_SECS(sbi));
+		return -EINVAL;
+	}
 	if (f2fs_sb_has_device_alias(sbi) &&
 	    !test_opt(sbi, READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
@@ -2544,6 +2566,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
 		seq_show_option(seq, "lookup_mode", "auto");
 
+	if (F2FS_OPTION(sbi).resizable_tail_secno)
+		seq_printf(seq, ",resizable_tail_secno=%u",
+				F2FS_OPTION(sbi).resizable_tail_secno);
+
 	return 0;
 }
 
@@ -2586,6 +2612,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
 	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_CONTINUE;
+	F2FS_OPTION(sbi).resizable_tail_secno = 0;
 
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
@@ -3045,6 +3072,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
+	adjust_pinned_area_boundary(sbi);
 	limit_reserve_root(sbi);
 	fc->sb_flags = (flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 
@@ -5287,6 +5315,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* get segno of first zoned block device */
 	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
 
+	if (F2FS_OPTION(sbi).resizable_tail_secno >= MAIN_SECS(sbi)) {
+		f2fs_err(sbi, "Option resizable_tail_secno is larger than or equal to total sections (%u >= %u)",
+				F2FS_OPTION(sbi).resizable_tail_secno, MAIN_SECS(sbi));
+		err = -EINVAL;
+		goto free_nm;
+	}
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
