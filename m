Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA31CD5BA4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 May 2026 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=uq7MLAu3ZUDlcqBmBOfQDRiYqLBHoUd0KqmtbNEI/Vs=; b=OYHa1zDRVPTQgRnMYGoB8VQ8//
	Cr61ZQllcO+thMRkYcbJOh+AYmIhL0zXyWOhQ9hTjVEJwGR6C3n5XWE/pYxZpvpf6fgIpA11avKWM
	GrF6zHkYGWjHHGwoOYL77L/AhhuiHaJbfyC93cZMJ/45Y4gsEJF54u6yyNDqLLIvsHk4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPHom-00015w-5S;
	Tue, 19 May 2026 10:36:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1wPHok-00015q-7V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 May 2026 10:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ITjxJFlo3/G/d8mrY8XNrl6Cr/+2DRZhbzOTbiFgacA=; b=dB3BkBoBNEssfqoIhA0JhUaa8Y
 RX+GeeLQ+PEDINLe2pqLerMZQQLvN/UrLNlC5OLdazI98sGF4BO2ZdKlBB1H/ROiL4Pl/x4/nvx2f
 eGuKjytmCmBUzpz52kNJ/boegcMo15vrcPaatPg4IYSBzoTIVUsWyGvL5Ho79Ll9WBmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ITjxJFlo3/G/d8mrY8XNrl6Cr/+2DRZhbzOTbiFgacA=; b=k
 9hAO0JzN7DpHUd+mJz7eYBRH7HC3+oSXnCRjYZgmUf6oYgsBZfxW7hEBk2YEe/9Iu6/aWqZ8CIWtW
 Ltq4WL+NBXLByZIvBCcqO7+eTvpdw/XSo2mc6Twnrag1XwC9LAiC91ko7VjfiAhF+OCt1z3k9/ir2
 6FqAooq0rNxJXofw=;
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPHoi-0004KZ-Sw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 May 2026 10:36:54 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260519101957epoutp030a7f1c08ddddff1c14702d5e93f3b7b2~w8D0VFG1U0697006970epoutp03j
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 19 May 2026 10:19:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260519101957epoutp030a7f1c08ddddff1c14702d5e93f3b7b2~w8D0VFG1U0697006970epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1779185997;
 bh=ITjxJFlo3/G/d8mrY8XNrl6Cr/+2DRZhbzOTbiFgacA=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=NmYr5ZPgQgMCbDBfoTimF+HCHAwYGAv9IFa30sZXVOdttg0JPz2/6dMmU9tyZLvzV
 Ei9TIHA3Nc1ZcOUwSC54hW7rHUgwiKkJ9Bnbd7XchhSLDxiq6TwDguKNBIgfcqL+XM
 PUa3xhqS/egx1wQKx7IVtGV0alAhJDYfJgfT4eVs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20260519101957epcas2p252a17804ef2e549a0c573b28c0facfe9~w8DzqGzMh1724417244epcas2p2C;
 Tue, 19 May 2026 10:19:57 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.204]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4gKVzJ6Qn7z2SSKY; Tue, 19 May
 2026 10:19:56 +0000 (GMT)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260519101956epcms2p47a6225e24691bad1a88ca0d9e527d9dc@epcms2p4>
Date: Tue, 19 May 2026 19:19:56 +0900
X-CMS-MailID: 20260519101956epcms2p47a6225e24691bad1a88ca0d9e527d9dc
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260519101956epcms2p47a6225e24691bad1a88ca0d9e527d9dc
References: <CGME20260519101956epcms2p47a6225e24691bad1a88ca0d9e527d9dc@epcms2p4>
X-Headers-End: 1wPHoi-0004KZ-Sw
Subject: [f2fs-dev] [PATCH 0/2] f2fs: pack same-inode blocks by inode during
 FG_GC
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
Reply-To: daejun7.park@samsung.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

This series teaches FG_GC to migrate a victim section's valid blocks in
inode order instead of source segment-offset order, so destination
curseg writes form inode-contiguous runs that span the whole victim
section.  The end result is a measurable drop in post-GC file
fragmentation (filefrag total extents) on large sections.

Patch 1 is a pure refactor: it lifts the per-block migration body
(lock acquisition, move_data_{page,block}() dispatch, rwsem release,
stat update) out of gc_data_segment() into a do_migrate_one_data_block()
helper, and lets add_gc_inode() return the inserted inode_entry pointer.
Patch 2 is the actual packing change: it hangs a per-inode gc_blocks
list off the inode_entry created in phase 3, then drains it once per
section via pack_gc_section() after every source segment has been
parsed.

Activation conditions:
  * sbi->gc_inode_local_packing == true.  Exposed as a sysfs RW knob,
    default derived from __is_large_section(sbi).  Sysfs writes other
    than 0 or 1 are rejected.
  * gc_type == FG_GC.  BG_GC's move_data_page() path defers destination
    allocation to the writeback flusher, so reordering applied during
    GC would be lost.

The packing snapshot is taken once per do_garbage_collect() into a
local 'pack_by_inode' bool and threaded through gc_data_segment() and
pack_gc_section() so a concurrent sysfs toggle cannot make phase 3
enqueue blocks that pack_gc_section() then skips.

Per-block records use a dedicated f2fs_gc_block slab
(SLAB_RECLAIM_ACCOUNT via f2fs_kmem_cache_create); on a fully valid
64 MiB section (SEGS_PER_SEC=32) one section can queue up to
SEGS_PER_SEC * BLKS_PER_SEG records (~512 KiB at 32 B per gc_block).
On gc_block alloc failure the block falls through to the legacy
phase 4 'goto do_migrate' body, so FG_GC progress is preserved under
memory pressure (the very condition that triggers FG_GC).

Measurements (QEMU virtio guest, 4-cycle fragmentation harness,
gc_urgent 40 s):

  Large section (-s 32 = 64 MiB, 64 files x 4 MiB):
    legacy   65536 -> 65536  ( 0 % reduction)
    packed   65536 -> 49170  (24 % reduction)

  Default section (-s 1 = 2 MiB, 128 files x 256 KiB):
    legacy    8192 ->  8192  ( 0 % reduction)
    packed    8192 ->  7690  ( 6 % reduction)

  Natural FG_GC under tight cold migration
  (-s 32, 2 GiB disk 90 % fill, 6 hot x 200 MiB + 6 cold x 100 MiB
   interleaved, background_gc=sync, 300 s hot rewrite):
    legacy   cold extents 350 -> 357 (+7,  no improvement)
    packed   cold extents 350 -> 132 (-218, -63 % reduction)
    move_blks        legacy 42344  packed 34822  (-18 %)
    skipped_gc_rwsem legacy 108    packed   44   (-59 %)
    hot rewrite iters in fixed 300 s window: +45 %

Daejun Park (2):
  f2fs: extract do_migrate_one_data_block() helper for GC migration
  f2fs: pack same-inode blocks by inode during FG_GC

 Documentation/ABI/testing/sysfs-fs-f2fs |  10 ++
 fs/f2fs/f2fs.h                          |   7 +-
 fs/f2fs/gc.c                            | 218 ++++++++++++++++++------
 fs/f2fs/super.c                         |   1 +
 fs/f2fs/sysfs.c                         |   7 +
 5 files changed, 187 insertions(+), 56 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
