Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DB7C02180
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jan 2025 04:42:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYHia-0006Oc-Vn;
	Thu, 16 Jan 2025 04:42:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tYHiZ-0006OI-Fv
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jan 2025 04:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e1j7LCxByx8yYz8i0QrYdXQyBY0xmaOs7nhqSOmFKHo=; b=isl/YZdPhVoa3bmQ23iJLPAY19
 nbL6VNWsm/w57BUZ2ZmPNNHu4MOWNxAZKyndFnYaDFJni8e7zEBvPaMI0bzdrCC+PziAJ/fAvnjOT
 pxVXeg1vCzSLjEZgfAFgV0d6VxfgZR7vmfZK0VSQdeE9I81fF9ERho/Ruq9x5drX1020=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e1j7LCxByx8yYz8i0QrYdXQyBY0xmaOs7nhqSOmFKHo=; b=X
 t2M2zdwydClUHTZBEjf6Xs+Xs2OLs46f68tRK5wo7FC0u6h1MRlR126sUWEYGPAnazGHzdreUjgqt
 4m0aauXFDc/fzu/y6gxD+L5BQS47hR1PXytXRnhWu8/ScL1TAE7l6PhoIwztqDXQnIU2wOakX1GEb
 alVnQkMGIzWv42o4=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYHiY-0002wm-Ab for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jan 2025 04:42:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 900D2A40A69
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jan 2025 04:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28731C4CED6;
 Thu, 16 Jan 2025 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737002568;
 bh=wXFFaKVeJuADTmkChw2w9Gj1NWKnpWpmBtYn2vyGrjQ=;
 h=From:To:Cc:Subject:Date:From;
 b=bI5+VqQenY4hLfbHE34MPhGI3TM156CW+dP8nz+r6Ftm4LZ4fgY8r4MKGynpqMphi
 SMfRPPFQ8H8fA24CmVUF6ODOmPLDC262cSrszQX+XU0LXVN3iUvlZd4HUmr6bsUMwZ
 en0Xl6vE+0NanhXbnZgNwilQLGZ6A5Hq47lIHbyed/rnXTRi7WuGLymaDdSXlbIMli
 +A5nZ01CBZR3ixa+bTFz/nO38DvGRYAMevJZSKeTMXldTjhprlhCgbh7pqLkKKC2CD
 y2PQfFE2qVGpPIKVeiprjydgnZdDwxyC9JvZk2flnOQr/WEftytGiODibIVPbIuIxC
 3nFNiQX28ce4g==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 16 Jan 2025 04:41:59 +0000
Message-ID: <20250116044245.1995715-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
MIME-Version: 1.0
X-Headers-End: 1tYHiY-0002wm-Ab
Subject: [f2fs-dev] [PATCH 0/2 v4] add ioctl/sysfs to donate file-backed
 pages
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

If users clearly know which file-backed pages to reclaim in system view, they
can use this ioctl() to register in advance and reclaim all at once later.

Change log from v3:
 - cover partial range

Change log from v2:
 - add more boundary checks
 - de-register the range, if len is zero

Jaegeuk Kim (2):
  f2fs: register inodes which is able to donate pages
  f2fs: add a sysfs entry to request donate file-backed pages

 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++
 fs/f2fs/debug.c                         |  3 ++
 fs/f2fs/f2fs.h                          | 14 +++++-
 fs/f2fs/file.c                          | 65 +++++++++++++++++++++++++
 fs/f2fs/inode.c                         | 14 ++++++
 fs/f2fs/shrinker.c                      | 27 ++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         |  8 +++
 include/uapi/linux/f2fs.h               |  7 +++
 9 files changed, 145 insertions(+), 1 deletion(-)

-- 
2.48.0.rc2.279.g1de40edade-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
