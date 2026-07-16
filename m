Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A600C44501
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=qIYB7S9l2p3x5C0thCRcsRTYKzKaHBh3hx41iBhD08k=; b=aQs1VkcdmONkVU+6c6fpK6wwKz
	adhwHKDoV7razjTKZBVXpsUKI9wDlxf+U2r1mr3lh9sTZqfV1fuv5qSUn1keb/F99LEECtr05Da39
	4DyRqgN3RTx3sAEkpLf0MRu4pNGMQ/unVmwsYA1/GGJOXvqJcWIf/sXM1Vgr5PxSnOlE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkFsw-0006tr-RQ;
	Thu, 16 Jul 2026 06:47:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1wkFsv-0006tk-NO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 06:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DjQjYrEhMi4j0G8BsFvT1jyF4YJdoHlPTe39zu9+lEU=; b=CoJIlTG7Yrb2rbbOJ4qImOyj1o
 m9QDI/ncskkXS8SzdKZ0f90wL8QN0yRkq9WD5NGL/KUIcIGV+0774n4DtYoyxTur6ZXcTJSbCtr1v
 zqPBEJ8rxOuniZ9V0VcM4w+Jw2c6muQroQRYYhYS4tNyHp3frscguRPZfil+tiT0osaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DjQjYrEhMi4j0G8BsFvT1jyF4YJdoHlPTe39zu9+lEU=; b=S
 lfJz6SePT6yfN61DbeHQhyuoVqRCl94FsVb/EjQgRv8ormFa+X+MPkhM6uCAdVjCl9Cdu4El/kclz
 A3910mT8CzEuisJj+Nc2PPmFxxtKI6CDKT6MEKsJq15lnj+MENYC/oXi2J7DbsesjqAqJXx3nTlIS
 C4ZubUmHz0jveEJw=;
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkFst-0001iS-U5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 06:47:53 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260716064739epoutp0470188c1da15081909615aaa023aa5229~CslA1NvyB3044630446epoutp04M
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 06:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260716064739epoutp0470188c1da15081909615aaa023aa5229~CslA1NvyB3044630446epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1784184459;
 bh=DjQjYrEhMi4j0G8BsFvT1jyF4YJdoHlPTe39zu9+lEU=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=tD36nJQxqhUeNWGUMTaWIYEfvIvmS6vn4aDwbfr92CjobFlyg3Aj0412JlHJcPbJ5
 ZrsAm7W/WWL9ETWzrTTwjDEpyhvF26tEHAFk/40o1KthwxtJjmP/WKZNrxnu/yxyoP
 ZK+nZmgduSnycEJNIgNWKk1lNQMY/DMvKiYkzyZ0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260716064739epcas2p16b30ab4073bcb24b7cd34724daef1343~CslAa_Bxl0290902909epcas2p1q;
 Thu, 16 Jul 2026 06:47:39 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.208]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4h13Wb1Kn1z6B9mF; Thu, 16 Jul
 2026 06:47:39 +0000 (GMT)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f@epcms2p3>
Date: Thu, 16 Jul 2026 15:47:38 +0900
X-CMS-MailID: 20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f
References: <CGME20260716064738epcms2p36dbf1cf10ea90605610d93cc1401142f@epcms2p3>
X-Headers-End: 1wkFst-0001iS-U5
Subject: [f2fs-dev] [PATCH v3 0/2] f2fs: pack same-inode blocks by inode
 during FG_GC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

FG_GC migrates a victim section's valid blocks in source segment-offset
order, so blocks from several inodes stay interleaved in the destination
curseg and post-GC files stay fragmented.  This series migrates them in
inode order instead, producing inode-contiguous runs across the section.

Patch 1 is a pure refactor (extract do_migrate_one_data_block()).
Patch 2 records each valid block on a per-inode list in phase 3 and
drains it in inode order via pack_gc_section() once the section has been
scanned.  It is gated on a sysfs knob (gc_inode_local_packing) and FG_GC
only; on slab alloc failure a block falls back to immediate migration.

Changes since v2 (all in patch 2; the first three address Chao Yu's
review):
  - default gc_inode_local_packing to 0: the feature is now opt-in
    rather than enabled on large sections, since a new GC behaviour
    should not be on by default.
  - drop the section's queued gc_blocks on the freezing 'goto stop' path
    (new drop_gc_blocks() helper).  f2fs_gc() reuses one gc_list across
    the sections it collects in a single call, so leftover records could
    otherwise leak into the next section's pack pass.
  - expose the packing-queue drain threshold as a sysfs knob
    gc_pack_max_blocks (default 4096, minimum 64) instead of a fixed
    constant.  The ABI doc describes it as a drain threshold checked at
    segment boundaries, since the queue can transiently overshoot the
    value by up to one segment's blocks.
  - pack_gc_section() skips a queued block invalidated since phase 3
    (check_valid_map), matching the legacy phase-4 skip, so a stale block
    is neither migrated nor stat-counted.
  - queued records are freed in one place: pack_gc_section() and
    put_gc_inode() release them via drop_gc_blocks() instead of three
    copies of the same walk, and the normal-completion pack_gc_section()
    call is guarded by nr_gc_blocks so a queue already emptied by an
    early drain does not trigger a useless walk of the inode list.
  - gc_inode_local_packing's sysfs store assigns the bool directly
    (!!t), like iostat_enable/readdir_ra, instead of falling through to
    the generic unsigned-int write over a bool field.
  - drop the '+45 %' hot-rewrite iteration figure from patch 2's
    measurements: it is a wall-clock number and QEMU virtio
    bandwidth/latency is not reliable; the structural counters stand.
  - patch 1: unchanged.

Rebased onto current f2fs/dev (now includes "f2fs: embed f2fs_gc_kthread
in f2fs_sb_info"); no code change, the diff is identical to the c0b65f612
base it was developed on.

The seg_freed recompute Chao asked about is unchanged from v2: it runs
after the pack pass on all exit paths and counts already-empty segments
exactly as the legacy 'goto freed' path does (required so a fully
reclaimed section reaches seg_freed == f2fs_usable_segs_in_sec();
excluding them would re-introduce the -EAGAIN this series fixes).  Any
already-empty segment it counts feeds only the total_freed tracepoint,
not the sec_freed/-EAGAIN decision.

Changes since v1:
  - patch 2: fix seg_freed accounting (recompute after the deferred pack
    pass); without it a sync F2FS_IOC_GC returned -EAGAIN despite freeing
    space.  Clear next_victim_seg on the freezing path; bound the packing
    queue and drain in batches.  Rebased onto f2fs/dev.

Results (QEMU guest):
  - large section (-s 32, 64 x 4 MiB): post-GC extents 65536 -> 49170
    (-24 %).
  - natural FG_GC, 90 % full, 300 s hot/cold rewrite: cold-file extents
    -63 %, move_blks -18 %, skipped_gc_rwsem -59 %.
  - seg_freed regression test: packing matches the legacy path
    (seg_freed 152, sec_freed 38, 24/24 sync ioctls succeed).
  - gc_pack_max_blocks partial-drain test (cap=64, large section): the
    drain fires ~1.5k times in one section yet seg_freed still matches
    the legacy path (384 == 384), integrity preserved.
  - regression suite on this tree: clean dmesg, sha256 preserved;
    gc_pack_max_blocks validates its bounds and gc_inode_local_packing
    defaults to 0.

Daejun Park (2):
  f2fs: extract do_migrate_one_data_block() helper for GC migration
  f2fs: pack same-inode blocks by inode during FG_GC

 Documentation/ABI/testing/sysfs-fs-f2fs |  20 ++
 fs/f2fs/f2fs.h                          |   9 +-
 fs/f2fs/gc.c                            | 302 +++++++++++++++++++-----
 fs/f2fs/gc.h                            |   5 +
 fs/f2fs/super.c                         |   2 +
 fs/f2fs/sysfs.c                         |  16 ++
 6 files changed, 297 insertions(+), 57 deletions(-)


base-commit: 6429f3bf6dc33cba42055260f905559c43976eeb
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
