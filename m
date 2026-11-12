Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B722606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AL2IYELd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zt0N4G3u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HVrLOxYm;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oKaUXZQe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QCIJm/23stPPMgqF92KB6HzMIjrPbDDWhJfGgtCGwLg=; b=AL2IYELdWk6Z+IGRVyhDlRQi+u
	Dv9HxSE87Dqp0LxH0mQ4/0mgho6ymyr9deexAaZ9gA+b+tJknV2AZMpEVSX2hDznO4N4zrCL1RU8y
	UwI43hFKfp3ceQXXlIzBnDgYs54K4b+UvTcetkULKZx3sOsqNsSgzAmwd1E2EI1t0dOc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRW3C-000000001w7-3Lsj;
	Thu, 12 Nov 2026 14:45:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3YM_1agwKADUagiljRbfnjbZXffXcV.Tfd@flex--jprusakowski.bounces.google.com>)
 id 1xRW3C-000000001w0-1B0F
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cB8ddj7nwuP07tqnBAQ4tCqc/XQIzNVVwVmCcZLYx6A=; b=Z
 t0N4G3ueeKbiVuOM7DZWRQvMGgS/5DSv57mrhQlXvtwAAWtmKWsQIM8MVxiONmjq9MPumBBPkuPxc
 HNs2C4+1yQB8/wa8ERtIN5EwRdGjVT2aEMtIhwQq8dOAZhIYrIpYoIErewdBnLM1So6OQbXD6jkIW
 5DcoaBtMMsxplth0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cB8ddj7nwuP07tqnBAQ4tCqc/XQIzNVVwVmCcZLYx6A=; b=HVrLOxYmZ8WrYLQjZ+vvTJjEOa
 wXmoRpVv434Lgd1JAqULCQylRmQUZOG7XJ/SSVKjgvnEoTdjViinjsn+GOUcj4S2WoV9QSuXsUnWT
 khiAUyvKqV/A5TQHisQwVfbVfaxBLOcSLTnctiEuenGawV9n54fAv9cSEzxAt0HrGwaM=;
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRW3B-0000000085x-3llD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:45:18 +0000
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5c15643ba9eso2378659e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494711; x=1795099511;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cB8ddj7nwuP07tqnBAQ4tCqc/XQIzNVVwVmCcZLYx6A=;
 b=oKaUXZQehBhXxY8B6eDJy4OpxRasb1ntWMyGVbPfrJM/E/oczXrxXtVYilvE+RMyDk
 R1VBJEzeXQanFxK32xgGnzRwrgE5X7EDQCqFvdzp9piNSWqmEna56ftLGw6fLW7RKINe
 1OeNBMDU9nuxRlGYOFk5eR8Hf4etySxKu3tI5B+FDMRf5d5sbPQobEF1bgrgm6IetLFz
 RoMakxh2vX2QgK4vE9/9Epv6JZSyQuHm8Nar+x7gzXKdlQtwgdWCUxN5g1iV27MtiwDN
 tiQWoNqOzgLZTu11KjVsluR1MmCRYHkt477FHUady898RtT+a+Yo2OVVDGV8prewX/Vt
 JXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494711; x=1795099511;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cB8ddj7nwuP07tqnBAQ4tCqc/XQIzNVVwVmCcZLYx6A=;
 b=Ku5lS2FMfxvwf50SfQ1PGOjojow36LzSYllFnfwjOqiKEByMPhWzdoMf5wB8n0eojt
 RpeHIXuCuWXTHSb9D4n860lfoSmixW++Ryu5ECKHI9pFP3JDcII5/lNYAbX/5YWhXter
 5SSVGbJzpTfZFbQYXILUV0qOC5rfnzs3bkXb8qaKU3QWmJCoDp1iGOdnmBGK5jgiO2qx
 b+vFRBVYJEyDIqpKZxlngPWI9GuL0mpaC7aK9RWToiQFjaCNXnM0XmoeHjbYMONpsRvY
 lVyJ1JAsyt/tXzXHUbBUbJwPB+fXWzGdefVxEU74MofHlahMZ7MbQ9gMSnrsCA1yQLAo
 bIew==
X-Gm-Message-State: APuU4Z8BOiDwuEPWiEFEPVmG7DaT1Q3JPI4mPZnWPBAiV336d+fxdzhx
 DCSq/zAs5ICVncxkLJbOVh0wnjqQo8By6LRWSM3Zyt7aSapKsztppSvyPpiepmt0vQ6G+ARQdtY
 e9ObC6hoU3HpEfakG56xsl2X1uaAUmw==
X-Received: from wrbgv25.prod.google.com
 ([2002:a05:6000:4619:b0:49b:296a:a185])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310e:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ba09383147mr103696635e9.16.1794494304704; 
 Thu, 12 Nov 2026 06:38:24 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:47 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-2-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRW3B-0000000085x-3llD
Subject: [f2fs-dev] [PATCH RESEND 1/9] f2fs: compress: avoid sleeping in
 atomic context in f2fs_decompress_cluster()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

f2fs_decompress_cluster() can be invoked directly from bio completion
(softirq/IRQ context) when in_task is false. Passing GFP_NOFS to
fserror_report_file_metadata() in that context can sleep and trigger a
scheduling-while-atomic bug.

Use GFP_NOWAIT when !in_task, matching f2fs_sanity_check_node_footer().

Fixes: ccc6436abb84 ("f2fs: support to report fserror")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c7910688c318..9453254ff522 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -763,7 +763,8 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 
 		/* Avoid f2fs_commit_super in irq context */
 		f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
-		fserror_report_file_metadata(dic->inode, ret, GFP_NOFS);
+		fserror_report_file_metadata(dic->inode, ret,
+					     in_task ? GFP_NOFS : GFP_NOWAIT);
 		goto out_release;
 	}
 
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
