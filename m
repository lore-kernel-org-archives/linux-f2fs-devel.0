Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B2DC79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0M3bbiRd+fPUwklbn5yNbxy47I2izHWJtfyrt1C0Jxg=; b=NkQYMJ/5uEuZsrnLeEm+Zn7GpP
	u54O8AcrssV8qH2rTF4cGSp82ehvkialfcNmD+42fAkqQ35djA7/qg8wN0Y99J+gkKRFEUPBxeE3y
	o13VB1zFWPNo4BeepeeroBbH7h+fCFgyzxB2k/avbecQYp7sZeNqmd2G+bkl6EA78y/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4AWD-0002ad-RH;
	Wed, 09 Sep 2026 05:06:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4AWD-0002aV-DJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 05:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ts9hwby3/MRsSLVJ7fCUGIQ98U/Sv6ufELDj6yChuwU=; b=ImrmwN4EC5DExxYpRRmbj1ruHz
 ZDOiTXSQE+oo2pA3lhDbwpyunyP1taiwPF9dkzr+p0+e4qtsWEyV+6bP4PTpdiSj/sxWhVSJ9mEvY
 JaF/v7Cxqo+OihT6ozF272KYiZRwjPbY2/m6f9rfGUqGtumtKX3Dey7ILU56mq9Ovj6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ts9hwby3/MRsSLVJ7fCUGIQ98U/Sv6ufELDj6yChuwU=; b=Z
 Dl+UoTsSTiRM2tOVzHy2TNSwTUTTm84xyKSP6aMuM0oo4F11xibPqScvPYGI48VhkATL2tAZzxt3v
 frlgdh2jND7a7Z8UfNGh0AQezCYoKsHtJzmjxJAOoXUVHFCyVApBChlHa7iwNyG/RVt6mZRZhcvda
 Nyp394c2uex7Tg5E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4AWB-0004zz-EE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 05:06:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE739409FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 05:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F21F00A3A;
 Wed,  9 Sep 2026 05:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788930397;
 bh=Ts9hwby3/MRsSLVJ7fCUGIQ98U/Sv6ufELDj6yChuwU=;
 h=From:To:Cc:Subject:Date;
 b=m43fu7DDlsVcST/u1NZM3X93BEddJ56PWF0jpPqSBBHBYW6SNqjyTKbe5b4MnM+P8
 rLPE4q077L4IAlc6/grgtOxU9kT3f9A0E/3iG61Tfni5oHYBwufO9TkRHKey5ANRQt
 5cD4Lx5NUmGffTIQ76Eq0Hq5p92x4uHkWsZAyaDTIJ8w2MYtLe4gudkoQQyer72v+0
 dNjc1BoPsM4wdzd+cZoy/aVQX0BhkjewxFlicNYnMLlprclVPDLN7+9v0P3TjQIQQ7
 k6z5/Q6ft5wrBat+8A8Ay+/eIo35DSqknbJzR+2L2R00s878z2PLEdeW9TYAxHG2zg
 ohJ5tuZUG7Q2w==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 13:06:34 +0800
Message-ID: <20260909050634.3513267-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
X-Headers-End: 1x4AWB-0004zz-EE
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix to avoid selecting current
 section in find_next_free_block
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

In find_next_free_block(), when searching for a free block or allocating a
new section, it checks:

	if (!(get_sb(feature) & F2FS_FEATURE_RO) &&
					IS_CUR_SEGNO(sbi, segno))
		goto next_segment;

However, when large section is enabled (segs_per_sec > 1), checking only
IS_CUR_SEGNO(sbi, segno) is insufficient. If segment 0 of a section is
empty, but segment 1 is an active curseg (e.g. CURSEG_WARM_NODE),
IS_CUR_SEGNO(sbi, segno) evaluates to false.

Consequently, find_next_free_block() can treat the section as completely
free and call set_section_type(sbi, segno, want_type). This overwrites the
segment type of all segments in the section, clobbering active curseg
segments (e.g. from NODE to DATA) and leading to an assertion crash in
update_data_blkaddr():

  [update_data_blkaddr:2527] NAT and SIT is inconsistent: ino: 4, nid: 23, blkaddr: 21925780, segtype: 1
  [ASSERT] (update_data_blkaddr:2529) 0

Fix this by using IS_CUR_SECNO(sbi, GET_SEC_FROM_SEG(sbi, segno)) to ensure
that any segment belonging to an active current section is skipped.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a202f3d..2fd8e1c 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3149,7 +3149,7 @@ next_segment:
 			continue;
 		}
 		if (!(get_sb(feature) & F2FS_FEATURE_RO) &&
-						IS_CUR_SEGNO(sbi, segno))
+			IS_CUR_SECNO(sbi, GET_SEC_FROM_SEG(sbi, segno)))
 			goto next_segment;
 		if (vblocks == 0 && not_enough)
 			goto next_segment;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
