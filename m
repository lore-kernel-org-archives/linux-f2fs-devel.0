Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F0CC55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=d3h5v9VdfVcULSvdJfJ5TXl7uW5WOdI9BadH+Ew2IRE=; b=Vw2/Y6ixadcX9Wvkx+HQAVRYaj
	XAzMzBowohVfrFnB4VVAgjV2iFQugDfpfzAbAu6rSCBK2mImNg7By35d5BDAr3eENIxMAg4PRYLc6
	Hal75+dBNjJ2vx6MbqQXQfVEGcGpD40Osj2nGZ92H6Z4yTYtJfd4Sfa+zDwZSadr9eNw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wroxE-0000gn-DS;
	Thu, 06 Aug 2026 03:39:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yonggil.song@samsung.com>) id 1wrox8-0000ge-N4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u3kAxdfTARjDcGyDYbA+mipV9WUWcyhLy7pkNxvjRO8=; b=esm59Vz2YJrOPEhnvgVBwtijUT
 Knk21U+oA9E/x5zigynCFA5oBHdiNqDpB2YUaym8U2Rcrolw0Fq7cP2p3iLRvcKBnaqfvDh4ewxfU
 +zoCHY0eLy07oaJIQG7BndPUC47ha0Ro1VwbfQ1VySxf7I3kywj1lMJkWCTp2k922FzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u3kAxdfTARjDcGyDYbA+mipV9WUWcyhLy7pkNxvjRO8=; b=S
 B9Z9/OZR8XZkb/05VpFxx7UJ08HR2WiT7ozGfx3ztKW49CsenAOVXb+nw1fL/QkV/xZMlRfbRZAYB
 D314NmMaKNjANvHkw9nkRnFCMa8idGTbRrCLckS7GLML0YJWF9vP//kwUMV4WPsWb8NFWhhixRFT5
 iYSSUtZlPPfC/sl4=;
Received: from mailout1.samsung.com ([203.254.224.24])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrox7-0003uA-RN for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 03:39:28 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260806033919epoutp01ebdd67619869091a8d5c10cce9a7a5da~JGjjw94Tw1070910709epoutp012
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Aug 2026 03:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260806033919epoutp01ebdd67619869091a8d5c10cce9a7a5da~JGjjw94Tw1070910709epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1785987559;
 bh=u3kAxdfTARjDcGyDYbA+mipV9WUWcyhLy7pkNxvjRO8=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=iuJtkqoCFHCdU+t7WdnRJXqTjx0FpTxNq5XYgbv+J5m5VfPf1juIwbdumMGTAmzNi
 Up6gNNJ2wdB30Z06kcjqjNkr9YbM558kgRcwtCjs6hhObsGm+uwWS2mx21U30bWgUT
 B8Y3l9ZOi0odWhaYGj6T6xrX045wmjEApUsu9Zls=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20260806033918epcas2p4e9390d48cc7dd4097dbf898b8a1e4d50~JGjjhcgEA2844728447epcas2p46;
 Thu,  6 Aug 2026 03:39:18 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.204]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4hFtLZ4R60z3hhTD; Thu,  6 Aug
 2026 03:39:18 +0000 (GMT)
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
Message-ID: <20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f@epcms2p7>
Date: Thu, 06 Aug 2026 12:39:18 +0900
X-CMS-MailID: 20260806033918epcms2p7fa34d6df7c1045b19ac026d44b877f2f
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41
References: <CGME20260806030841epcms2p72fcdb3db8c3b6de434ceaff5635c8f41@epcms2p7>
X-Headers-End: 1wrox7-0003uA-RN
Subject: [f2fs-dev] [PATCH v3] f2fs: issue multi-device flushes in parallel
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
 fs/f2fs/segment.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d71ddb3ee918..5c7a3992cf60 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -566,21 +566,59 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
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
+		submit_bio(&flush_bio[i].bio);
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
