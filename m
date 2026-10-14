Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B696CC6B2A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ktqSkuUa3pCQu1AoYLqUp6kgqzs1m5QzwxHC4XsXkg=; b=Hi14Zisn8v5oxdgk+cCSsllNmP
	wCo2aUPtMJUwH8Lw4rLK/U2OjS5EVlBIjp2NwJ2DJe5sB7kA6MllBUjp5mRcKoGfekDhQhjSRs0Sh
	MlOizPgaa3oGPcx4p7hDKuxM3HzSdU/mZc3OQ6TfDdLpUPZqY1lVb8HctwVmcLu7AmuE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH8Jo-0006Lt-Ip;
	Wed, 14 Oct 2026 23:23:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xH8Jn-0006Lm-Lc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 23:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K4Is1qFyFVz8EUcqjtlhLvy1hm5i6s8uM3AIuoRnppA=; b=XvZkP8f6VkNYV4ZsCPyfKZHk6r
 OV2p+5nvMycKnp0wNFY56vXKEd1woQs3g+ucrh7KjNJqVbTyyqmZAtb2HCNt7AB/1kBIXqWz4Z1Vx
 V69SGkAPmF6jDFOTf9XghtEbUIP4/vL3PgBYxhicdswa0egHrTFSDGOhxBkj7B+5dT7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K4Is1qFyFVz8EUcqjtlhLvy1hm5i6s8uM3AIuoRnppA=; b=WXwPqxW/7B86T0IHO+f1iOyoLI
 4PsUNIgCi19Zu6dYNQlzgtdmjBXaO/ltK/m6lgBFviRhQFNthJiTv7kP6Bp219Sm5ZzBNMxPi7/8P
 X4JV12Ivzmseb2z30BIti1cH4w0eKWfK6GKWNApE1nMpnwIoC1xnIQXYDOEx4fyWc7uo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH8Jn-0005v6-DL for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 23:23:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 096DE4037D;
 Wed, 14 Oct 2026 23:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBCA1F000C4;
 Wed, 14 Oct 2026 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792020205;
 bh=K4Is1qFyFVz8EUcqjtlhLvy1hm5i6s8uM3AIuoRnppA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YbfRVDpPlUyiByGw1vvj04z7Sck319oFlFCg8aqc1vNms4RnDRhzsZyg1g5OJjQEv
 LwREEUA9k4yYg+w3fcZe7EZ9fghFCPqHlDsYXZ5Ypk1dNTqUfj8+5qDqTIQzTnB3Lt
 4/ztFBJj2hOsBL3ZKFqu91DZKSl2AEP+rJuL3N5jtGwv6TGyweLRKabx5f80AVcmYh
 Ormh9TeU8XwFBbRq9lk3jMjBVMrFagSRmLTK/IXHgJ+xhNw/3gbtbrvV1IDKmVXGXB
 AJLw2Zj5gDYy4nMlfy5W8GRK2A03IXq29yvxbAp/28yDycJpDN0xYYmlF+TC7GxdPk
 qY4puLslkO2Bg==
Date: Wed, 14 Oct 2026 23:23:23 +0000
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Message-ID: <atAO6ykqwGgZq77y@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xH8Jn-0005v6-DL
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Nanzhe,

Could you please check IO submission path for Zoned block device?
I hit this.

[   93.100225] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.100420] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.100551] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.100948] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.101432] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.101762] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.101907] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.102564] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.103054] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.103447] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.103667] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.104294] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.104373] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.104449] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105220] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105253] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105532] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105575] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105606] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105781] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.105985] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.106192] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.106692] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.106799] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107015] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107090] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107113] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.107268] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107288] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.107499] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107511] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.107707] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107724] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.107770] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107781] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.107929] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.107941] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.108040] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.108050] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.108166] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.108179] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.108322] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443312; zone offset 19056; I/O scheduler (none); rq 00000000653b6a70 {.op=WRI
[   93.108341] sd 0:0:0:4: Retrying unaligned write for zone 2639; offset 259443320; zone offset 19064; I/O scheduler (none); rq 00000000ea98b61b {.op=WRI
[   93.108582] sd 0:0:0:4: [sde] tag#31 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte=DRIVER_OK cmd_age=0s
[   93.108588] sd 0:0:0:4: [sde] tag#31 Sense Key : 0x5 [current]
[   93.108595] sd 0:0:0:4: [sde] tag#31 ASC=0x21 ASCQ=0x4
[   93.108605] sd 0:0:0:4: [sde] tag#31 CDB: opcode=0x8a 8a 00 00 00 00 00 01 ee d9 4e 00 00 00 01 03 00
[   93.108607] critical target error, dev sde, sector 259443312 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
[   93.108612] sde: zone 2639: Aborting plugged BIOs
[   93.108626] CPU: 1 UID: 1000 PID: 1831 Comm: CachedAppOptimi Tainted: G        W  O       6.12.81-android16-6-maybe-dirty-4k #1 de5ea2c0fc3867082493fabcae9896176e2e435e
[   93.108630] Tainted: [W]=WARN, [O]=OOT_MODULE
[   93.108631] Hardware name: KODIAK DVT 1.0 based on MALIBU (DT)
[   93.108632] Call trace:
[   93.108633] dump_backtrace+0xec/0x128
[   93.108641] show_stack+0x18/0x28
[   93.108645] dump_stack_lvl+0x40/0xb8
[   93.108649] dump_stack+0x18/0x28
[   93.108652] f2fs_stop_checkpoint+0x1f0/0x2d8
[   93.108654] f2fs_write_end_bio+0x50/0x694
[   93.108657] f2fs_write_end_io+0x80/0x94
[   93.108660] bio_endio+0x114/0x224
[   93.108662] __dm_io_complete+0xf4/0x278
[   93.108665] clone_endio+0xc0/0x26c
[   93.108669] bio_endio+0x114/0x224
[   93.108671] blk_zone_write_plug_bio_endio+0x104/0x334
[   93.108674] bio_endio+0x160/0x224
[   93.108676] blk_update_request+0x17c/0x218

On 10/14, Nanzhe Zhao wrote:
> This series supports large folios for most readable/writable files
> in buffered I/O paths, including normal files, block-layer encrypted
> files, and atomic files except for inline-data files, compressed files,
> and quota files.
> 
> It also extends f2fs_folio_state to coexist with f2fs page-private
> flags and to handle large folio write path and partial truncate of
> large folios correctly.  A valid large folio always carries a
> f2fs_folio_state at its folio->private in the current implementation.
> 
> Benchmark details can be found in the RFC v2 cover letter [1].
> 
> Changes in v5:
> - Rebased onto the f2fs dev-test branch (d1685c24b6c3).
> - Dropped the two prerequisite bug fixes, which are now merged:
>     c04f209773ec ("f2fs: read i_size once in f2fs_vm_page_mkwrite")
>     b3c984358925 ("f2fs: remove mappedtodisk flag usage in mmap write path")
> - Link to v4: [2]
> 
> Many thanks to Chao and Daeho for your extensive reviews and valuable
> suggestions!
> 
> [1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
> [2] https://lore.kernel.org/linux-f2fs-devel/20261013115621.968742-1-nzzhao.sigma@gmail.com/
> 
> Nanzhe Zhao (16):
>   f2fs: extend folio state for large folio write path
>   f2fs: carry subpage offset and count in write IO
>   f2fs: support regular file buffered writes on large folios
>   f2fs: support atomic file large folios buffered write
>   f2fs: support large folio writeback
>   f2fs: account large folio dirty data at block granularity
>   f2fs: prepare mmap write faults for large folios
>   f2fs: make GC migration large-folio aware
>   f2fs: optimize small block size large folio read
>   f2fs: support partial uptodate large folio read
>   f2fs: handle partial truncate of large folio dirty subpages
>   f2fs: wait for folio writeback before ffs_detach_free
>   f2fs: fix zeroing paths for large folios
>   f2fs: handle block cloning within the same large folio
>   f2fs: allow large folio support to writeable files
>   f2fs: make compressed files compatible with large folio
> 
>  Documentation/filesystems/f2fs.rst |   10 +
>  fs/f2fs/checkpoint.c               |   40 +-
>  fs/f2fs/compress.c                 |    7 +-
>  fs/f2fs/data.c                     | 1467 +++++++++++++++++++++++++---
>  fs/f2fs/dir.c                      |    2 +-
>  fs/f2fs/f2fs.h                     |  170 +++-
>  fs/f2fs/file.c                     |  226 +++--
>  fs/f2fs/gc.c                       |   38 +-
>  fs/f2fs/inline.c                   |    9 +-
>  fs/f2fs/inode.c                    |    4 +-
>  fs/f2fs/namei.c                    |    1 +
>  fs/f2fs/node.c                     |    2 +-
>  fs/f2fs/segment.c                  |    5 +-
>  13 files changed, 1716 insertions(+), 265 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
