Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6699EEFCE3B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RoE8vXIf9ZwfoLmKjypbYQoFqjoTr1GWl1qSoNcqHsg=; b=MTaqjCjqfqo7fEGdGeErRQZ6j4
	uGELRCfFPlgdDCqybGedWY5kOM7g/cBfS8/QKwtO6OiGxAi0Sn5fwFpTIpIzIsFUrvP5SsNhay6hG
	l6eOfLOQnPWY0nXmuuyiS3xlC2Y2J9fAgnfTlLfbL2d21BbYQJDBWyGeWsFQgGtTx2WI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxrWc-0004jt-1U;
	Wed, 04 Mar 2026 19:04:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <agruenba@redhat.com>) id 1vxrWZ-0004jl-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=content-type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BaLtYgei9IWIO1DSr3vx23YgMlhkxC2wxvdO5uumCI4=; b=hldEudZOFZX6/+iYdY/QP4sk22
 vNQLhJoHYOfavV2V0AcM/5ZsSbtmPZIdvoKJyeZr/et8QQl84Z8qo9WzlET/N1usBBOHgnnmjCELy
 a2B5FDCvpWOf1Iq731R8eCe2maQRVlYbhNGhZofv7dcJOiMsw+e/GBnjQ+eah/GgNpLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=content-type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BaLtYgei9IWIO1DSr3vx23YgMlhkxC2wxvdO5uumCI4=; b=nKHOW8SXSvxjN8QQKR2VHv0id6
 RvaNq0yyua9DLurzppPxQyrfXPBXgRIcOkvcpJVzIG0HFBf2fllGqPkHCOILHqVRehjRj/dmU0fyv
 S6y9Vn7jNbpaoj51bXY/edo9Db4jkvgcnR96E0jcKPKSUH0l+ZaKAcCJfIhE/pyI4k+s=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxrWZ-0001WA-6n for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772651076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaLtYgei9IWIO1DSr3vx23YgMlhkxC2wxvdO5uumCI4=;
 b=AYxMxvBt4zh3hS0vM5bjE0HvOtIYEmvp+qq6jF/5yaZMuR5/6U5y1NkK1ALFYeIIiLAFuJ
 mQP6T+ryuBaZiiRBPQAS2+YODjFYe7xgFSiA7j2O0A9rN8AIglQir/0h96XdcsWEGaRm1C
 rY9Ix4VNPKi9hSARW0bcZVNuKjWb4Uk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-RvUA3WaMPNqHxqOGAKktYw-1; Wed,
 04 Mar 2026 14:04:32 -0500
X-MC-Unique: RvUA3WaMPNqHxqOGAKktYw-1
X-Mimecast-MFC-AGG-ID: RvUA3WaMPNqHxqOGAKktYw_1772651071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7551C1800464; Wed,  4 Mar 2026 19:04:31 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E76418002A6; Wed,  4 Mar 2026 19:04:28 +0000 (UTC)
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  4 Mar 2026 20:04:06 +0100
Message-ID: <20260304190424.291743-2-agruenba@redhat.com>
In-Reply-To: <20260304190424.291743-1-agruenba@redhat.com>
References: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: CIlWMOXH8rP5sAk9eDtuxp-PYSNp08GEFUsIXyTlVbA_1772651071
X-Mimecast-Originator: redhat.com
X-Headers-End: 1vxrWZ-0001WA-6n
Subject: [f2fs-dev] [PATCH 1/4] block: consecutive blk_status_t error codes
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
From: Andreas Gruenbacher via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Since commit 9da3d1e912f3 ("block: Add core atomic write support"),
there is a gap in the blk_status_t codes and block status code 18 is
unused.  This causes blk_status_to_errno() and blk_status_to_str() to
return incorrect values for that code.  Make the blk_status_t codes
consecutive again to avoid that.

Fixes: 9da3d1e912f3 ("block: Add core atomic write support")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..89a722d76c28 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -168,7 +168,7 @@ typedef u16 blk_short_t;
 /*
  * Invalid size or alignment.
  */
-#define BLK_STS_INVAL	((__force blk_status_t)19)
+#define BLK_STS_INVAL	((__force blk_status_t)18)
 
 /**
  * blk_path_error - returns true if error may be path related
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
