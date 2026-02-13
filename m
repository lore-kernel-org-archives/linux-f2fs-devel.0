Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755A5EF48D1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Feb 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=GYjuwq16Arj55Fk9IrtS1v+oW3DseKMGcxu0h0wHDtI=; b=TAiQN8JCyKqzeB2FfmmMqImAVy
	WnYTW2KtpHuToqGZQQaHzRod/Fb26RPU2o4pQ6IIzrqsGSH47VLdRwwEvj7F2tAne0Bau8KxbdEqu
	JKUSeOjMQh+/4v5sYDWuZCWVuCvPL5infDj7M1keC7vsbhPpUaAHMI4GMlhkTIxGsrCs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqm5Y-0008Gz-Bz;
	Fri, 13 Feb 2026 05:51:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kundan.kumar@samsung.com>) id 1vqm5X-0008Gt-6j
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 05:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02DDEaQljJH+1NIoCRiXwA4Cox05Tk7oMWaIvNrazSM=; b=RqMGpu5m35A1Pbt0Ymu+qDskR/
 RBgHhB/xatfVkjGB5XuKJqs7iLvsrdrYpcP4SPXFLkARjW/nTZZqvMQpCSucvR8m//3jtJZYUlNTs
 wBJ8Cx88H4PKld+co0C2XtlAWmLAwwQ1OAhTqOzUALqgju5JOJ7fk7vyVL8ePKIRLbDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id
 :Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=02DDEaQljJH+1NIoCRiXwA4Cox05Tk7oMWaIvNrazSM=; b=H
 KVzLdvCirmvT36alpiLe0n6qir9naVO2MvasIEjPldyos3oBSt/4MVhQS/GrgJlIIX5Wz1VOa472A
 iiJ+wcvmx1QW190GXUoRguog2TvnYKHSxcgar72cBUc/d4NrEFx+WNtnQ0M+8q6R02ufg2wkEh/HO
 4LJzKr+BMrlGVJ70=;
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqm5W-0007LN-1b for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Feb 2026 05:51:35 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260213055126epoutp04ef629737986bbf87a8384a21ca8bd468~TuHQF1yBf1095110951epoutp04R
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Feb 2026 05:51:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260213055126epoutp04ef629737986bbf87a8384a21ca8bd468~TuHQF1yBf1095110951epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1770961886;
 bh=02DDEaQljJH+1NIoCRiXwA4Cox05Tk7oMWaIvNrazSM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=NucdvvTXujmEfYfriSe+LqqnwNbnMqP+LoZiobsIbMhGPR8CzisJjGUk74J8wHOlr
 78n39vIpmh6qEKn10F7msTFMQ9WC2XOhL3Kz0Ixg7UN3A3umCiyoir+0Mp1zo+SRs9
 nhmMFMcalYQJZboHssKoO/ChnE423Dbf7PkjDtO0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260213055126epcas5p24356d9d29f340cec40f8474b60ab888e~TuHPkBxBP2327423274epcas5p2w;
 Fri, 13 Feb 2026 05:51:26 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4fC1WJ4TXQz2SSKX; Fri, 13 Feb
 2026 05:51:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773~TuHNHL6z22327923279epcas5p2j;
 Fri, 13 Feb 2026 05:51:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260213055119epsmtip27175adf3780b7d24b46fc8ee007de103~TuHJE0T9c2557525575epsmtip2h;
 Fri, 13 Feb 2026 05:51:19 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org, jlayton@kernel.org
Date: Fri, 13 Feb 2026 11:16:30 +0530
Message-Id: <20260213054634.79785-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CMS-MailID: 20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773
X-Msg-Generator: CA
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773
References: <CGME20260213055123epcas5p25f52d5961c04b1a1f514827a494a0773@epcas5p2.samsung.com>
X-Headers-End: 1vqm5W-0007LN-1b
Subject: [f2fs-dev] [PATCH v2 0/4] Avoid filesystem references to writeback
 internals
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
Cc: linux-nfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 gfs2@lists.linux.dev, vishak.g@samsung.com,
 Kundan Kumar <kundan.kumar@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The series introduces writeback helper APIs and converts f2fs, gfs2
and nfs to stop accessing writeback internals directly.

As suggested by Christoph [1], filesystem code that directly accesses
writeback internals is split out:
[1] https://lore.kernel.org/all/20251015072912.GA11294@lst.de/

No functional changes intended.

Changes since v1:
1) Added comment indicating that these functions shall not be used by
   filesystems that support cgroup writeback. (Christoph)
2) Pass inode instead of bdi for modifying writeback accounting stats,
   will make it easier to select proper wb context for the upcoming
   parallel writeback patches. (hence dropped the previous reviewed-bys
   for patch 4)

Kundan Kumar (4):
  writeback: prep helpers for dirty-limit and writeback accounting
  f2fs: stop using writeback internals for dirty_exceeded checks
  gfs2: stop using writeback internals for dirty_exceeded check
  nfs: stop using writeback internals for WB_WRITEBACK accounting

 fs/f2fs/node.c              |  4 ++--
 fs/f2fs/segment.h           |  2 +-
 fs/gfs2/super.c             |  2 +-
 fs/nfs/internal.h           |  2 +-
 fs/nfs/write.c              |  3 +--
 include/linux/backing-dev.h | 13 +++++++++++++
 6 files changed, 19 insertions(+), 7 deletions(-)


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
