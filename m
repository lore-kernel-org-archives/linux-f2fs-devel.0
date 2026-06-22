Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72735CDB478
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tkOyBmEtJVvBiSuK1Z4TnnUeud7IWu5JekVO6VlXXKQ=; b=SzTL/jOFgu5j1dWoblk+0ULVSQ
	1SOccEk7YrQH91XQTWckgJL289bxfwV5qXplXjiBn8C4jGAtREJ+wa/qjZCVvEk5dph8P1HAr1wS+
	nBcRSXs/FOwbHZCk3uTEaUZknGEkzh5yZr+32c9n0jV86+WIm0fuXf6RJCT+aeUEwk88=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbhD4-0005tm-Eh;
	Mon, 22 Jun 2026 16:09:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wbhD1-0005tH-SX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fA5pdjQGxqQLmchzGevrBqweq+67KoIJ9kOJNYtOLig=; b=YmwT//l/1VGt/8gNbfJaAbLa3I
 0rR6YfoNuuXOLO39Id5NL2Th6OVTGHYVUU1pG0dYPuLwJVoOA+pHBAdkRXRJ3+5eVq1eOLv4sH6l3
 sh72qCueDUXXeU4wpzZ7M1yXuogVERMGwDrAkF6smD1ygB29ZE+07yffUi1g0Nrdwxms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fA5pdjQGxqQLmchzGevrBqweq+67KoIJ9kOJNYtOLig=; b=R
 yCUT47hk4suuKnYHlRrd2yzR68mSIlZxYCEhKX7/776DLeix8tN0q+1EKALqO/wgC0lG8zLvpmPeQ
 NVazEBzILgSgc4h9WC7nbI2/BkQ6n43+FQRcyBR0SamRiNxy1+JFbayKQOZrZNdVTxBHivEfiFNMc
 svCA9SPKsYNIgBNM=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbhD1-0001AX-4S for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fA
 5pdjQGxqQLmchzGevrBqweq+67KoIJ9kOJNYtOLig=; b=FslNtQ14GTkBy5B1eo
 rNTDflpHui/ZOgNffa8zU9bw2VtodI0XwjFMBhGuFvl1N6UYOtbQRwDIWmGQL9vV
 RzTP1yQ9PKiccK5k712IAhtBeKQFVS4JlyhiQ7L6+invlm2KKlf2pUq5+LmxVGpQ
 BVJNYgqY/VgaDtG328HczO0zY=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAXfIP+XTlqz32SBw--.54996S2; 
 Tue, 23 Jun 2026 00:08:32 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 23 Jun 2026 00:08:20 +0800
Message-Id: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wAXfIP+XTlqz32SBw--.54996S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWktw1fXFW7Zr1xJr4xJFb_yoWrZF47pF
 yakr1fGr4fJr1xAr13Aw1Utr15CFW8GF17Xa9rGFyIq3WUAr1rAF40qFyrW34UJryxJr10
 qw4UA348W3WDtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCoGdUUUUU=
X-Originating-IP: [39.144.78.181]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsACAUGo5XgDcagAA3b
X-Headers-End: 1wbhD1-0001AX-4S
Subject: [f2fs-dev] [RFC PATCH v2 00/10] f2fs: support & optimize large
 folios for writable files
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <nzzhao@126.com>

Make some clean up based on v1, and support minimum folio orders 
beyond zero.

This RFC series supports large folios for most readable/writable files in
buffered I/O paths, including normal files, block-layer encrypted files,
and atomic files. Compressed files are still excluded.

Atomic files need explicit support here because Android enables atomic
writes through ioctls, which mark the inode as an atomic file
(FI_ATOMIC_FILE). Once large-folio mapping is enabled for such a file,
the atomic buffered write path also needs to handle large folios
correctly.

In the write path, allocating f2fs_folio_state for large folios starts
to conflict with f2fs page-private flags. This RFC series extends
f2fs_folio_state so that it can also store f2fs private flags, and
updates the existing PAGE_PRIVATE helpers to work correctly with
f2fs_folio_state.

In addition, fio results with max large-folio order set to 2 showed
that 4K read/write performance did not improve much.
Analysis showed that one important reason was the extra spinlock traffic
from incrementing read_pages_pending once per 4K subpage.
This RFC series therefore adds two optimizations to
f2fs_read_data_large_folio:

1. batch read_pages_pending updates by the mapped block count instead of
   incrementing it once per 4K subpage;

2. skip f2fs_folio_state allocation when a single block mapping / BIO
   covers the whole folio, because folio_end_read() can complete such a
   folio without extra per-folio state.

In the benchmark tables below, "skip=1" means enabling the second
optimization above, i.e. skipping f2fs_folio_state allocation for the
whole-folio-in-one-bio case.
The "batch" optimization refers to updating read_pages_pending in
and add to bio in larger chunks instead of once per subpage.

Test environment:
- Device: Pixel 6 (device1A, 1A071FDF600053)
- Filesystem: f2fs on dm-49, inlinecrypt enabled
- File size: 256MB
- Repetitions: 10
- Prepare: end_fsync + sync + drop_caches
- Fio: psync, direct=0, iodepth=1
- Max folio order: 2

Table 1: HOLE_READ (10 repeats)
------------------------------------------------------------
All bandwidth numbers are in MiB/s. Non-baseline entries show the
absolute value followed by the percentage delta relative to the
order=0 baseline in parentheses.

| bs  | order=0 | order=2 |
|-----|---------|---------|
| 4k  | 469.6   | 521.9 (+11.1%) |
| 64k | 668.1   | 852.4 (+27.6%) |
| 1M  | 653.0   | 867.2 (+32.8%) |

Table 2: DATA_READ (10 repeats)
----------------------------------------
| bs  | order=0 | batch=0 | batch=1,skip=0 | batch=1,skip=1 |
|-----|---------|---------|----------------|----------------|
| 4k  | 441.6   | 456.5 (+3.4%) | 499.7 (+13.2%) | 544.4 (+23.3%) |
| 64k | 632.8   | 697.0 (+10.1%) | 837.8 (+32.4%) | 990.9 (+56.6%) |
| 1M  | 601.5   | 733.0 (+21.9%) | 927.5 (+54.2%) | 963.4 (+60.2%) |

Table 3: WRITE (10 reps)
----------------------------------------------------------
O = overwrite (N = new write, Y = overwrite)
S = sync / fsync (Y = fsync enabled, N = no fsync)
W = writeback (Y = background writeback, N = no writeback)

| O,S,W | bs  | order=0 | order=2 |
|-------|-----|---------|---------|
| N,N,Y | 4k  | 263.4   | 286.3 (+8.7%) |
| N,N,Y | 64k | 683.5   | 1199.6 (+75.5%) |
| N,N,Y | 1M  | 767.4   | 1383.8 (+80.3%) |
| N,Y,N | 4k  | 10.8    | 9.1 (-15.7%) |
| N,Y,N | 64k | 69.3    | 50.3 (-27.4%) |
| N,Y,N | 1M  | 103.5   | 157.8 (+52.5%) |
| Y,N,Y | 4k  | 301.6   | 344.1 (+14.1%) |
| Y,N,Y | 64k | 691.3   | 865.9 (+25.3%) |
| Y,N,Y | 1M  | 742.3   | 969.2 (+30.6%) |
| Y,Y,N | 4k  | 9.5     | 17.1 (+80.0%) |
| Y,Y,N | 64k | 43.5    | 108.2 (+148.7%) |
| Y,Y,N | 1M  | 140.9   | 146.6 (+4.0%) |

Nanzhe (9):
  f2fs: extend folio state for large folio write path
  f2fs: carry subpage offset and count in write IO
  f2fs: support regular file buffered writes on large folios
  f2fs: support atomic file large folios buffered write
  f2fs: support large folio writeback
  f2fs: prepare mmap write faults for large folios
  f2fs: make GC migration large-folio aware
  f2fs: allow large folio support to writeable files
  f2fs: optimize small block size large folio read

 fs/f2fs/compress.c |    2 +
 fs/f2fs/data.c     | 1015 +++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/f2fs.h     |   75 +++-
 fs/f2fs/file.c     |   81 ++--
 fs/f2fs/gc.c       |   30 +-
 fs/f2fs/inode.c    |    6 +-
 fs/f2fs/segment.c  |    4 +-
 7 files changed, 1064 insertions(+), 149 deletions(-)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
