Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF20D2FFE0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:02:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1joE-000878-L2;
	Fri, 18 Oct 2024 10:02:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t1joD-000870-Ci
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 10:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=04lJBhgGLkTojMhFdUoeLrEqka/ettsx8YKuK0x/x28=; b=SBonUacC0OXmJU+xzjbNoAfXwD
 YCMtWQwepqsu68GYo7w5hPcWEgtbwaWK2neLmrbcLjQ1/36Ml9xUu9EdjKs5ysgTPFT5BUQfRpLrL
 Bpu736ixxPCVTz77OBLQ26StRJrHVQJcgK73N1w7HPED4nEyG4ZiE9ZcKH6x4uAbVVWA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=04lJBhgGLkTojMhFdUoeLrEqka/ettsx8YKuK0x/x28=; b=J
 oXpy5fSg4PDY+fItA+rtqTN5yd/aOUgbFKdFjG6TjeVd8VpIlsDSnC524po054kAcNP9ZrEiGhbFr
 5ktbunlU9hxW8nx6F4rHpCRgSooQlSvco4MLyDdz10C4BGVPw0qZUDAZuNEN/HS2L9S0lsVS+8lL3
 +L1HCJIFvOCUAAec=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1joB-0005KL-Vx for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 10:02:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3F1A7A431EF;
 Fri, 18 Oct 2024 10:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E6C4CEC3;
 Fri, 18 Oct 2024 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729245721;
 bh=c95i7yQ7yvMxmF9U7mJUoxODymNVPbilqum2Qcc3rII=;
 h=From:To:Cc:Subject:Date:From;
 b=RH2EWPAE9cL7/kwE7/Kfm6Y/IhDxlxqTorp7dqmS937GwQmXH5DkJWB8wI/FTlShx
 PsMCDYFG+xMAbSUmUh/97FmXycbi3V3fYf2T60Apsclk+f+catDhbxyoijKtGoFib2
 FhFglyLy+xrGhVHssLWKhC2H4IuWhLFAUNTNoOF1TYibJD7CU29hyIFJRDLXLa7gMX
 yD1Epk4CKUHh4Em4PhH3dKXgkCabk9SYhrEgpQLZU3cgURPRKO06Tt1XmfNgKMmRLy
 q4LyLmrn3lpL0QPbyQui9QE6FB+GriciKX63cW3N3VZW3JCh6uSFNr8w6ZOVwPLXVH
 g1+MwAnJXpqfA==
To: jaegeuk@kernel.org
Date: Fri, 18 Oct 2024 18:01:50 +0800
Message-Id: <20241018100150.2852132-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t1joB-0005KL-Vx
Subject: [f2fs-dev] [PATCH RFC] f2fs: revalidate empty segment when
 checkpoint is disabled
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
Cc: Qi Han <hanqi@vivo.com>, linux-kernel@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If checkpoint is off, let's set segment as free once all newly
written datas were removed, it fixes below case:

dd if=/dev/zero of=f2fs.img bs=1M count=64
mkfs.f2fs -f f2fs.img
mount -o checkpoint=disable:10% f2fs.img mnt
dd if=/dev/zero of=mnt/file bs=1M count=19
sync
rm mnt/file
dd if=/dev/zero of=mnt/file bs=1M count=9
dd: error writing 'mnt/file': No space left on device

Cc: Daniel Rosenberg <drosen@google.com>
Reported-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e172b3d0aec3..4f480bfc9618 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -849,6 +849,17 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	valid_blocks = get_valid_blocks(sbi, segno, false);
 	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno, false);
 
+	/*
+	 * If checkpoint is off, let's set segment as free once all newly
+	 * written datas were removed.
+	 */
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+		valid_blocks == 0 && ckpt_valid_blocks == 0) {
+		__remove_dirty_segment(sbi, segno, DIRTY);
+		__set_test_and_free(sbi, segno, false);
+		goto out_lock;
+	}
+
 	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
 		ckpt_valid_blocks == usable_blocks)) {
 		__locate_dirty_segment(sbi, segno, PRE);
@@ -859,7 +870,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 		/* Recovery routine with SSR needs this */
 		__remove_dirty_segment(sbi, segno, DIRTY);
 	}
-
+out_lock:
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
