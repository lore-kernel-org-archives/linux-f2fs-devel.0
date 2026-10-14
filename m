Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E4ACC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9UmmYnbZB+I3nzNFaCV/0as5YH2h36mb6vrhSzVeE2w=; b=Is69oXkwPYHOoR2Ayfke5wrKZc
	0foOoLLkJt+0mGAODWnYxIVOBmLBxNuntKQ7FgRXC99zqnDsCH1bBrpgosh4W66gGMV+Azut0dOXF
	PKh0JQ72fCkYLRiMzOpHXZ4WKCjaf8MGLE5M7qVVsquWHm77WNhxT/yx89ZdmRuQZPeQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskB-00028J-1z;
	Wed, 14 Oct 2026 06:45:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGsjm-00027s-Kb
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bc+Wvmw7gLliVJ4YZNhFuoyuWzBRp7BrASeo+vbZ3zg=; b=eIBh1v17IhnWwjoU2m7ngw20Ke
 kMG42ovSBXlMZngxcs7zwWKIN9pXv+y4xpt0B3FA3g+wnvSd0TpjP0GZXk3GUysEaXz2CRvKOoov2
 2EkAzKCgglwuv9ehvyA4but/fwJ/s3d/xyfEQZL8MGEva/P2fF6Yxlec968+nyjmvIaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Bc+Wvmw7gLliVJ4YZNhFuoyuWzBRp7BrASeo+vbZ3zg=; b=m
 AopIa0I9W7AErnTSlCM5ZPiKISZWdNTrq/1bCie+HLiBkhnE/JDSs1UgH2Dl6qZ9hO69FRXTjZnAp
 29YeYSlfVJ9HVK5XZmkVgQ+/u21ex3UbnuCBmyhKsUmIZhXzowXLzKjXNzC+/Y0P91Rb1C2GEW8V3
 pgIKaC+j79Gnfao4=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGsjl-0000vG-Po for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:19 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2e876f468e5so15597365ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960312; x=1792565112; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bc+Wvmw7gLliVJ4YZNhFuoyuWzBRp7BrASeo+vbZ3zg=;
 b=L9KeAoMaKkd3fd7oyWex/mNnN9d5fDTsScSduQ3Uzvzi5BgRLmSrs0URmJdmhpItrx
 Bvx8wPlBaccAiqt6dPgjHI4G+Tx+GBzoZf21r8YDkSiRCdLhLKp46TZUK7hELUTEPqU0
 Fz0nRmsG6T32Ks018rS8tuhhgkmH+DgVxapASlyZoiV1tPdciJpG+Sa22fO4hiR2bVfc
 AxiBT8WCTSOR19fhCZdqX6kYSVxgqwD62HA9z7JmBiqIHLJkN8XQ/XsuaskItHmn/6HD
 QxTRetfgX/ENiPpmuBfeZwrSB4VK5+dcJjZflxMolPu/BDkEJom79cwYTWF1PP8LtPsm
 44GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960312; x=1792565112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bc+Wvmw7gLliVJ4YZNhFuoyuWzBRp7BrASeo+vbZ3zg=;
 b=htJH2L6xTjCm1MmZXqGgL+etGbAXC0eUJm1KJeRgOE48yhU6rVzeIQObFeSRgtssaN
 TRlXw/j3e0STa0UsuksBgv022hA3LnpNp0KPjBS+XkIVNtHhN6Aqx1wR47XOSuJk1O+K
 yYYMRO1jrkSqzsNNo0HJgqnxsKC/4ni4eSXlL0TPYZ7bnWEz9e592SVu33cepPqliNm8
 xIxdc3qfmF1FyyrYgcOrCHUznyGIrJexwURBBmX+PyMToLGAHDZjrwwGrKNBUcFAGysG
 Jf9YjIG9olx7OymhQAwooc0T9LW2O3ephte9SqKajC0xnzovLkaSKASBd9P+3uJhUTBz
 pDKg==
X-Gm-Message-State: AFq9FYJocxMMzh1K2zML5p9scBvYZww5ON5ca2N1pUqcgJziz4OH2yDT
 7SovpPFrgUVwiQsHHdgekhJqQuDab+H84Obkx/peknvlljNGEdZqFH1OL/KZXmO3/3E=
X-Gm-Gg: AYBFou1fflwNCHjKuYxNSlFiomGV02nG56x7aXrOWJfEXRI4HQ8iSdfPoFEDk3XF3eh
 4UCIgbveJK8jRTs4TzVExTgX/Q3KYvoVOdZ/uFtF7WNnq0OpsU15WG/IJTA7wLY3b61AASOxSWc
 1voxQvCJbqn0h38guuLW6ecZgREH1JYgDCovrbvUD9C0MinkQW/dBWGEKGs1PJOy6STf6R+q8Es
 w86L1sJzBcKmi70V+BrN3Wb3xesrQ6Dnn/HUedstJ1dGFULMXirIo1f9c4MVYRoDgsQ+c2ISkYs
 1b3139SftHpF0cGkKCw54ZtuTo4uHjz7R8D42W9s/Bgd3qH6+4JVtNU9TgGO6fblG/U46+LN9ky
 nqa1NvImHO9cNEbi6BDROncOuisg8QmDR+N1yweaRjdoD6xFloo6+5YZffYie1GjLykSsyNwu3V
 /geqoEN1hwd4oTy5JAbj9QRBa/EIi7a2E+Fqi8pxG+fiEK+1EY0to2RcL9WQdiCA7bS+CwWl9w/
 DoWGF9vjDXRfHkYX97hpc7U6D8wTg7F/h9M
X-Received: by 2002:a17:90b:5343:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3ab3a94f0dcmr12128126a91.14.1791960312024; 
 Tue, 13 Oct 2026 23:45:12 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:11 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:29 +0800
Message-ID: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xGsjl-0000vG-Po
Subject: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large folios
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

This series supports large folios for most readable/writable files
in buffered I/O paths, including normal files, block-layer encrypted
files, and atomic files except for inline-data files, compressed files,
and quota files.

It also extends f2fs_folio_state to coexist with f2fs page-private
flags and to handle large folio write path and partial truncate of
large folios correctly.  A valid large folio always carries a
f2fs_folio_state at its folio->private in the current implementation.

Benchmark details can be found in the RFC v2 cover letter [1].

Changes in v5:
- Rebased onto the f2fs dev-test branch (d1685c24b6c3).
- Dropped the two prerequisite bug fixes, which are now merged:
    c04f209773ec ("f2fs: read i_size once in f2fs_vm_page_mkwrite")
    b3c984358925 ("f2fs: remove mappedtodisk flag usage in mmap write path")
- Link to v4: [2]

Many thanks to Chao and Daeho for your extensive reviews and valuable
suggestions!

[1] https://lore.kernel.org/r/20260622160830.324455-1-zhaonanzhe@xiaomi.com
[2] https://lore.kernel.org/linux-f2fs-devel/20261013115621.968742-1-nzzhao.sigma@gmail.com/

Nanzhe Zhao (16):
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
 fs/f2fs/data.c                     | 1467 +++++++++++++++++++++++++---
 fs/f2fs/dir.c                      |    2 +-
 fs/f2fs/f2fs.h                     |  170 +++-
 fs/f2fs/file.c                     |  226 +++--
 fs/f2fs/gc.c                       |   38 +-
 fs/f2fs/inline.c                   |    9 +-
 fs/f2fs/inode.c                    |    4 +-
 fs/f2fs/namei.c                    |    1 +
 fs/f2fs/node.c                     |    2 +-
 fs/f2fs/segment.c                  |    5 +-
 13 files changed, 1716 insertions(+), 265 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
