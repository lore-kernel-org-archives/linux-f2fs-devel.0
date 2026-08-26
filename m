Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CFC61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TDyp+p4wF+4efZ5UKwf6TRPABlsNHJ6cb0ViKZhMIZo=; b=Em+/pNL+CtnGFYyrHll/99LdS9
	GukxFcaiioBG7NaStvps39gApU9i1AHnD63UDOJqdQasVlywj9bwQEQuu9+h9wo2748/nn3IrSzNv
	Izg7IhKYAE+og3jYqW1PcScwXNC+ZbXeaKO4Xq8GJq+hjHWsSwh8C4PKoxMhgUyDdd/U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz8yg-000240-EL;
	Wed, 26 Aug 2026 08:27:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wz8yd-00023j-UF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2yus/qc3WcLDwjNxhHVemBWHQVT/eoHFTGY5p5sm5WY=; b=EppWG+6fmujy/h9/Di8uQFMLoA
 CvWwxvL3oP4l3ICKmx/EKc8qVq9TbARLp7GkjTxJrTAww2d+ihnHw4s4ifWOVhGMD4vBObE8nQ6fU
 f9fB9vD54qz9MI0IlYNPcUlh9YJCy+o79EPww7u+Izj4ZFoPIVL7nE8Ok5UHcBsySTp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2yus/qc3WcLDwjNxhHVemBWHQVT/eoHFTGY5p5sm5WY=; b=e
 vgfvgn8mq5YsaWDfJe41odsJd0pB3vHKewKpQ0wqpW1wBjzRB5FGwdvuuu2ges0F9swA+3ikAOBGK
 RQKyUWrg6xNLNDYbXa3Icqk9jOlsKIckvv8qzJEF9ijbolgVUZs+I1V6QU+DZ7u8vph8ieeITbb9F
 00LJ2pVR0lFfv7lA=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz8yb-0002gx-Ea for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2y
 us/qc3WcLDwjNxhHVemBWHQVT/eoHFTGY5p5sm5WY=; b=QhGDZRx978XzuqY0d+
 Ffz7P8CPN0IdotE8kc0SBLO5JyEGykS9XYY5NpG9o+Jg5I7tZpN2CzAo0wHxHQbi
 DPP41xfxgK1ug2TBwsE2+ZX4MW4ek2EZzzCHYCnC+uO+of3B/WQcBZePPZT+WnMv
 Kko1WMNDT/5Dz74+Dvv/5Sd9s=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3F29Bo45qLzIoGQ--.14929S2; 
 Wed, 26 Aug 2026 16:26:42 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 16:26:27 +0800
Message-ID: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F29Bo45qLzIoGQ--.14929S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyxur15WrW5JF13WrWDCFg_yoW8WF1rpF
 yYkrZ5GryfCr43Zr9xAF1rtrn8t395G347Za4xXry2qFn8Wr1rWF1kt3W8WF4xJr1fA3yr
 ta1UAry8WF45JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCoGdUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAI3B2qOo0JdxAAA3e
X-Headers-End: 1wz8yb-0002gx-Ea
Subject: [f2fs-dev] [PATCH 00/14] f2fs: support & optimize large folios for
 writable files
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
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

Benchmark details can be found in the v2 cover letter [1].

[1] https://lore.kernel.org/linux-f2fs-devel/20260622160830.324455-1-zhaonanzhe@xiaomi.com/

Nanzhe Zhao (14):
  f2fs: extend folio state for large folio write path
  f2fs: carry subpage offset and count in write IO
  f2fs: support regular file buffered writes on large folios
  f2fs: support atomic file large folios buffered write
  f2fs: support large folio writeback
  f2fs: prepare mmap write faults for large folios
  f2fs: make GC migration large-folio aware
  f2fs: optimize small block size large folio read
  f2fs: support partial uptodate large folio read
  f2fs: handle partial truncate of large folio dirty subpages
  f2fs: fix zeroing paths for large folios
  f2fs: handle block cloning within the same large folio
  f2fs: allow large folio support to writeable files
  f2fs: make compressed files compatible with large folio

 fs/f2fs/compress.c |    2 +
 fs/f2fs/data.c     | 1270 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/f2fs.h     |  123 ++++-
 fs/f2fs/file.c     |  191 +++++---
 fs/f2fs/gc.c       |   30 +-
 fs/f2fs/inode.c    |    4 +-
 fs/f2fs/namei.c    |    1 +
 fs/f2fs/segment.c  |    5 +-
 8 files changed, 1431 insertions(+), 195 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
