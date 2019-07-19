Return-Path: <SRS0=QVvM=VQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F68C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jul 2019 03:58:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4F4218A6;
	Fri, 19 Jul 2019 03:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cHxOaBNo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="kt8KvBBn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lddfjHPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4F4218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hoK2O-0002SI-Ul; Fri, 19 Jul 2019 03:58:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hoK2N-0002SB-7h
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 03:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fMYWYLjBjieIfnwHagYw7+DPi7NIhE7i586MZP0E6BI=; b=cHxOaBNo+e2lG4cheh00XdhuIZ
 XeZjU5MCVCNGaauLTBsi+JgN12KaLZOGxwacR/TsVkF5JVWXba2qyGPk3ltAv4lpasFLvgD5F/RBG
 qKVZCm+UqlBwBI6MelSd5heqrj+sMKk0PpHv88HcxNRPHkSH3xKFSfUHII284FNuwWSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fMYWYLjBjieIfnwHagYw7+DPi7NIhE7i586MZP0E6BI=; b=kt8KvBBnO4nuyK3YyX/OCdDB/I
 ucYvFPcerLh2vUCXwT9xt+vkYZ46zvEJnALSpxFR7dMmiSfGhXdgxRYugsl1KQlzmQCgKr4IsdBbc
 FR2SiaJLYyo+1ZZvN0Wly7BHSzjQ/JCDQCOa8c148ukX+BLY+N0w7isoWaQb72mtK5H0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hoK2M-006z2Y-1X
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 03:58:27 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B08621851;
 Fri, 19 Jul 2019 03:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563508700;
 bh=aJRvDu9YvM33JggDAoN3fy/XtFIU7MiopLHT5SlzMcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lddfjHPDE2LR9VYNgI2X3oHkz4vTs/Vdb6OQVYRZALdOdeZ9BFbY1584f/eVro4R/
 jrbnYtzq2GEf2GKOuMM17z5KVvuLyfvjd3No94wzVTRvT3+i4yVAiRvsED/LaThZ77
 8YvUIULfTGwJ/RSftF3guV1z8v9ww732dA1o9dX8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 18 Jul 2019 23:54:30 -0400
Message-Id: <20190719035643.14300-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1hoK2M-006z2Y-1X
Subject: [f2fs-dev] [PATCH AUTOSEL 5.2 039/171] f2fs: Lower threshold for
 disable_cp_again
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daniel Rosenberg <drosen@google.com>

[ Upstream commit ae4ad7ea09d32ff1b6fb908ff12f8c1bd5241b29 ]

The existing threshold for allowable holes at checkpoint=disable time is
too high. The OVP space contains reserved segments, which are always in
the form of free segments. These must be subtracted from the OVP value.

The current threshold is meant to be the maximum value of holes of a
single type we can have and still guarantee that we can fill the disk
without failing to find space for a block of a given type.

If the disk is full, ignoring current reserved, which only helps us,
the amount of unused blocks is equal to the OVP area. Of that, there
are reserved segments, which must be free segments, and the rest of the
ovp area, which can come from either free segments or holes. The maximum
possible amount of holes is OVP-reserved.

Now, consider the disk when mounting with checkpoint=disable.
We must be able to fill all available free space with either data or
node blocks. When we start with checkpoint=disable, holes are locked to
their current type. Say we have H of one type of hole, and H+X of the
other. We can fill H of that space with arbitrary typed blocks via SSR.
For the remaining H+X blocks, we may not have any of a given block type
left at all. For instance, if we were to fill the disk entirely with
blocks of the type with fewer holes, the H+X blocks of the opposite type
would not be used. If H+X > OVP-reserved, there would be more holes than
could possibly exist, and we would have failed to find a suitable block
earlier on, leading to a crash in update_sit_entry.

If H+X <= OVP-reserved, then the holes end up effectively masked by the OVP
region in this case.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a96b9e964733..8903b61457e7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -876,7 +876,9 @@ void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi)
 int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	block_t ovp = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
+	int ovp_hole_segs =
+		(overprovision_segments(sbi) - reserved_segments(sbi));
+	block_t ovp_holes = ovp_hole_segs << sbi->log_blocks_per_seg;
 	block_t holes[2] = {0, 0};	/* DATA and NODE */
 	struct seg_entry *se;
 	unsigned int segno;
@@ -891,10 +893,10 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-	if (holes[DATA] > ovp || holes[NODE] > ovp)
+	if (holes[DATA] > ovp_holes || holes[NODE] > ovp_holes)
 		return -EAGAIN;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
-		dirty_segments(sbi) > overprovision_segments(sbi))
+		dirty_segments(sbi) > ovp_hole_segs)
 		return -EAGAIN;
 	return 0;
 }
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
