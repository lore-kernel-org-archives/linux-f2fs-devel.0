Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0B606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F7pNO/oR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PGkitCQp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GdrSggT3;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cZXoV6fq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Lpp4N4PKmxu1VsWJ2b1x54FpmkN/2u+qWuY11ck27NM=; b=F7pNO/oR8umsKzUile/s17IIiF
	HWnjrA74/P2/fM0aQOyja9PRFmcWkTDHjDXKKPNtC44fMA+kRnDEu/XYozGrY05LvlgpSnxD9jWrU
	J1Kq1h4MuZXwJ74xSXVa6+UGInp8FYGFn1k3qPRap/2iQGE+vhTbtQK074+Zb0htCs+w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJnca-000000000g3-2nfs;
	Thu, 22 Oct 2026 07:53:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJncZ-000000000fx-38uU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWX9UKTQZ4HQ2uDjvWK1vbkxuc7/mbUUmjQBZsDUXZw=; b=PGkitCQpI/TwfDN7RSXhhRfEsb
 EjDlRHXtXfh4c/eUz6VbKWfopVnkAFsBQQ/+RgtqsX96+auCvxzztg0kxH3BOLFsrdfKAJOphzPDN
 GOOzKmM7DFLczAuO7QYR3GgNeb3Fxy5XtGXu0xZNJdpdkP6gMEMzGX76Dd60Tv3oUOWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWX9UKTQZ4HQ2uDjvWK1vbkxuc7/mbUUmjQBZsDUXZw=; b=GdrSggT3COZLS96WsO/6oxUDgY
 2/Faougo8qQk9Sl6rIN2RCI93afbjkKH7lRUEYTbsIZFt27enp34OOcaVrJ91s/HxAqqVFUDa4KN8
 snhBysu9ElULSa6XM7EW8GxBpORgSSWzFGxVAhxjjOf1zJtXKixsUoZLorLj1GfNOoW4=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJncZ-000000004yM-0RnT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:53:55 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3acc610014eso914462a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655629; x=1793260429; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lWX9UKTQZ4HQ2uDjvWK1vbkxuc7/mbUUmjQBZsDUXZw=;
 b=cZXoV6fq6vcYC2Ng64pOekejmSGVLKUTNQUFjsvuBcJS18ScnXBJipUUXySJozqvyf
 IIILX8MFrtfudTRyDOkijplju2YGNbXV7xd7LP9y+TabCFzzstKrJ102q8QUyrQMN/SA
 fWdfqKqj2DgqWODfgZ/ki0g0K8s8OCcsQh+9XUBHDLFRTCui+wszWhBJPZ2V+0ZJEGnR
 Hk9wxdAUAAAmVAgWWCzA6S659O/euuTh6wN69ta7z9cx1exKnLP3kr+7yltZHKWArc3X
 hJMi1ysXpFvqDrcIU5krUVaWnpTGjR6xvGq9wkhxu0f5hBVkNxMsLAt9iCtKTXrwZzir
 KdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655629; x=1793260429;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lWX9UKTQZ4HQ2uDjvWK1vbkxuc7/mbUUmjQBZsDUXZw=;
 b=NuJP3MKNJxSig7fiu/pcxnz3eLV7YLTUXnFHX0zX0aq+3hkOjUOWrFgYrEzOLJSjrC
 YGiByon4ciiIwaWUWn0Qby/Ju4QTypceemC5NvSx8wHmmWVXKJxmAqff0U75CjgeLh75
 CAFCdoOYKHtx2kgedGMS0eoy/h8Ya45PzT6A9J7VZsxHGQoWfMPicv9FvaFf24lniu2C
 8dLiBdcXWF9rjXG7G8AZ5FzsQ1w12c7WjPByhzaagUDOj6pqLfD2NKcKY4Ldm2uVZSDY
 +VytPeYpqbe3Jt9SNvDh66fE/mx7CveX9nk9aUxa9bTXrp+FBIapwW/gmRHyEOruBeyQ
 Qlug==
X-Gm-Message-State: AFq9FYIbz+TDfXrkt8WmqMjmAT6koaKBeHbqNR4gWZk7brPf4pKbtIpr
 rZfyLq5Pa+QUXXEA/VtzI2OnuSjlBkLd1fuAnRjhQ+DQCE0uX5ZjBca9R9+Q2+PUz5k=
X-Gm-Gg: AYBFou06FxeEHLRpQtGTq8+KUaKruzRFBvJBrTdPEwQx/hPFEMeFzkaBSj7DFt28ufo
 n2nzH4XZ2+lBgk3PANKWGQ3u9C19bkZX0XTROZnI0yTaGxaIYZPArVHfpsfpE5giWDF0+RCenRY
 3EkafThxLr/gWM2m88o7wTUubpMs/9TaRhZPaq83LpNoQHN5ZW8Th7AyeOSPRdRn1LFYzxDx71l
 0eKlrbt3GIfKWHaOVYeneNkx9ec1IGQUzwD24O6vJGN//mKsMPv33SLCwJS6OmpiW88ERfHytMC
 PyfP7wTzeT59JaAOdzeNOJsi8TOOz4+Ah+/tLFd2hTdTqBZ7K/Wx9MVrwZvDiDtHRH7+IP8Kqg4
 HmsD/9w6Mfw7CgBW72DpX5NDwu0wJFoOD1/e92eioDzcnLowj6EwKNYNA/9erYOHYsSOesbQ9GG
 ZksaJFYRx4Tw7WNPq+29xxO841ap13rXIp5219Xw2+rOnYMGj2mxTF1Vr4/MSeyPfWx/C0SYzBG
 iA8yFFGeU5QLCFcZ+gyH/U+lEzbl/f1QaaA2kBIwtfnKahQmVj2ssZorEtHYdGr477SUFg6CPC/
 CN4qS0ii11mGErfC/RM=
X-Received: by 2002:a17:90b:1c0f:b0:3a6:e901:e79b with SMTP id
 98e67ed59e1d1-3ad86ee2c5emr3778475a91.15.1792655629217; 
 Thu, 22 Oct 2026 00:53:49 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:53:48 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:27 +0800
Message-ID: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJncZ-000000004yM-0RnT
Subject: [f2fs-dev] [PATCH v6 00/15] f2fs: support & optimize large folios
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
 fs/f2fs/data.c                     | 1486 +++++++++++++++++++++++++---
 fs/f2fs/dir.c                      |    2 +-
 fs/f2fs/f2fs.h                     |  170 +++-
 fs/f2fs/file.c                     |  226 +++--
 fs/f2fs/gc.c                       |   32 +-
 fs/f2fs/inline.c                   |    9 +-
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/node.c                     |    2 +-
 fs/f2fs/segment.c                  |   13 +-
 13 files changed, 1742 insertions(+), 260 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
