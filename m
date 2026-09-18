Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73795C982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BbuA7FGoQeZHNZ1MZdpoIbbfXf0ChP09CzcI11oSFRI=; b=fonsdXrWOBESQ6QAsHfdphnX2M
	+Ww9DA6GZgBDuvjqPxMK+xzPJ87Xt2e+tIwDHE9/bf84xkhyu9jch09g31GtS5doqk11TYvRVRgpB
	ArgMszuTJp8Dn/EMSFldtklbeuQLhAu7a2XxaCL4a3v1/7uGe6P1Dw8dp/EWEm14z4xU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7bs8-00014K-Vf;
	Fri, 18 Sep 2026 16:55:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kaixuanli0131@gmail.com>) id 1x7bs6-00014C-7u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:55:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EjJplJ4znQm9GNj31Qhyhiop9ZBBKbv4OXShDDwM5fk=; b=bhA0fj1qwxJC/0RbsTcARMWHdD
 aEBUNH/qd2iZKTyCl7qxvgkw9RZr/kfXZHmSHStFtJv1/B0YAuilphULXA/e0kJ2BOIXUuZgSleCL
 xnYeZCwcOV+wajJrVF4tF02vv7/7mciAOv3HWajmJjqWnOAKQY6x47iERdxMwBFdYiWc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EjJplJ4znQm9GNj31Qhyhiop9ZBBKbv4OXShDDwM5fk=; b=W
 hsbONArVuW3JtMT+AYPrFWfX4RGGKZt7++N9qUJMeE5YAywTS9tuLlU/PIRDWwkx0G7VVZC0wcdi/
 kuAO7yIu2AzO4eQepCtayafcZB0qKDbFE/kHAkuuRDecjBoUTWaNVgbhf+6LVN7p+tSu3NEbxtz33
 K72WMFWrX07WQseQ=;
Received: from mail-pj2-f13.google.com ([74.125.227.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7bs6-0007gs-FC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 16:55:34 +0000
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eefae4so2874235ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789750529; x=1790355329; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EjJplJ4znQm9GNj31Qhyhiop9ZBBKbv4OXShDDwM5fk=;
 b=CGwjsB3zIStlKiXCkQYr29Kyz64oCC5WP+dqaO28XUXvZcGvaUajjOvbkO5/tdM0rz
 CRAypZHPURT/j6EsurxQqoCVN4AVoSeKeNfF/RGQHWd/ZpOd8hvyJJJRCQ2Ve/QLqq7J
 BAXxtyvRe7SvOqOwxzBEVxfDdrzY9QmjBFwv9l70d3sUGReQiG4WelApCBuRtMnUb3q+
 /8POhHqsmybZkNLIB2mJvHpDqRRp5GqcxpiTbeV1uMc/Yyp7z4klB/93g1mdDO03UJT3
 zVhZ8J1peHyggn2HtxFZvaQUswY5bD1nYL2I6TTFi9BV7dfiOzJcDoiGlb65yVdt4+x/
 IglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789750529; x=1790355329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EjJplJ4znQm9GNj31Qhyhiop9ZBBKbv4OXShDDwM5fk=;
 b=caU1f+T3hAPt5rLgHZPT1j+TMu/q5ICwxtqWyFdehHds+lT4t6WieDESAm8MiKEw7/
 ykea1Gr+B47UXBQxFPNS5ZBAM1vwtWEJ1+aLEEeMTtWEhi8UuLDmIv4g0fO+3Mt9S4MF
 fd0SQnWh9pF2ZUbp9hBy8WqjVzbRYoWc0gC320PXivHjLo9U0o9RFOxqfMiP+Y+RgBFm
 NDvrhwjpbuEnH9QOC2Ca3LWHl9UdyEGTOPsQJM6H6t42wON5qaiyKKL32dM4sQ1WGwOj
 fDLBpMllal7U8JDpKTtsYCCT/SlN2effTKtABRVf+duQEmETynxTO2UBsb5GDv6oESq+
 Q2vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh+6FnpoaDQ82tslzZxETz4nC4v+t2IbAux05oI2c9nfTOgrRVf/jYgo9cMpFQMFiUIEgpo/exXwOU4w6oBVBO@lists.sourceforge.net
X-Gm-Message-State: AFuF++mdMVrCq9N8kJVludaQ233ICQ1btJN41Tyfgn3qug1RN0tPl5Po
 L30Dl0MhpiXMKc4TN+UZNG33rs5Z5dQHc7fyf8K1yvtNsbOofeHi4Xlp
X-Gm-Gg: AYBFou2xjf8SX3T43gDBm4xpdV/IZ64ny/e8Vih/sHgP/AjNxUqdemGrYPrEtj9hyiW
 bVwBNGdEY7eh53fYENfoPWgAk8U5ChhzC8PJsU3OC4ERaNL0jtEBvgLjUCGqkbxHmwPIW4ukC8s
 /A00d1pOFl+90TvHqE5Ij6i4KXpI0uqZ31deLDPbIHMm8k8Eon5NLiVY+L2P8+94GEzbHhvxJfd
 YMbghpfLDgNMFejQqvy+0/1DtDFiboWZt5j4R2oeHZ0utzpY3AascHYk9M08ThX3y3ODu7tLtLP
 CivAwIwnGRgdsem7YrmV08mgYx84ORRzcpPqRu7iUOeAAfasK4MrsBMt8p4r1+U0qFGgaCHKyMw
 oR09aG5/+Q6hPQlI6ZR9BmPJu/gzW9MNJIHI1buUHQpRF0WlQIUexhuDhjrbKwMLpzmLCFRhOfb
 Od35szDLN6xVFXczbOTXa+sjHihVlrwR7KSk1gmtOddboW1TGSbVPF02iWl8TxKB38mh2iEhzDN
 TCeH9pW8u1MoPaImOMPFI3k8Q==
X-Received: by 2002:a17:902:e742:b0:2dd:c053:b9c5 with SMTP id
 d9443c01a7336-2ddc053ba23mr5666215ad.22.1789750528462; 
 Fri, 18 Sep 2026 09:55:28 -0700 (PDT)
Received: from csl-conti-dell7859.ntu.edu.sg ([155.69.199.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b6552sm11568185ad.61.2026.09.18.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 09:55:28 -0700 (PDT)
From: Kaixuan Li <kaixuanli0131@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sat, 19 Sep 2026 00:55:07 +0800
Message-Id: <20260918165507.1267942-1-kaixuanli0131@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1x7bs6-0007gs-FC
Subject: [f2fs-dev] [PATCH] f2fs: check every cur_*_segno[] entry on
 readonly images
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
Cc: Kaixuan Li <kaixuanli0131@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

sanity_check_ckpt() bounds-checks cur_node_segno[] and cur_data_segno[]
against main_segs, but on an image with the RO feature the goto that skips
the duplicate-segno cross-checks also leaves the enclosing loop, so only
index 0 of each array is ever checked.

An unchecked index reaches __set_sit_entry_type() through build_curseg() ->
reset_curseg(), which writes se->type through &sit_i->sentries[segno]. With
segment_count_main 120 and cur_data_segno[1] set to 200, KASAN reports
three out-of-bounds writes during mount and the mount then succeeds.

Use continue so every index is bounds-checked, and skip the node-vs-data
cross-check explicitly, which is the other thing the old goto skipped.

Fixes: a7d9fe3c3388 ("f2fs: support RO feature")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
---
Found on v7.2.4; the code is unchanged in mainline at commit
5dd1818b15d98d4a20806cd00b1b40320b06004f.

Before the patch, mounting such an image on v7.2.4 with KASAN:

	BUG: KASAN: slab-out-of-bounds in reset_curseg+0x48a/0x530
	Write of size 4 at addr ffff888009f8df40 by task init/1
	 reset_curseg+0x48a/0x530
	 f2fs_build_segment_manager+0x1f65/0x8de0
	 f2fs_fill_super+0x4348/0x7a10
	 vfs_get_tree+0x83/0x2f0
	 path_mount+0x570/0x1fb0
	The buggy address is located 3200 bytes to the right of
	 allocated 4800-byte region [ffff888009f8c000, ffff888009f8d2c0)

The 4800-byte region is sentries[], 120 entries. Two further writes of
size 8 follow at f2fs_build_segment_manager+0x479f and +0x480e, so
__set_sit_entry_type() is not the only sink the unchecked value reaches.
The mount completes afterwards, so nothing surfaces the corruption.

Reproducer: mkfs.f2fs on a 256 MB image gives segment_count_main = 120.
Then, in both superblock copies (offset 1024 and 1024 + F2FS_BLKSIZE) and
both checkpoint packs, set F2FS_FEATURE_RO (0x4000) in the feature word and
set cur_data_segno[1] and cur_node_segno[1] to 200; recompute each pack's
crc32 over checksum_offset bytes seeded with F2FS_SUPER_MAGIC and store it
at checksum_offset. Mount read-only. Scripts available on request.

Tested on v7.2.4 x86_64 with KASAN, three cases:

  - crafted image as above: rejected at checkpoint validation, no KASAN
    report (before the patch: three reports, and the mount succeeded);
  - plain mkfs.f2fs image: still mounts;
  - RO feature set with valid segnos: still mounts, which is why the
    node-vs-data cross-check is skipped explicitly rather than by letting
    the loop fall through to it.

fs/f2fs/super.c builds warning-free and checkpatch is clean apart from
"Unknown commit id" for the Fixes: tag, which is an artefact of the tree I
built in rather than the tag.
---
 fs/f2fs/super.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4239,7 +4239,7 @@
 			return 1;
 
 		if (f2fs_sb_has_readonly(sbi))
-			goto check_data;
+			continue;
 
 		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
@@ -4251,14 +4251,14 @@
 			}
 		}
 	}
-check_data:
+
 	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
 		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
 			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
 			return 1;
 
 		if (f2fs_sb_has_readonly(sbi))
-			goto skip_cross;
+			continue;
 
 		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
@@ -4270,6 +4270,9 @@
 			}
 		}
 	}
+	if (f2fs_sb_has_readonly(sbi))
+		goto skip_cross;
+
 	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
 		for (j = 0; j < NR_CURSEG_DATA_TYPE; j++) {
 			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
