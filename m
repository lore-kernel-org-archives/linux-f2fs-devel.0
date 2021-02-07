Return-Path: <SRS0=fAWp=HJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B52FC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:06:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B707A64E2C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Feb 2021 19:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707A64E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l8pO1-0004vu-KQ; Sun, 07 Feb 2021 19:06:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=665305f4c=chaitanya.kulkarni@wdc.com>)
 id 1l8pNz-0004vl-69
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hPZ0HhtSIHk0aEF1vEdfjvjORQs0jU1MuFrHM8crlQ8=; b=QaS41kWATrV25o28Ik1rD8tOYp
 nYYWqvGODEZIzAh9BuoIm1cLa50P7H7rnl1TlUXCd3SyfIx9GZJNy4lW6hSSjMSyOgLJ5Gh7oS79w
 zZXkS7kCcn6Iqz80nNlUY972+zNM8SEsjGozGMa+U1MhlpY76iaUKXOFLm/vxD1N6374=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hPZ0HhtSIHk0aEF1vEdfjvjORQs0jU1MuFrHM8crlQ8=; b=hqTTTXkdVfBnoBBTObtzyc9Ouq
 CM51/Mj4i0mPHDDLeakO7v9T9SUzOgVGtXG9ckDLgHjaFHwinJ0WXGsI/ZaN1pt1Xl0FBtX8RAcKg
 XbuW8wLeLWwZStypNZLR0s/u8B5rUHTIXmrPcLR/XZ6tHMxmlAbSnefod8RyY2a8WzOQ=;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l8pNs-00Dxfg-Fs
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Feb 2021 19:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612724772; x=1644260772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X5WW6UV6FqDYJmbiL6yKTiQZQYZsZ0lHrvx/ZJ7Pr8o=;
 b=GnpC9FouRrQjtUQE2cvvFKDYVZYpeRwDd1fus+/SrdwQxyzxUhB5VPnJ
 hib2HDMPqJKwL1QM1Nw57ca6o70PNRgVwrjwZ+v/M57oTM379F0xJQ+pg
 p70A5Y8NnRvS/C+gFpCwTzQSRogzkSUpqPhJ+LSOO0Hszu1dDrkpMs/Gi
 BDcavkh4a/LcQpJ0QW5aR1sW1r8CDoP+Lx6A6m8JG/YUblNEIDZ5otvgm
 QvcsKKpjhBEZGMoXGMbkxKGISqTWf23Clmr12ay0lNT0+ewjU5vEX5AQ6
 v5IgAt5XCmmsgwzVSM2t4vnjKS84U6ei5yy8E9NMxFAksQKSJ8wRRWstv Q==;
IronPort-SDR: PUpirSJyRvA2PLUjsOliBFS2Nlq6rztZUa8jPv3mok57fcA2j0XSIXgAHcPy83eIrs0nceRubY
 IIcTdIqDRnfUsys69yR2wC9adx6bwZeLtaP1MJXfQmwjerOUzdbKVX4XV7O4ahBSB9rpiS/OWa
 fegmroQEWjdGthXnqSHEvf0svOemCe9A50lwMRIS/vMFKTrUMa4wbz2evMNY+6bKoQswhGmKgR
 yvYhGy+89uk2plnuGilHUOT6eH6+sfBDR5P28wRcEUPVXkJv7KBlyyjvvo+NBN/fEJ11pqIHLt
 4/A=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; d="scan'208";a="163856653"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:06:06 +0800
IronPort-SDR: UOqhVWiJK/FvnzWPe0L7jq10G7fAYqrbM5203453I/OgArR1lB9AWW7ivKz7xLCqL/RQDtHfWu
 8sJNKF/IjCge6xFVGmVTtRAO9ls36NBJWyaZjxDY134ZQYxBXRPAHY9WKfkoVOKlFhsOMcGbtq
 R84nlu8Qrow2pW3Bs9j+mbOFJEFX4lpLv7z3BTTKOMKwB327spx40M7QpGYcLSYS3NO2vxUzwC
 v6S2np1jw0oAZuqlScJ2nFSIdn5BBMZaiSyKOJ2eCTB0IJ+Pb6yUExYNBadOUFin9qauL7KQDW
 2aJvAvgELyuBsJjiixjbXAIM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2021 10:48:02 -0800
IronPort-SDR: eyQcbbPL+QE6lR4V/WtfUglic+gwcpaSMs80dOnTDv4VmXGl6LWoRb6mk/guyFq9if3KfEA4Y7
 +tXG9BYvfbMPOgq037oqaHmEsxLw9V2PI5yErlrc6L+Mh7JJRASNpQxBfRv1jha4D9cZKuX2NR
 CEtpkb5dd411Mei9z3RfYAwX5MHsi5Vi8Lbnj8j8d6gvT1bJ8mcdu5dS6zyy6dputIXiXA8OjF
 EAX3KlQYEoDQohdZGm9+Ljm8wP8nr0e3RDoa13Z+INL4FM6854rdwUGB35CmhKO2Y25D1ePrlH
 8Ts=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:06:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Sun,  7 Feb 2021 11:04:25 -0800
Message-Id: <20210207190425.38107-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1l8pNs-00Dxfg-Fs
Subject: [f2fs-dev] [RFC PATCH 8/8] f2fs: use memcpy_to_page() in
 pagecache_write()
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
Cc: axboe@kernel.dk, hch@infradead.org, damien.lemoal@wdc.com, tytso@mit.edu,
 bvanassche@acm.org, chaitanya.kulkarni@wdc.com, dave.hansen@intel.com,
 johannes.thumshirn@wdc.com, ebiggers@kernel.org, clm@fb.com,
 adilger.kernel@dilger.ca, dongli.zhang@oracle.com, dsterba@suse.com,
 jaegeuk@kernel.org, ira.weiny@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/f2fs/verity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 44e057bdc416..ca019685a944 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -79,7 +79,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
 		void *fsdata;
-		void *addr;
 		int res;
 
 		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
@@ -87,9 +86,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		if (res)
 			return res;
 
-		addr = kmap_atomic(page);
-		memcpy(addr + offset_in_page(pos), buf, n);
-		kunmap_atomic(addr);
+		memcpy_to_page(page, offset_in_page(pos) buf, n);
 
 		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
 					  page, fsdata);
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
