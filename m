Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9B7CCA470
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Sep 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D7aFgJ3aKx3n1DAFdTGyZ9O5wBSWlDtrOj4ZWuN4E6I=; b=TQmBPvLTg7mC+GFojeAADS5Rls
	FWGUOVmbKS2eAtl7CpF3GBix+Ja9i2n2vV17ZHY12vzeeW1RdulFpyQvOHyoB5lOhY7nS4MfYj04Z
	3MVyDkKZj86qr8ddTObXW+WIXZTn+2oF6cEN1pIpl5Keguovzx7eyXLpM30o5QbB7CA4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3drU-000079-Qc;
	Tue, 30 Sep 2025 17:10:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1v3drT-000073-M5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Sep 2025 17:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5RdtsH/ZC12TO25bMZETNAUeluMeNvGTqZJsgYwmVdE=; b=DxXOBmN3qTTYpKYCiIQM1zBsds
 DQUsW4EL2Tukyu7MkuhCS7GimhOMQ4EGsjYqOA7G3adDjf+nA6lcCu8ar4tKEUr3UdK3dOXsluWwh
 +gR8oDYMw6f25X9br3UogVWtLotmxB1/6AFwYbxzgZQo764TrdomSKt9Hxb3kM3rMfLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5RdtsH/ZC12TO25bMZETNAUeluMeNvGTqZJsgYwmVdE=; b=Y
 ZpQ93aWNCoKmjQ42XQioYFHZFwwzDrK8Sh3mPtQhqD5PJfSPgOqAtUXgvcgAagKdnMfIUhZyOyK4u
 NEq+vnceP/DpgFtm6DX+l82ruhIQAoJ+qB/S4/qgPhElXrMfok6ELtX8xflNEb6xsMxUvn/bW9VJ5
 4U6GGdpJI9KJAF1I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3drT-0001cw-Bw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Sep 2025 17:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F2C064182F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Sep 2025 17:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998DC116D0;
 Tue, 30 Sep 2025 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759252193;
 bh=IL919AOzmSovhF3uffWie0k7WL6h0ii/lapE8tZ5hWY=;
 h=From:To:Cc:Subject:Date:From;
 b=Hr2Do95eEgqTmbcmlFzCBWkPAwyn7ZtAPiPbXSQ3SkLVh4UgkgxDol66GIXx2rrm2
 updnK2THzR3xm7CxIZaOt/rcCp+Ajebw81b+1jw/X/aR7gYmXy6JBx/Q981ZhRNs5G
 k2HzTShuwI5jK+K56z6+i0VHw9hcOLjPwqXw3oA+K9K9MV4emdATj9vgo/lOgyZdWA
 RY72qE96zcseNrsPtpqea2Z83gq0iedg6qEw88ddDycYbI9L3qyvs9UZ6v2AGJ3ZWf
 OpP0JeHKI2l8YBXNHSaIp8QjsiKK/THdDvO+dJi9AE/OacEsdUkMngMT7UMLmuffJD
 3yt3VeB4d65EQ==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 30 Sep 2025 17:09:52 +0000
Message-ID: <20250930170952.3188971-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
MIME-Version: 1.0
X-Headers-End: 1v3drT-0001cw-Bw
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: set SQLite journal files to hot
 extensions
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Journal files will be created and deleted with random updates. Let's put
the data in HOT log to mitigate the entire fragmentation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b98976c6ffa8..53e1f982945d 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -157,6 +157,9 @@ const char *media_ext_lists[] = {
 
 const char *hot_ext_lists[] = {
 	"db",
+	"db-journal",
+	"db-wal",
+	"db-shm",
 
 #ifndef WITH_ANDROID
 	/* Virtual machines */
-- 
2.51.0.618.g983fd99d29-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
