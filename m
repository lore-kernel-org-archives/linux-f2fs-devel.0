Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B29606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KB/uWP0k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iAUFKdi9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LZHr6qOn;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gpv53jzV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Gf9PPyMuPED7Hm2pMujQcRQ88/vbhMeNSBFaL2uJK0c=; b=KB/uWP0kowAQQv+W9xCff9kfG2
	6eveyhAodWW0AHaTZQVYdwPwyBoBwPhkZ5/GiDRQEmkhjUoTUcoEcx/JwE8uynQWZppgmD3DiIhqR
	sfM5sRxRLRdlbtbd5yhbCguWTXkTawbNA/zdM3LzEwscfatPKrn5mGmblnfwjhCRA2UE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXL-000000004k5-2qHx;
	Mon, 26 Oct 2026 03:38:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBX4-000000004jT-2301
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6sJ2KHYM+5cJSsULiN40H3/x+SoySCXlIwoNkQYZhU=; b=iAUFKdi92ns8Yn+grRqbdpd8eP
 tezJZNvRbqHwe3eUDvIN4QLgjgWjABV/s6aE25ANv8Q/XF1vFYpVyBurWd2Q73Z++sBxtIaiPW7rj
 2gurhl2enHEIb1HgJh/ljzNBal/wkfX89x578ouBp93RaqP1crVeach/KzXnh4UDLK2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g6sJ2KHYM+5cJSsULiN40H3/x+SoySCXlIwoNkQYZhU=; b=LZHr6qOnlWpx+yKWR1PYvowz8t
 5kB70bNG35RgbVDJI7bva3IloKFh+EsP4D+7FIw7jLchShxA93s9jrgjFFf32S/Q8SlHPspgp/aUD
 z44EVpqNuh2DBuJFLB7Kl4l8glCjFAqOZX7AyY+YQZiv35940T4RgWyaeATX6dQSArho=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBX3-000000000eK-3k0V
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:37:58 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3ac803d3bafso144442a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985872; x=1793590672; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g6sJ2KHYM+5cJSsULiN40H3/x+SoySCXlIwoNkQYZhU=;
 b=Gpv53jzV08e1oaCJum/8JhfzmY9Fzg6rzu/azGwSLXbVpQq7sNm8BQ2iOoUGBxNlGY
 b1MQixkzkLpjYdeTCBqxPrqw0NyfUnrR4uTQGwLOe8wZpzjtLQ9thBS4XhHbHJsTmKXC
 7/N8hVuealNFkox46OPIp5H/3fMxGxTjJvUGCblJL5EBVpTgvbg7SwE/b0CnO5/Bn49c
 QZ3dBQUK+2Ph4QRChVw0gFYdXbk/JcEmS6MZNglsz+x9rgg8ZGKq8b2pQYZiFIOysT5u
 ASIwHxg2eFBSVH3jOOZcfT0bbX5iE0nwGKIp7/Em7zBoGDOqRge5ucISkw1do1QdLHfg
 /Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985872; x=1793590672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g6sJ2KHYM+5cJSsULiN40H3/x+SoySCXlIwoNkQYZhU=;
 b=FddksjFxlC3RJj2pf9ccovUqTKVqENJAytlQd1S532CKAK+Nh34LOZTAWlEsJqjqqJ
 FZW2yWP63/fqOlu2EF7qrnPIFnE/uUZabpXsyULl1ybdqvoOlGQB/GwevVAXir5spi+v
 FYUQiTJbHmqS860FyAR+ToH1Z49/faXuubQ7AEHI5Famj1Mv4krdpxeRrW3oP+EB1W6B
 lANtKd0iQsAfFQ4RXtlqQNQ3jee6Z85e58+CwqQkbC6qVkOB6wJjr3EqRHygdqXqGTMp
 O5sXVhqi52cW98UovIx9pBi7BxDVaXP0jvlY9nvcjl1Xf5RQGFlNCahf/aSTnrXRXYhC
 Umag==
X-Gm-Message-State: AFq9FYLwgJAAOqRo8mMvLbaRFFgG2lxi9Wimu0uHFJgndfDy1Ok80i5Z
 slsVrk4keEC/8mhvlZo1MfWjo251gM0B6/NH/EBK7sPLS/jdKw2wBxLSlmG3mLCaojQR+w==
X-Gm-Gg: AYBFou1XPXcnNnHZv2Cqmpc5QKQA97f8J1NMtgxijyJpQVfoj5+YqMN91NhAb8rqIt9
 PTUolB1QA8TtaCAqfcc0E/y4PsMNMX6oOD+7TXSDGVLDQ2NlEa7Qjz6eOH+gmGyBEbKg+DIBRfY
 CWNodAd6r8V9xZpNG+vS47Vj00uN+kJ17gkCwMVVfFKv2G9TwNvGylyKEqZAFrbzjvkJqIFptNn
 q+aeMABhTvtO4AXi6CY3fC4gkZlBtHlrRtFkYs9JKSv9k4L623GsgNeHJqgBBnu5zDG1E2yjxxG
 +CUg1/gPiqZx0rurOCzwek0b/IOAOdzLK9+k5MdDc54jDJ512mPh7RWix8qMCPaTceHw50YNSoU
 cPdALWFah1B9WCqjzx9crf+SG1M59DVusavptQqiB1w9SPL0gGiSOMUR81leo9cMS5cCd770LjT
 8BnyvzGNi//y7VJcfig0A+05IphEoRVxFaKoxDSAXPbm6w539CzUlVNju+xiiywgAhTKZTxL6Y+
 Uk8CGIReK8d1GutbMqMWTRiSV+L6rMdnS6lRsaIvhgRQ0aY27P5P+r8WurBNF3Z9xb1jDBJF0Vy
 2MiG6C+kyNr2O4aAsMQvhUflITcXsP1B6pkRE7GDYEpW4m5hbUk3RLr9y9SDmvEgPks=
X-Received: by 2002:a17:90b:35c5:b0:3a8:786a:cfed with SMTP id
 98e67ed59e1d1-3adeb64d3b1mr2989070a91.37.1792985872081; 
 Sun, 25 Oct 2026 20:37:52 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:37:51 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:30 +0800
Message-ID: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBX3-000000000eK-3k0V
Subject: [f2fs-dev] [PATCH v7 00/15] f2fs: support & optimize large folios
 for writable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

This series supports large folios for most readable/writable files
in buffered I/O paths, including normal files, block-layer encrypted
files, and atomic files except for inline-data files, compressed files,
and quota files.

It also extends f2fs_folio_state to coexist with f2fs page-private
flags and to handle large folio write path and partial truncate of
large folios correctly.  A valid large folio always carries a
f2fs_folio_state at its folio->private in the current implementation.

Benchmark details can be found in the RFC v2 cover letter:
https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com

Changes in v7:
- 01/15: realloc the f2fs_folio_state in f2fs_get_lock_data_folio() if
  it was released while the folio was unlocked.
- 04/15: on an atomic buffered write repeat if folio was unlocked, check the 
COW block before reserving it again, so inc_atomic_write_cnt() is not called twice.
- 08/15: clear PAGE_PRIVATE_GCING if large folio has no dirty sub pages
 when f2fs_trylock_op() fails before any write is submitted in f2fs_do_write_data_page().

No other functional changes.

Changes in v6:
- Rebased onto the f2fs dev branch (fd106ada4dee).
- v5 12/16 ("f2fs: wait for folio writeback before ffs_detach_free")
  is dropped, because the lkp warning reported by [1] was caused by a
  write_pages_pending leak on the GC truncate path.

- Improve large-folio support in the f2fs_do_write_data_page() path used
  by GC:
  - 05/15: use __folio_start_writeback(folio, folio_test_dirty(folio))
    in both the IPU and OPU paths, so a single-subpage GC write does not
    clear PAGECACHE_TAG_TOWRITE while other subpages are still dirty [3].
  - 05/15: add f2fs_ffs_put_write_pending() as the common writeback
    completion helper; do_write_block() only ends writeback for order-0
    folios.
  - 08/15: move the write_pages_pending increment from move_data_page()
    into f2fs_do_write_data_page(), take it only after
    __folio_start_writeback(), and drop it on every error path.
    move_data_page() no longer adjusts write_pages_pending or clears
    gcing on error [1].

- 02/15: compute bio_offset/bio_len against the folio actually added to
  the bio [5].

- 05/15, 06/15: fix the order-0 dirty accounting leak in the cp_error
  path [2].

- 10/15: allocate ffs before f2fs_truncate_read_extent() [4].

- 11/15: move the existing truncated-page handling into
  f2fs_clear_truncated_page_state() and reuse it for the subpage-aware
  large-folio writeback path, including the -ENOENT/NULL_ADDR case [2].

Link to v5: [6]

Many thanks to Chao, Daeho and Jaegeuk for the reviews, and to the
kernel test robot for the report.

[1] https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
[2] https://lore.kernel.org/r/6be679d1-d8ab-41b3-9975-1f1bcd552579@kernel.org
[3] https://lore.kernel.org/r/fc101bc7-6ece-4a30-9e19-9b32376489a8@kernel.org
[4] https://lore.kernel.org/r/36220ef3-5b00-4aa1-ad11-60b10857a886@kernel.org
[5] https://lore.kernel.org/r/atA8dsZ35E6wTMD6@google.com
[6] https://lore.kernel.org/r/20261014064445.2835813-1-zhaonanzhe@xiaomi.com/







Nanzhe Zhao (15):
  f2fs: extend folio state for large folio write path
  f2fs: carry subpage offset and count in write IO
  f2fs: support regular file buffered writes on large folios
  f2fs: support atomic file large folios buffered write
  f2fs: support large folio writeback
  f2fs: account large folio dirty data at block granularity
  f2fs: prepare mmap write faults for large folios
  f2fs: make GC migration large-folio aware
  f2fs: optimize small block size large folio read
  f2fs: support partial uptodate large folio read
  f2fs: handle partial truncate of large folio dirty subpages
  f2fs: fix zeroing paths for large folios
  f2fs: handle block cloning within the same large folio
  f2fs: allow large folio support to writeable files
  f2fs: make compressed files compatible with large folio

 Documentation/filesystems/f2fs.rst |   10 +
 fs/f2fs/checkpoint.c               |   40 +-
 fs/f2fs/compress.c                 |    7 +-
 fs/f2fs/data.c                     | 1521 +++++++++++++++++++++++++---
 fs/f2fs/dir.c                      |    2 +-
 fs/f2fs/f2fs.h                     |  170 +++-
 fs/f2fs/file.c                     |  226 +++--
 fs/f2fs/gc.c                       |   32 +-
 fs/f2fs/inline.c                   |    9 +-
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/node.c                     |    2 +-
 fs/f2fs/segment.c                  |   13 +-
 13 files changed, 1774 insertions(+), 263 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
