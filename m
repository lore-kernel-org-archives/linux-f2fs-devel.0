Return-Path: <SRS0=2C9g=AV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B87C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94025206A5;
	Fri, 10 Jul 2020 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jMvUo8L/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IdpEAYuy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax9JFe+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94025206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jtiZU-0008V7-L3; Fri, 10 Jul 2020 02:15:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jtiZT-0008V0-SI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 02:15:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=; b=jMvUo8L/reEYW7yQvZXtt0rQMt
 8evV3EntNsU6hSvxHfaMq8XZXV5WSHImAFMpAgS7xan05P/jCKVHKQR9ETyBgn8jWKKHGFbk0adrc
 CEdd3mSu9MLItBQsagA25baJpo7tFwLT3zsnjsnWbTvomEOd4buI5BHrSDjjco6jOegA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=; b=I
 dpEAYuydT1ZVxAWWOVeQ47oTE9p6cMPJXdD8drPE85cSURDUnu17GZfvHy1WEeXEutNZXlQ3ay+pb
 wyyoD+bTPiUO0BjM2LL7DcWSUfumcHWJbpDrk+9p51jdqvRhe8WMqtYAP5YA8U8lgHvT4g7yLyv/N
 97pd4fCdfb9MNiAY=;
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jtiZP-001XhD-7d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 02:15:27 +0000
Received: by mail-pf1-f195.google.com with SMTP id 1so1841102pfn.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2020 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=;
 b=Ax9JFe+xCSrnS5iZU07rdj4BMegbKRHByEA8KIB170r2p1prZMYiQAksTM9eePOgkC
 KARvN11mXFlZAJDSrxVeHL1H6nMIPbDpWBOuv4n43DtfSn7p9IvAScA6o20QG66Y7R4W
 jxn2azc1m+a04Ntx+D8JD+Eczob/PWHJnVxQ6SDWIGNzbPMzrsL/h6aQ0H6zqyC7smwM
 Tg8GNZFODhVFkwp0XnLWkGl9aTqy/89dr29vGrZmftswi8hiOYYAKOMEnQbDCVlHM78v
 llSDRikRevxxx8UoFfKBhrPXZrOvsV9oHK9MGC0mid+jFw7AbHue6UZvt3viR06NewKZ
 QORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=;
 b=rhzhGNrKOfyaPBZ8Lsl+Xf7+QGCz4nJeOyjAwtO29l5VjX6xsejny0y1DxQItQm+5q
 fPTAu9uN4/CdEAgAn60qP1hn7+lpMweh6YEOHKw+mM1C8zdoHGt1Lt1i4OeLtCr4kozR
 4EI7HToC298kfXwhCPvDs85p14q3s3Ho1hG2Hsp8/T6MtF85hfmxl0uAUNsbdBEoJ6Y8
 7IL4FTtvUlVAoz5CTa3zz0pfPmZUvktP+9kbb2bedTYJzmeVDmEnhSTgj4dzSOX6ozbU
 nFSE9m+EyLHGCaH2WDejMGvhG01LZ8O3ma946ZV6B9YOMolY+MMIuv1GHSLEw8B9qcpY
 J3/w==
X-Gm-Message-State: AOAM533oLiqxTvTSYrHbVA9DxKUQVCO/+kGkOPtuKWlqnUwBmL6KuCDC
 Yy3gMoIXM7ceTlp8hmpi0PI=
X-Google-Smtp-Source: ABdhPJwpYkmZ/KMKHhtbV3Hu1nYb4/nC7sN7C42DNAWlijZqn0K49dgejQ93gXTEHUhacz5lDin4Lg==
X-Received: by 2002:a62:e206:: with SMTP id a6mr53727039pfi.24.1594347312716; 
 Thu, 09 Jul 2020 19:15:12 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([172.30.115.29])
 by smtp.gmail.com with ESMTPSA id y18sm4190687pff.10.2020.07.09.19.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 19:15:11 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 10 Jul 2020 11:15:05 +0900
Message-Id: <20200710021505.2405872-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
X-Headers-End: 1jtiZP-001XhD-7d
Subject: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
 1. Added -1 value support for range.len to signify the end of file.
 2. If the end of the range passes over the end of file, it means until
    the end of file.
 3. ignored the case of that range.len is zero to prevent the function
    from making end_addr zero and triggering different behaviour of
    the function.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 368c80f8e2a1..1c4601f99326 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
+			range.start >= inode->i_size) {
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (range.start >= inode->i_size) {
-		ret = -EINVAL;
+	if (range.len == 0)
 		goto err;
-	}
 
-	if (inode->i_size - range.start < range.len) {
-		ret = -E2BIG;
-		goto err;
-	}
-	end_addr = range.start + range.len;
+	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
+		end_addr = inode->i_size;
+	else
+		end_addr = range.start + range.len;
 
 	to_end = (end_addr == inode->i_size);
 	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
-- 
2.27.0.383.g050319c2ae-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
