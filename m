Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAFDCD5BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nROP1kgikMOLPt8iJFmtW/MygPJBhyABngbv6tM6ROI=; b=MLZc1WgyZ2ibW+VaR11m7fSU3G
	r+hM2uO5LK/mQmfixZbb3KsKItyju/HlJQyVRZp9EUSNvWT53Q25aN0rkBWejTYzXBTJ825FxShpH
	Rwd7jJW4Du0zeb49Xi8a2KCFk9T1mJKGRaN+ghmDdYNhr8ba9nA1iFjep/WB0dDRd+yU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSiA8-00075m-Jv;
	Thu, 28 May 2026 21:21:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wSiA4-00075c-Qk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OJwzJ6GALLGK9Sg4rsdw7OdDwxtJQF76mFoiIa0WOpM=; b=a2eTg7p5vhKkVsCCr8wKLvz34p
 rH/7IdmlZexB7WBCM2/HZoPLwjPr+TvkqHs1gxQSOn3GpwDC9BtIuoTcCnTEjGbRoKzjCPUsktRzM
 d247P7Wv9pPeNpvyw6vyqNBkFd10uTvz3/LZ5/mAiGIrj5XOGFOAC1ZSESbAM6+hJWyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OJwzJ6GALLGK9Sg4rsdw7OdDwxtJQF76mFoiIa0WOpM=; b=a5cgb4KMnsDr8Jv0tNgNPFCtWL
 +WAjWdP4MnS80ikI+Hxb4+mjeboYikE4AMJzXlvzskoUsCY5FWE0p7eUf6/f6E4jcWPa5NWlsl18b
 qIOEWDQeA0nxRpjfiZ0dWg+qOyfyFfC0+/sbQyAS3+Fvo4IONmZlmlXJ+s0wi3gXwx0g=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSiA4-0002uq-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:21:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRKCh5BKxzlfc3v;
 Thu, 28 May 2026 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received; s=mr01; t=1780003245; x=1782595246; bh=OJwzJ
 6GALLGK9Sg4rsdw7OdDwxtJQF76mFoiIa0WOpM=; b=3/cZX2yax5U4smzOuBNez
 WHoqxUyefzUXsgtFTME/aBWiONwmAtRWVEFEVe6iIXP75o5uXQYMH9gBmoXjpwB+
 ItA33J6ZDuSTxSHyeyo6+W2HhLN8zIZCABSK1+X343ivOxGX7tTJ3KKrb0uCiNeC
 gOojkMLJvQwL4VWX2yYi8Aqu5VoKd9eXuCEWmdWZrqy6Xy583DaJav97zUoQSEsq
 /zNdYU0KTB1aYAYTtKehIW5a64zZ67SRmAZx/IK36SEpsqWOsuqadhXyjrYw/Y5T
 K9pwypdCYVibNaC830qoFIAIqicg2200qifExIwn6pJVlnszlQGc7M1Mhdrs8BxA
 w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QF16BGKun5rb; Thu, 28 May 2026 21:20:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRKCc6PkLzlfwHM;
 Thu, 28 May 2026 21:20:44 +0000 (UTC)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 28 May 2026 14:20:27 -0700
Message-ID: <7e756908a2b43b403ae9006b260b4889f64ee42a.1780003055.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1780003055.git.bvanassche@acm.org>
References: <cover.1780003055.git.bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1wSiA4-0002uq-M4
Subject: [f2fs-dev] [PATCH 3/4] f2fs: Split f2fs_write_end_io()
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Prepare for running most of the write completion work asynchronously.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 080d69fa8cd1..48c004976c4e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -349,14 +349,11 @@ static void f2fs_read_end_io(struct bio *bio)
 	f2fs_verify_and_finish_bio(bio, intask);
 }
 
-static void f2fs_write_end_io(struct bio *bio)
+static void f2fs_write_end_bio(struct bio *bio)
 {
-	struct f2fs_sb_info *sbi;
+	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct folio_iter fi;
 
-	iostat_update_and_unbind_ctx(bio);
-	sbi = bio->bi_private;
-
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
 		bio->bi_status = BLK_STS_IOERR;
 
@@ -412,6 +409,13 @@ static void f2fs_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+static void f2fs_write_end_io(struct bio *bio)
+{
+	iostat_update_and_unbind_ctx(bio);
+
+	f2fs_write_end_bio(bio);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static void f2fs_zone_write_end_io(struct bio *bio)
 {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
