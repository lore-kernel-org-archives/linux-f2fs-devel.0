Return-Path: <SRS0=U1zQ=6X=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36CC28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2020 07:01:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7D921775
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2020 07:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ti3AFx/U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="db6ZxlKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7D921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jXJUM-0004Pj-Bx; Sat, 09 May 2020 07:01:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jXJUK-0004Pc-W6
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 May 2020 07:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RQR+85E8Gc8VhGBet7+pBjTCf9w5BD1Xhe2H4iF4R8k=; b=Ti3AFx/UHQEKYwC7BmS0ytqW1f
 N7nvXZeuTKBGlFMM/qAgDgs+dKkU7WRT97QtNGFbouYiA3B200UbX+V/aN+eFzF+dFzhCQKC1kwZM
 pPwCleMw9F07Gn606VyEzNhiTdYct7HaojgK0gttwbCIS0rXbY9gFi0AT5Sa7T5asauY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RQR+85E8Gc8VhGBet7+pBjTCf9w5BD1Xhe2H4iF4R8k=; b=d
 b6ZxlKlvpH7BuCgQHO+s5Dz/3TBwPlccbD4QIgPtznJwwgTDFxoSrt9n3CvfPsEjAIUI2w/xz6bWh
 XB+ZU9dEqy6R3vVTO75LxEUTLbYYSQp2Fz+fryQ75NNN6KSPWixuWSYe8+1Lr2bnLCRaTlPf7Esjm
 Fj3zsTEXCV2MiKiw=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jXJUI-00EqoD-Nc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 May 2020 07:01:32 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 70D7CDEC6CEAA25B8B08;
 Sat,  9 May 2020 15:01:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 15:01:13 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Sat, 9 May 2020 15:01:04 +0800
Message-ID: <20200509070104.47709-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jXJUI-00EqoD-Nc
Subject: [f2fs-dev] [PATCH v2] f2fs: compress: let lz4 compressor handle
 output buffer budget properly
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commonly, in order to handle lz4 worst compress case, caller should
allocate buffer with size of LZ4_compressBound(inputsize) for target
compressed data storing, however in this case, if caller didn't
allocate enough space, lz4 compressor still can handle output buffer
budget properly, and end up compressing when left space in output
buffer is not enough.

So we don't have to allocate buffer with size for worst case, then
we can avoid 2 * 4KB size intermediate buffer allocation when
log_cluster_size is 2, and avoid unnecessary compressing work of
compressor if we can not save at least 4KB space.

Suggested-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- update commit title/message suggested by Gao Xiang
 fs/f2fs/compress.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5e4947250262..c0880c3e4b6e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -228,7 +228,12 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 	if (!cc->private)
 		return -ENOMEM;
 
-	cc->clen = LZ4_compressBound(PAGE_SIZE << cc->log_cluster_size);
+	/*
+	 * we do not change cc->clen to LZ4_compressBound(inputsize) to
+	 * adapt worst compress case, because lz4 compressor can handle
+	 * output budget properly.
+	 */
+	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
 	return 0;
 }
 
@@ -244,11 +249,9 @@ static int lz4_compress_pages(struct compress_ctx *cc)
 
 	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 						cc->clen, cc->private);
-	if (!len) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 compress failed\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id);
-		return -EIO;
-	}
+	if (!len)
+		return -EAGAIN;
+
 	cc->clen = len;
 	return 0;
 }
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
