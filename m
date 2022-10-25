Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39844C04A95
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Oct 2022 07:29:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1onENB-0001ep-UT;
	Tue, 25 Oct 2022 07:29:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1onENA-0001ei-LO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Oct 2022 07:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q1RyvoOcymfIySYcgs9ulA134LQcv1LmgCsjKiI382Y=; b=ibhxkXabeHAVDvPd4PqtdWSRor
 KR/lZjBKMbG8/sg12GtvaOt3cVAuRahEq6Rk559HPtaj2AG9dM/REHTL0qnNFFpDH2YMGKFYSJiW8
 +UvV6kMHrX0S73uNpLb4bD8XphUJ23jbDmYZ+ZpFEz7c1C/BFWdlwN0ujiSf9d8fZqiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q1RyvoOcymfIySYcgs9ulA134LQcv1LmgCsjKiI382Y=; b=bBo3ZfX+OygLRpVX9d5eiSYAeC
 YzKLQ2vEpQRkwwCGB1H4bj56c5eNMYY7ioB8QGyRtSDBf5hYJOcVNwXtfwH7Lal4qjrgqivcpoqVG
 DPfHYHSP35LjttxfBAgMoMiP9wQoiONoLx2cPwR06qaAvA+JxBtrafrlGbfbibbeJx1E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1onEN9-00034w-Pv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Oct 2022 07:29:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 69D4461783;
 Tue, 25 Oct 2022 07:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D7C433C1;
 Tue, 25 Oct 2022 07:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666682949;
 bh=Gv+wL2UYnkvCCSfsrxAR0k2V1PI7nMZ5YN27pTjKFDs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NkYcHkrAiFGBHaDCZbtg2xV4WxvmHEhemBJcYL1zXrnRa5GJxUW2QhIxFYaAuIjsS
 S7sipVaLzJMCSBkGh/P0cySaBCCBWQbjCTXqmuSxUf0yHV/NPPEBYh6zdODRseQ6K/
 JTKibZXeX6mpZCceolxI0GWSQYN0atY6CegWnpCoIdxcpwyFKRzzxBZS466AFa0z1w
 XAsFJT34HBo+QNa0IBKz22tK13lq0ujS0zf6JnVhjY1NV9iJtnz/SPfXRFWJ0cxOMA
 R+XG4VY7ZcqLSQWTsu5THL1NcJ1jkyV73+0xdi54KEGlmji0DmguWHpNoOAP3w8vhR
 Hm8ddZkNAtYNA==
Message-ID: <b19175cf-7f87-03c0-a129-716f9bb5e16d@kernel.org>
Date: Tue, 25 Oct 2022 15:29:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <bfae3198-7557-f984-200c-2c677881f462@kernel.org>
 <20221025070817.37391-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221025070817.37391-1-frank.li@vivo.com>
X-Headers-End: 1onEN9-00034w-Pv
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant return in
 f2fs_create_flush_cmd_control()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/25 15:08, Yangtao Li wrote:
> Hi Chao,
> 
> In my point of view, it should not return 0. Because calling kthread_run()
> to create a kernel thread may fails, and err is assigned a value.

I commented on last 'return err' rather than the one in error path...

Maybe:

---
  fs/f2fs/segment.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 81aadfc06c89..25ee8c8cb2cf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -634,12 +634,12 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  {
  	dev_t dev = sbi->sb->s_bdev->bd_dev;
  	struct flush_cmd_control *fcc;
-	int err = 0;
+	int err;

  	if (SM_I(sbi)->fcc_info) {
  		fcc = SM_I(sbi)->fcc_info;
  		if (fcc->f2fs_issue_flush)
-			return err;
+			return 0;
  		goto init_thread;
  	}

@@ -652,7 +652,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  	init_llist_head(&fcc->issue_list);
  	SM_I(sbi)->fcc_info = fcc;
  	if (!test_opt(sbi, FLUSH_MERGE))
-		return err;
+		return 0;

  init_thread:
  	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
@@ -664,7 +664,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
  		return err;
  	}

-	return err;
+	return 0;
  }

  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
-- 
2.25.1



> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
