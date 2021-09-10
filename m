Return-Path: <SRS0=JHSz=OA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B3C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:19:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2F7610A3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F2F7610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mOUG5-0004qG-QS; Fri, 10 Sep 2021 00:19:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <sashal@kernel.org>) id 1mOUG5-0004q9-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JB2Yh/l800YFw7vZW8+jp5xNwVgOerAVcGQqKy7fCW0=; b=BsbBjfNM6wDlfFbNQrU1q82hcK
 ahKYkUSXf40i7df6oi6SmV3QYJRBWiMpLBXo7A7Y0Z9lWm8QRY8enpmfSaWVb3BaTzLMoK2aFSg+w
 p0raEIVRVl3ZE4wZIPiYrPOGVdySu52iydijgOBm3mB/R1HwfJcAM39vVMmT1soSxDvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JB2Yh/l800YFw7vZW8+jp5xNwVgOerAVcGQqKy7fCW0=; b=KLSMAHy4YGyQ8Nx76CJ0mnrdY+
 0r8wj5KNOuGDj2Rwwt1537QPYjHRRiETPHXQ0+T7ywdsMfHyUHnreglLnkx3jn2tS7AzbSFJMXktH
 ess1BfYyeKIc59INmP0jJjNPWU+DGllq0jde65Cdl5Bid8a0PhONP6XIlMXV42F4N8sE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mOUG4-0004We-L7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:19:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A6D611C1;
 Fri, 10 Sep 2021 00:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631233143;
 bh=mZOGPxpXZONxbkQlgbb7nSreTgz5qWEx6G3RM+zXJL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sRPN01Kos2f4F90j+Z7Mevxe6D55m4ffRp81Z0O9d5p2TV995MI24MmrIJqDyWooN
 DJ1MhT3toFJxAViZjhSIRW0CsHcRH2/n+i42cK6rSYyxdOXbz93N0xgsxrQfcQJZ8m
 0UlawsYUMVHa+8CCOLnfodKiFMGFDUvKwFtmyMUOn9SASusiPaBglI6ffBJyA95L3H
 XjQ/hCLJq717ugpTLluf7DdrfG0U5zMsLrTPdUmZ6lEvCRqx91xtcnNpP32mB04sD5
 XbD4BMcoFDBcmmoLs6Eb6sngfDY8xZIczyclzIeDFvOEip1tNW1ZLd4cTbaqkpRaVV
 Uwc4HllLu7fMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  9 Sep 2021 20:17:21 -0400
Message-Id: <20210910001820.174272-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001820.174272-1-sashal@kernel.org>
References: <20210910001820.174272-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1mOUG4-0004We-L7
Subject: [f2fs-dev] [PATCH AUTOSEL 5.13 29/88] f2fs: fix to stop filesystem
 update once CP failed
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
 linux-f2fs-devel@lists.sourceforge.net, Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 91803392c732c43b5cf440e885ea89be7f5fecef ]

During f2fs_write_checkpoint(), once we failed in
f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
such as prefree bitmap, nat/sit version bitmap won't be recovered,
it may cause f2fs image to be inconsistent, let's just set CP error
flag to avoid further updates until we figure out a scheme to rollback
all metadatas in such condition.

Reported-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c | 12 +++++++++---
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/segment.c    | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f795049e63d5..b2d9980a6edf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1639,8 +1639,11 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* write cached NAT/SIT entries to NAT/SIT area */
 	err = f2fs_flush_nat_entries(sbi, cpc);
-	if (err)
+	if (err) {
+		f2fs_err(sbi, "f2fs_flush_nat_entries failed err:%d, stop checkpoint", err);
+		f2fs_bug_on(sbi, !f2fs_cp_error(sbi));
 		goto stop;
+	}
 
 	f2fs_flush_sit_entries(sbi, cpc);
 
@@ -1648,10 +1651,13 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_save_inmem_curseg(sbi);
 
 	err = do_checkpoint(sbi, cpc);
-	if (err)
+	if (err) {
+		f2fs_err(sbi, "do_checkpoint failed err:%d, stop checkpoint", err);
+		f2fs_bug_on(sbi, !f2fs_cp_error(sbi));
 		f2fs_release_discard_addrs(sbi);
-	else
+	} else {
 		f2fs_clear_prefree_segments(sbi, cpc);
+	}
 
 	f2fs_restore_inmem_curseg(sbi);
 stop:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a5de48e768d7..5a929c68353d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -538,7 +538,7 @@ enum {
 					 */
 };
 
-#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
+#define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
 /* congestion wait timeout value, default: 20ms */
 #define	DEFAULT_IO_TIMEOUT	(msecs_to_jiffies(20))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 800656e082c5..621f60a9974b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -775,11 +775,22 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		return 0;
 
 	for (i = 1; i < sbi->s_ndevs; i++) {
+		int count = DEFAULT_RETRY_IO_COUNT;
+
 		if (!f2fs_test_bit(i, (char *)&sbi->dirty_device))
 			continue;
-		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
-		if (ret)
+
+		do {
+			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+			if (ret)
+				congestion_wait(BLK_RW_ASYNC,
+						DEFAULT_IO_TIMEOUT);
+		} while (ret && --count);
+
+		if (ret) {
+			f2fs_stop_checkpoint(sbi, false);
 			break;
+		}
 
 		spin_lock(&sbi->dev_lock);
 		f2fs_clear_bit(i, (char *)&sbi->dirty_device);
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
