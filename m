Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A01CA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O4vD5Z6Y6bRlEhcOO9CU33V0N9ClrkpzYT+70ekJN3Y=; b=cMPSyWBVo1Ru1oQfcq8bBYEcr6
	BPS4qqeBuE2E/SpCsMfAZrXHqjOun0nIBBakBKu9UYKtGvxrQOTNA/+BXCaSQETljkXjvdxTJh1ck
	zFJfX8SzfkA/S4LK/Rz5YgzeW7l6D/7nxHXssyPbOuvrKmhQFmxCyZ8ivzQeEvF6kHv0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDDy-0003j3-Qu;
	Fri, 09 Oct 2026 16:13:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDDr-0003is-HD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=obtqnRZ2XT3fd0RMFoXHVLYidnghgsTYsU6R43rdvKw=; b=nQzpUKlndd8Utdp9ud81rqWAcX
 IMtMz7ABCUQg42opW7LDPNUNjpYdNf/ofYHwU3kO7+RL928jOP4/k8s/vh0CqY31LaeOS9hRkeEez
 W544fisYhxfhCN5PuFszq8PE7lEdTH8bssG6KbADdNVngk9Hpc6/ddF4abdO7fRsfD04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=obtqnRZ2XT3fd0RMFoXHVLYidnghgsTYsU6R43rdvKw=; b=S
 czD4+B9pOp/U2e6qCRmN721K1ZlbZdoMU/LtsoODN+uQwt15ElSn+PVNpPitYDwjWRz58bWEcwjok
 2UHLaiFyiuuvfDBpGt8j7TMXvVj2SGuSYOxAe8YQEVHTTnySWCHSQM0vg/KueiTm/Nri8UOdeNUi2
 ji5wp2qPPjhJ7USs=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDDq-00055G-A0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ob
 tqnRZ2XT3fd0RMFoXHVLYidnghgsTYsU6R43rdvKw=; b=Oeydw+lDJ7WU6Fv0xI
 wmMo5NRjyOdPzI9Y7XlzcmDqlGcByoUiXf4L0J2w03rA64oeFdDVC1xjHjTaqL1e
 KEpzMCg4huju+RZ0Jod1AZ9UZuawRSDYRyI9UUDSytyeAfvCqRcEq98CJ1hyOjzW
 PlLZCLizbACIGoKeAKMxI5bCY=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3V46AEslqHAsZBA--.38226S2; 
 Sat, 10 Oct 2026 00:12:49 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:12:07 +0800
Message-ID: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V46AEslqHAsZBA--.38226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4DZFWDXryrCw4Dur1kuFg_yoW5Xr1xpF
 WYkrZ5GryfGr47ZrsrA3WFqrnYq3yrG347ua4xXryIqFn8WF1ruF1kK3Z5XFyxJryxJw4f
 ta1UAry8WF1rJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCsjbUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAGxgWrJEoE9CQAA3F
X-Headers-End: 1xFDDq-00055G-A0
Subject: [f2fs-dev] [PATCH v3 00/17] f2fs: support & optimize large folios
 for writable files
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series supports large folios for most readable/writable files
in buffered I/O paths, including normal files, block-layer encrypted
files, and atomic files except for inline-data files, compressed files,
and quota files.

It also extends f2fs_folio_state to coexist with f2fs page-private
flags and to handle large folio write path and partial truncate of
large folios correctly.

Benchmark details can be found in the RFC v2 cover letter [1].

Changes in v3:
- Addressed the remaining review comments from Chao and Daeho; the
  fixes are folded into the corresponding patches.
- Added "f2fs: account large folio dirty data at block granularity" to
  fix the f2fs/006 and generic/363 regressions.
- Added "f2fs: wait for folio writeback before ffs_detach_free", fixing
  a use-after-free in the full-range invalidation path reported by the
  kernel test robot [2].
- "f2fs: remove mappedtodisk flag usage in mmap write path" is now
  included in the series as a prerequisite.
- Link to v2: [3]

Many thanks to Chao and Daeho for your extensive reviews and valuable
suggestions!

[1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
[2] https://lore.kernel.org/linux-f2fs-devel/202610081027.b13dcf10-lkp@intel.com/
[3] https://lore.kernel.org/r/20260915041909.2903887-1-zhaonanzhe@xiaomi.com

Nanzhe Zhao (17):
  f2fs: extend folio state for large folio write path
  f2fs: carry subpage offset and count in write IO
  f2fs: support regular file buffered writes on large folios
  f2fs: support atomic file large folios buffered write
  f2fs: support large folio writeback
  f2fs: account large folio dirty data at block granularity
  f2fs: remove mappedtodisk flag usage in mmap write path
  f2fs: prepare mmap write faults for large folios
  f2fs: make GC migration large-folio aware
  f2fs: optimize small block size large folio read
  f2fs: support partial uptodate large folio read
  f2fs: handle partial truncate of large folio dirty subpages
  f2fs: wait for folio writeback before ffs_detach_free
  f2fs: fix zeroing paths for large folios
  f2fs: handle block cloning within the same large folio
  f2fs: allow large folio support to writeable files
  f2fs: make compressed files compatible with large folio

 Documentation/filesystems/f2fs.rst |   10 +
 fs/f2fs/checkpoint.c               |   40 +-
 fs/f2fs/compress.c                 |    3 +
 fs/f2fs/data.c                     | 1333 +++++++++++++++++++++++++---
 fs/f2fs/f2fs.h                     |  170 +++-
 fs/f2fs/file.c                     |  230 +++--
 fs/f2fs/gc.c                       |   38 +-
 fs/f2fs/inline.c                   |    7 +
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/segment.c                  |    5 +-
 11 files changed, 1588 insertions(+), 253 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
