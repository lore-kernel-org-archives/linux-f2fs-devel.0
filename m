Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7209ACC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tTYphNERSR6DYpGOwzqxNxS/+CNIx2sI02DO+FZD8s4=; b=M4BraqF8aVBhecN4xfqggbmxSj
	XeJuiDE9ORi0fxB+0QrQbDtnchrgZzxa9Xi9kwY95pm49OZ3FWBuVP8JVL/0QxUVF4+NnOyEZAaCD
	VemewBcMfn+8uQ4/cIbYcYmoSlgZnLvKDM5QOtO/pIGCBRP7u4lJoepyCFim1F8UTdIU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb7Z-0007iy-Ew;
	Tue, 13 Oct 2026 11:56:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb7Y-0007ir-Dp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iNPPKRILZbXlMO2+NBKwscyZliRaGEtAtX51K+80FQw=; b=dHyvxpczknFd98P5BiTBghTGYu
 cY5o9QfdeM7btTpD4+VPbYQSc1FFSHg9avx2tkENF4tJ54DcQbksfh1iSAzHQ375OwY0S0sQk+P/W
 y7YdwGCGPk91LsJ8cjONQ3zMuBoEBBC00PNTlHZRpO1aY35dfd99TP54MTshxH4aPDKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iNPPKRILZbXlMO2+NBKwscyZliRaGEtAtX51K+80FQw=; b=M
 3eUGFscrDNZtwqLOSKq99ySivSuzROLn9+8lQvIhOYjj7ytRb5TadjKXDgaI2ZXF1OCLpRgcm+Rph
 N0TsvUZal/ZLyO84cSgmoio2Y/TXJ7ZimBrNwpyT2zYew+MqQTHfwEpR+8ARNnIKD11jZ+7QNe50a
 5YK0a+vBrk68Ub28=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb7U-0005Pt-CN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:37 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so875857a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892591; x=1792497391; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iNPPKRILZbXlMO2+NBKwscyZliRaGEtAtX51K+80FQw=;
 b=rOd1KYAeErR2z8B95JXyOISxTbN44RV7fnHvmCbIQuLoSQ+fSMWsw0LZDNL0K++AMJ
 6E/CTDpKsKxE5lxGT7wFTf/WAFE9ExduRM4VA0A/0ikJv/f7Ror3b3gY4qk0hKM1qfIS
 8A/KYnb7InPA/NAcdbvKqQ1f8Bi6cdCk0fC1JvnrIoDGp0rx742/GSQ5aJLsLVpW/XyF
 RC0l9CXHNKPhmjVwaa0EbImV8Ur5dXzMi5mluUwyYR4p1upyg3kSJvWQxgprVdwoDB0w
 ho1waikJVnN76jD9dwway9hFnGs8pxgemflMN6JVhu48yT80jDp9XF4QYVtsTha5nHu6
 uXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892591; x=1792497391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iNPPKRILZbXlMO2+NBKwscyZliRaGEtAtX51K+80FQw=;
 b=lWR7uoyjyAPHDjuHhvYOSU0lBo/SOBDJgIrdoDC2PLyrZI756w1HiOOaQIRJLJqwR+
 9cLf3R4fHQeBsJRqSUSXPQWleiUM/osPK8h2TNdiLE34bz+U8aROjCkP38aMdxDdeIt6
 v3I2kBQYpTAlGoqzdHqNliTCOZZGm0KdGmJHdo2PDtDvGZDAziXZRIf81nZpugzMKx3p
 VBKWlz6NThL2TzMf76hgZy0y8AQgKuUvTCkHZosdZJ0WqjtUl56x0KlGI5k0XUHuIwQR
 FOnZHDIbGMNvYtggoHkPfGVK75Zv071Kv3waQJEyPFedSYQ2mFMvB5HQXbyB7e3bOc77
 Yu+Q==
X-Gm-Message-State: AFq9FYLX8uWJ3fOJHdNvJpRBxCeAi8UX7794xgEFTP2IDBIaVXf9CoAO
 qyekNwBkxG3GEDFKj95/5/3Ul7ZV4p4d+ky1w/xqqzI2kw6TtK2rde7n5S0ya47ncFA=
X-Gm-Gg: AYBFou2rTlXYlr6EPuecjrtNYMEhD/Sgpbcj0FsRTesAwe0fI+aSgiUUn4/HKht1SeH
 03PIdEJqgtosQCOlUrt6ObuyR4QanprAeYYE4wrg1SouWHdsnSQAwdyQM/2HICwTUVlHnbrDXHQ
 CQRHDFXIydjTmeOp6F7PZC7zx/dVI6iGUmY5tsJ3KyI1wMY2aoXFRi2CBZn/Ut8hLdRjgoQ3T6d
 wFYYZ9BeVG+CVC10mI6rk9yx6fMRS701BMcYbhyDA6JewgB8MH2rTxvJpRRKhuZQdyB7Av1GcdK
 MahqBwJn6B5+SEqFm3PLM/s53GSKVtCnnG76faQ1P1S7OyHIgbEOtUXXoatF5HHvSkgdxFTRRLb
 rvnijBvB39ZSBJHk8TDQ1oqVR0mBfToz7ofjFaUd7+Uv5fISNnktezeyyMtmVgfhKxjpIqA0VTY
 GDNpbc5To1ivNIIbbaOAGLDKAYZwe7515+kpfNtfYjzpoKmF82C9pb5g3q6pLIwqCfjnfRm9nVV
 TWFo7MzBvQCTgvK28iJolvO4a2R6zmEJyN/7GuidX9lcoc=
X-Received: by 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3ab3a79d9f8mr9977247a91.45.1791892590569; 
 Tue, 13 Oct 2026 04:56:30 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:56:30 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:03 +0800
Message-ID: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xGb7U-0005Pt-CN
Subject: [f2fs-dev] [PATCH v4 00/18] f2fs: support & optimize large folios
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

This series supports large folios for most readable/writable files
in buffered I/O paths, including normal files, block-layer encrypted
files, and atomic files except for inline-data files, compressed files,
and quota files.

It also extends f2fs_folio_state to coexist with f2fs page-private
flags and to handle large folio write path and partial truncate of
large folios correctly.

Benchmark details can be found in the RFC v2 cover letter [1].

Changes in v4:
- Rebased onto linux-next next-20261012 (4eb2586bd40d); its f2fs part
  is the f2fs dev branch.
- Added "f2fs: read i_size once in f2fs_vm_page_mkwrite" as a
  prerequisite (also sent separately).
- "f2fs: remove mappedtodisk flag usage in mmap write path" is kept as
  a prerequisite.
- Link to v3: [2]

Patches 1 and 2 are prerequisites for the large folio work. They are
also posted independently as bug fixes, and are kept in this series to
make it self-contained for the sashiko review.

Many thanks to Chao and Daeho for your extensive reviews and valuable
suggestions!

[1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
[2] https://lore.kernel.org/linux-f2fs-devel/20261009161224.4163796-1-zhaonanzhe@xiaomi.com/

Nanzhe Zhao (18):
  f2fs: read i_size once in f2fs_vm_page_mkwrite
  f2fs: remove mappedtodisk flag usage in mmap write path
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
  f2fs: wait for folio writeback before ffs_detach_free
  f2fs: fix zeroing paths for large folios
  f2fs: handle block cloning within the same large folio
  f2fs: allow large folio support to writeable files
  f2fs: make compressed files compatible with large folio

 Documentation/filesystems/f2fs.rst |   10 +
 fs/f2fs/checkpoint.c               |   40 +-
 fs/f2fs/compress.c                 |    7 +-
 fs/f2fs/data.c                     | 1425 +++++++++++++++++++++++++---
 fs/f2fs/dir.c                      |    2 +-
 fs/f2fs/f2fs.h                     |  173 +++-
 fs/f2fs/file.c                     |  252 +++--
 fs/f2fs/gc.c                       |   38 +-
 fs/f2fs/inline.c                   |    9 +-
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/node.c                     |    2 +-
 fs/f2fs/segment.c                  |    3 +-
 13 files changed, 1706 insertions(+), 260 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
