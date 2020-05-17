Return-Path: <SRS0=i8F+=67=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF05C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2020 21:47:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73838207F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2020 21:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bQsaGEIN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="So7C6aNV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="b2OunlJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73838207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jaR8H-0000yD-TP; Sun, 17 May 2020 21:47:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoqing.jiang@cloud.ionos.com>) id 1jaR8C-0000xX-IJ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 May 2020 21:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=; b=bQsaGEINX29nSH23ZrNdXshbU+
 f1gJZa9zxxKQGxUaw/GkL1LqM1FcdSE4MZvlx4mfInDR7uVIepcQsGlXug6/b/WsN05axdg7Vgl/b
 DjzlWDAxxMW04Y+e6HagP+dZRH7w28GnqDbypO4NJPk5FftkdtnC392vHtt9z++sYquo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=; b=So7C6aNVyV/UdKGci/fF0Yxnv2
 6ErwE/P81t5ifoElWQ98AUj94W2O5J2a8t+rKVYfnIP1u1n9nHGyS7yjWLB7X8i1BTA2UY049Upcj
 tE6c1n5mT9NU21PaByMVHNyZ20hb6q0Vo+UaBFpUslnBL2WYHbYCtPsDc31ms+8gO2A0=;
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jaR8A-00ClRi-Jj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 May 2020 21:47:36 +0000
Received: by mail-wr1-f67.google.com with SMTP id l11so9646719wru.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 May 2020 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=;
 b=b2OunlJb1CqG4qMvf91CNV+d8tunFadtVS8JCoT8WqCC9BY9AeF54XVDVBqhqjfXF/
 8OPXXY8BQ3dm7EE/i+F4/9JmQtxgkNDL5deNYT17giGKWgdRYlaG3i6daLy5HIsw/PfM
 20vdfTALNGIdNIiamhNH0OdiJmHmrzuDPCcl2Q1mjWwTDMJktm4aF7kdIxdy0DI3mayq
 0K35ZpmTBYtxEJOs63UQgGJfbmZNvtcvtVvm076xjtcI2succM5Q8iou6S3qSQ3C5Vl0
 FjJL13aUg0ZvNStsIAe4mAz1kVDyZ14fOCMqUqqszcwIVyNJAwF8wSko6zY+IN9q/m4/
 GWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=;
 b=M8xtYZG5nVp9ez2MEFXCt64GZ3mA6RC3PU3LjRIEIJRe2/g9gGIOwi4hDls8dpYT37
 WQLi63iUhzLycsgQSAhgXrOeaC1b0ijfM+hAmqsvBPJOXDYQS0N/AYVTuaUgE6VBApDo
 mqnyAtJbUNh7gj6bS69Fn8JDr/twSB3v62+OF60uU0TzvUMRNgkxMtAtWarJWb1HH6pm
 sbDhqEwhiPSv0tvfw6VYDJbJcT5hzu0ChqdnOT9x8xLCqi+7FVJ6mXXbSe1bBbfFqdXP
 BtX6vzXidykJ+iiXtzWffhQAXyXwTjalqXE7E/uYsjPduWS6NztPPSUJ1J+PaY40IqO+
 etUg==
X-Gm-Message-State: AOAM532fIKS7If3Hv/+fb3MMek4bcg81p7Qf2qS/3w+iWVcqUGk2NfEK
 E1zXPgtFPpnLNoDsEsYkA3U3eQ==
X-Google-Smtp-Source: ABdhPJzk2oag1WV/Akj3+q9BtXJaV2V1BQcaFlIJ4suSs38gE/ChmFbqJosJ60jwzmp0vo3buD/jog==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr16142123wrm.19.1589752048332; 
 Sun, 17 May 2020 14:47:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
 by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 14:47:27 -0700 (PDT)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk
Date: Sun, 17 May 2020 23:47:13 +0200
Message-Id: <20200517214718.468-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
X-Headers-End: 1jaR8A-00ClRi-Jj
Subject: [f2fs-dev] [PATCH 05/10] f2fs: use attach/detach_page_private
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
Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, david@fromorbit.com,
 linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3574629b75ba..a4d4a947f603 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3128,19 +3128,12 @@ static inline void f2fs_set_page_private(struct page *page,
 	if (PagePrivate(page))
 		return;
 
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, data);
+	attach_page_private(page, (void *)data);
 }
 
 static inline void f2fs_clear_page_private(struct page *page)
 {
-	if (!PagePrivate(page))
-		return;
-
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
-	f2fs_put_page(page, 0);
+	detach_page_private(page);
 }
 
 /*
-- 
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
