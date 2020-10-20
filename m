Return-Path: <SRS0=wSm4=D3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D43C388F2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:53:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370E321D7F;
	Tue, 20 Oct 2020 19:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="icQZFivX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BcLqS2+R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5R/G05o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370E321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kUxhJ-0003ml-N8; Tue, 20 Oct 2020 19:53:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kUxhI-0003mT-CV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Oct 2020 19:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ApWsqXUGVMr0AU3IN7u+5s3UpXWZGZXiw1+MIywGV2A=; b=icQZFivXdv0p/BywlxBN5KBe4T
 h3hqZ52BBOsIanvLZd13TrbKumLWFhORsxv2JhrlfZOR+e0/yoJi+jsgaj6qT/0QBZh7BmV74PN9b
 KRQdvn590etXXsrbhsnKPox6vzJGYA8xGr9lHrQqiElGToE6zsjjNMDYAZXusHxpZ5OA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ApWsqXUGVMr0AU3IN7u+5s3UpXWZGZXiw1+MIywGV2A=; b=BcLqS2+R5w43PtwarWllarlToy
 qBprOn/QwcX34tDPgRvO3mAgepd35P5DFceoZIdYQ0yKvD3bEbCBcUUcjyre4mFq61L/0anrIdvpt
 dW+TRqfnHW9edKBZKnk+sDvipo5bjROOvku+BtolI/jVBoIiE1WCBEqNJWmiVdMFHOJI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kUxhG-0008qr-KX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Oct 2020 19:53:28 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C54CA223C6;
 Tue, 20 Oct 2020 19:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603223588;
 bh=AHoy8KFgublxtbfCrMKzqGKKzUoHEFBYkSraSnVIqHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F5R/G05opR4eHjGJBhmaxL/dgp2gKoKY0LLIw6+O5iv/b7y3cMxyA6GMZ0+WJYV4v
 JzfxiC2lNgaqx0Gj0/xoxUspW/g9jCOsg8kpLLjqoRemxXErhMYuTvNaINxl9yufSW
 RS7nyCeuDcno3s9Zcr1NvZPeTCGXWzlIEdHnEyyk=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Date: Tue, 20 Oct 2020 12:52:58 -0700
Message-Id: <20201020195258.2005605-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020195258.2005605-1-jaegeuk@kernel.org>
References: <20201020195258.2005605-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kUxhG-0008qr-KX
Subject: [f2fs-dev] [PATCH v2 5/5] scsi: ufs: fix clkgating on/off correctly
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Can Guo <cang@codeaurora.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The below call stack prevents clk_gating at every IO completion.
We can remove the condition, ufshcd_any_tag_in_use(), since clkgating_work
will check it again.

ufshcd_complete_requests(struct ufs_hba *hba)
  ufshcd_transfer_req_compl()
    __ufshcd_transfer_req_compl()
      __ufshcd_release(hba)
        if (ufshcd_any_tag_in_use() == 1)
           return;
  ufshcd_tmc_handler(hba);
    blk_mq_tagset_busy_iter();

Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Can Guo <cang@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b5ca0effe636..cecbd4ace8b4 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1746,7 +1746,7 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	if (hba->clk_gating.active_reqs || hba->clk_gating.is_suspended ||
 	    hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL ||
-	    ufshcd_any_tag_in_use(hba) || hba->outstanding_tasks ||
+	    hba->outstanding_tasks ||
 	    hba->active_uic_cmd || hba->uic_async_done)
 		return;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
