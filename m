Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E51C83F26
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jul 2025 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HuB5W1OTnjBoni34EBvEjKWcuUBwqCPWlNP9lNu/nrE=; b=RlmR2Kb5OG7HcZybWDpL8v4zbX
	oq4sNZbHC5/OZSlRM4TdebYFp+Qd/vTYk+GKfLDgVmOIjEgTkeCGRIAB79Qr4GmoGU0RzUoUJNnsN
	DcDW+B7K08Nn0povN9TsEwf5jfCY/0mKlBfgyp04hBGR3J2DSnnC+UAIfC3ZaGD/pkPs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ugQqJ-0008Mw-Qq;
	Mon, 28 Jul 2025 16:36:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ugQqJ-0008Mp-5r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 16:36:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=; b=K/kvvBi6U5qFNne8gsYLfuhqn6
 eBNh+OxcRxn8FMr/uTJVSn6j5SS6bKWVomypGhxpmpY72SSPLH2AMbWdP60+lepQ3nYdG5YRmGtI+
 EfHpQkf5//Vlw0FqE/ZGxRDEd3dTEQ/ScG8AGXrahz5zwXiJ53Npd6Fe9ZJxcoEm3/fY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=; b=c
 TXI+Z/cohVtn9y4gxj66zcxmnmfCAD4cd75y3/0ojmFMZygQtwbeLR7iwfrscKGYyBvG/V7VyfPCd
 2CL2VCpKU//lbmkswfejskUeZ9b5CaLLVt3xqPyc7z0SWMgRSISz73klyX9XirIEq9CaW+criPka2
 8xARxoWacJjRkdPA=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ugQqI-0007Rp-Mi for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 16:36:51 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so18652165ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jul 2025 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753720600; x=1754325400; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=;
 b=OqhntLzvfxgCvYV+wnLPT5TAVUiOe04fXdgPcq1Tav9A7RIpgHr+UGHEaZmgZ7QeTT
 w94pSIHTLWAb6ZgryAOjQqEWy4i4ov9Ld4hdVLBuHlei8SqdnBR8q1xZG+l/v0f9rzNk
 ZbUHzVN5CvG2AOS07hOxtyK75UT4SufYOGkxkd6FXnXVrO8NzehuBWEqNtd2H0SUXdI0
 dcd2CF+XjbE57DUpYkJeaJ74hKOTnfnAdMwWGWt1sPv9j+dVqGIjG7yEAt13tHxtFwUu
 stejluNA+JmIkWyd4n2aYLN+S+T/GuH9ubVnUFWIRg3DWa2hijbVXPPE+HISo6l96jOY
 BgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753720600; x=1754325400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=;
 b=pQeAholvkhgqm9CKlAQSJhraDBA3XL20Dzusj1YcGQWZmHomWty6HHusXDCuWYJicX
 pwB63d50d5ukeiTGQkJQVamzO0h6iz+RzlKavaHDDlA6FFMHA7nC7mjTXsxSytN0Lxk7
 ErHVSp+uv6Yo7yYtXXpJjtA3MXsw1N/QFJ2FjIBNcvuD5qwB8mgHXTIxNjOwIdsROFkk
 DGoslQ0qHQ/RZ8DCrCR/pW6M+U9KqnCogGMDOYAmWItAGuGKH3cJWbJmvkzwqrHyXa7l
 Wex2FBj04gLlFB//z2EbWyz/oUE80EOBwE/De/FFrFrNoZOSFUcgBrjaeXwVZ9gBzgc1
 B74w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHIr46Ek1W9R4k5D8jGYWg4jtZfbBxJOtM24PnzEBwid5XrIceOWEldIpEprRTcrxPs1OPCrgdXfHDqevtZUlw@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVu7SVq4XvJ7O1+VaIQk1rWHDztdwHubW+PrgyzVdCC/nQ/xFf
 N4UlTjD5tEzA0KnKGabknHaNkK3/bkqMRMQdZRbqN46n0zutpCabkMFLyv639w==
X-Gm-Gg: ASbGncuIUxg3QA6KpAp2sKa6RnP42BFc55mxcIPeprcVoLB9XzWPy1oVfT+9CPS05ih
 5aHNlXOa0xUV8FJ0eYwC0MbVny+dcJ8uWvyukHtYIG+/wYfGT4ycl9utPrV99SPYstJ/L4C8Ge2
 HDAuLy5KVFd4aZXQszw2wmDNOJ+CYhwsG3Ia5sygDELJ6qw4cOwfqzVg5n1pRPab8ESC+5DSeIU
 btYER1h5dlj1YVfRFE/ET+fJGYnUiyugn4xjW6hthhQ2QW1xG72DeIvOD5anGw1+CHqWtazAXlp
 drqbsBsi99dLDmdUKfgUglgO1IGfIONR/yn7xIUlQZcgc0iE3xC2CyEiT2wyeDshan6aHwt9/pq
 nTKF3zeBtnQg+2fgmria+4pBtu1XtVJ8xvrcDZpSVfxtd+3dhIpssct279gd0UrrotwXAT6P933
 7WHLATKLHfkyAt8g==
X-Google-Smtp-Source: AGHT+IEGAK3rQGPwuT5QeRAnpVEGq68xpiS2AvCZbpQqKo2cPrxtkwp+3EiiPpbFDALSAHI80JOEhw==
X-Received: by 2002:a17:903:2451:b0:235:f70:fd39 with SMTP id
 d9443c01a7336-23fb2fd7c27mr210492365ad.10.1753720599819; 
 Mon, 28 Jul 2025 09:36:39 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:b166:cd51:360c:c503])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24008d8e9a2sm35086995ad.142.2025.07.28.09.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 09:36:39 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 28 Jul 2025 09:36:28 -0700
Message-ID: <20250728163628.1043162-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
MIME-Version: 1.0
X-Headers-End: 1ugQqI-0007Rp-Mi
Subject: [f2fs-dev] [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
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

Add a sysfs knob to set a multiplier for the background GC migration
window when F2FS Garbage Collection is boosted.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: fix the range check condition
v2: limit the available value range
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bf03263b9f46..931c1f63aa2e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -861,3 +861,11 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
 		SB_ENC_STRICT_MODE_FL            0x00000001
 		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
 		============================     ==========
+
+What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
+Date:		June 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Set a multiplier for the background GC migration window when F2FS GC is
+		boosted.
+		Default: 5
+
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3cb5242f4ddf..de7e59bc0906 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -197,6 +197,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
+	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
@@ -1749,7 +1750,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					!has_enough_free_blocks(sbi,
 					sbi->gc_thread->boost_zoned_gc_percent))
 				window_granularity *=
-					BOOST_GC_MULTIPLE;
+					sbi->gc_thread->boost_gc_multiple;
 
 			end_segno = start_segno + window_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 5c1eaf55e127..efa1968810a0 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -68,6 +68,7 @@ struct f2fs_gc_kthread {
 	unsigned int no_zoned_gc_percent;
 	unsigned int boost_zoned_gc_percent;
 	unsigned int valid_thresh_ratio;
+	unsigned int boost_gc_multiple;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 75134d69a0bd..b417b655d4e8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -824,6 +824,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
+		if (t < 1 || t > SEGS_PER_SEC(sbi))
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1050,6 +1057,7 @@ GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
+GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1220,6 +1228,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_zoned_gc_percent),
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
+	ATTR_LIST(gc_boost_gc_multiple),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.1.470.g6ba607880d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
