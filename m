Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5424CC55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=z40yVcKMuI0NlDFkS6bXQQrdKurzhWJAWfk/8fz46qY=; b=XMHEQg5MSYNfX9C5P63XsGlk5f
	LG9PBdRIk90qsFS6mr15yKSTOcMPKUvMxCv21rRjd9Hne76jjI6Q2zZkWka4cabPuUNWf9Di3U6dg
	FJFY/aiJqb2ASoMkzn3byXnhZKx1CJnL0jd/f7S0RoSwMnrg2ftCw3mMDWV3K/dtr5cU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wroTe-0007XM-Rx;
	Thu, 06 Aug 2026 03:09:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yonggil.song@samsung.com>) id 1wroTW-0007X0-38
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z/f7KRhFbgKZ8awYHoN+cHPJaT0L+pOvVCYMxjwdQ8s=; b=F7y111gaakpmJiAi4zQauqKHqW
 BcPVUASAiiQuX3GPlxZ0DjaD/TLqjrL/Wi8aq2RYTk92bRuHz9ATPSdbaCa2LHy7Z9Lc9vB27QTDj
 jw0OTJdnWmnmS90xq6ThAGEKjodm64nHFjMc0FJ0t3qmJ3nn5xShYHAtu3bzZSpdjvWI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z/f7KRhFbgKZ8awYHoN+cHPJaT0L+pOvVCYMxjwdQ8s=; b=G
 vizTHNnXVduoRY89g1AOoAQ+dqKmRnK5QP4kJhffysUp6VgbZZJPa3Hze99Q44NGqo1oMz3wy6qRN
 m/x8kLNBKI/WuddT0nRN+UPm5DcGHMNnyfMsZ8V1AMhrsL8XvYs6WOb5Cs+xBqZ3DaljLLFpR/Kb1
 9oesex4PB7QqqIj4=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wroTR-00073k-O2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:08:51 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260806030842epoutp02359f24aac488545c872f4c29161935e0~JGI1osgH50744607446epoutp02T
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Aug 2026 03:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260806030842epoutp02359f24aac488545c872f4c29161935e0~JGI1osgH50744607446epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1785985722;
 bh=z/f7KRhFbgKZ8awYHoN+cHPJaT0L+pOvVCYMxjwdQ8s=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=jHu0TOtu3ClfQIKBb1WQtNPfWUAdf8KJyTT96BEoEK3bm3APXy2/NLQ7jB9hq7ZEq
 0Pm+4EDly0oME5HU/KXprO6VQiPdwE/lSl8fsIJrF6CeubdXIoqlPO6lfxaR7xX+rU
 HXoh0boSD0c8I+bhtp8HtJ1qv9JOOmV7DqnW3kqk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20260806030842epcas2p39013c010623443ea7c63732b3bf139c2~JGI08EeGF2319723197epcas2p3z;
 Thu,  6 Aug 2026 03:08:42 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.203]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hFsgF6PpHz6B9m8; Thu,  6 Aug
 2026 03:08:41 +0000 (GMT)
Mime-Version: 1.0
From: Yonggil Song <yonggil.song@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
Date: Thu, 06 Aug 2026 12:08:41 +0900
X-CMS-MailID: 20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41
References: <CGME20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
X-Headers-End: 1wroTR-00073k-O2
Subject: [f2fs-dev] [PATCH v2] f2fs: issue multi-device flushes in parallel
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
Reply-To: yonggil.song@samsung.com
Cc: Dongjin Kim <dongjin_.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On a multi-device setup, submit_flush_wait() walked the dirty devices
in order and aborted the whole loop on the first device whose flush
failed, leaving the remaining dirty devices un-flushed. Each device
still needs its own data made durable, so a failure on one device must
not skip the others. It also waited for one device's flush to complete
before issuing the next, even though the devices have independent
flush queues and could be flushed concurrently.

Flush every dirty device best-effort and in parallel instead: build
one PREFLUSH bio per dirty device, submit them all, then wait for
every completion, returning the first error seen (0 if all succeed).
This bounds the flush window by the slowest device rather than the sum
of all of them. No caller depends on the previous early-abort
behaviour -- fsync only checks whether the return value is zero
(fs/f2fs/file.c). The checkpoint path (f2fs_flush_device_cache) is
unaffected; this only touches the fsync flush path.

The per-device bio/completion array is small and bounded (at most
MAX_DEVICES entries), so allocate it with __GFP_NOFAIL rather than
keeping a separate serial fallback path for allocation failure.

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 fs/f2fs/segment.c | 48 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d71ddb3ee918..f3d3343e012f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -566,21 +566,63 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
+static void f2fs_flush_end_io(struct bio *bio)
+{
+	complete(bio->bi_private);
+}
+
+struct f2fs_flush_bio {
+	struct bio bio;
+	struct completion wait;
+};
+
 static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
 {
+	struct f2fs_flush_bio *flush_bio;
+	unsigned long devices = 0;
 	int ret = 0;
 	int i;
 
 	if (!f2fs_is_multi_device(sbi))
 		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
 
+	flush_bio = kmalloc(array_size(sbi->s_ndevs, sizeof(*flush_bio)),
+				GFP_NOFS | __GFP_NOFAIL);
+
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
 			continue;
-		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
-		if (ret)
-			break;
+
+		bio_init(&flush_bio[i].bio, FDEV(i).bdev, NULL, 0,
+			 REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
+		init_completion(&flush_bio[i].wait);
+		flush_bio[i].bio.bi_private = &flush_bio[i].wait;
+		flush_bio[i].bio.bi_end_io = f2fs_flush_end_io;
+		devices |= BIT(i);
+	}
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		if (devices & BIT(i))
+			submit_bio(&flush_bio[i].bio);
+	}
+
+	for (i = 0; i < sbi->s_ndevs; i++) {
+		int err;
+
+		if (!(devices & BIT(i)))
+			continue;
+
+		wait_for_completion(&flush_bio[i].wait);
+		err = blk_status_to_errno(flush_bio[i].bio.bi_status);
+		trace_f2fs_issue_flush(FDEV(i).bdev, test_opt(sbi, NOBARRIER),
+				       test_opt(sbi, FLUSH_MERGE), err);
+		if (!err)
+			f2fs_update_iostat(sbi, NULL, FS_FLUSH_IO, 0);
+		else if (!ret)
+			ret = err;
+		bio_uninit(&flush_bio[i].bio);
 	}
+	kfree(flush_bio);
 	return ret;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
