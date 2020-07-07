Return-Path: <SRS0=+EsW=AS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED4C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:22:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5B8206CD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RD1eV1KC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WrwofSKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5B8206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jslfr-0007Eu-Qf; Tue, 07 Jul 2020 11:22:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jslfq-0007EM-7a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 11:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gWSQ9DNClV5owEVsSjYH/PythGbHOqqr+LfIZPAj7Q=; b=RD1eV1KCtND8RvCC5tfwZ1Ckfw
 een2UF2qpWPyf+VR775SQLWm8E7u2tleftDxRFMgHOZ9PtHCGQKaYdzzdAZVxbnxTeD3qMnkClKPH
 qg0dbn4zgkBO04T9L80XoXGXjx3H8qE+fzLbsswNgeCVmbXD5TZiqZ5AGOJNWp8bpAk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9gWSQ9DNClV5owEVsSjYH/PythGbHOqqr+LfIZPAj7Q=; b=W
 rwofSKVFD29rRrx/u3gFxDvcTpbcrQ/NbvAeKX5HvCPOOfcLFTY9knmvLymgvXHvxd0l4b2dBZbWK
 0vPFJruiz7BXy9yLm4z4OoR6hZ2VG1s1S2KzVyeSatGJlCeKva5lE7ztFd7unuL5hY64yYD0TOKnm
 qbeuzNXyTnrx07x0=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jslfo-00G5QQ-0p
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 11:22:06 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 202F7CD21BFBA125AEEB;
 Tue,  7 Jul 2020 19:21:48 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 19:21:39 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Tue, 7 Jul 2020 19:21:23 +0800
Message-ID: <20200707112128.89136-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jslfo-00G5QQ-0p
Subject: [f2fs-dev] [PATCH 0/5] Support Age-Threshold based Garbage
 Collection for f2fs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch series introduce a new garbage collection algorithm named ATGC
(Age Threshold based Garbage Collection) in order to enhance efficiency and
effect of background garbage collection.

ATGC algorithm tries to fliter few oldest candidates according to defined
age threshold, it selects source section in those candidates and then
select target segment which has almost the same age of source section,
finally, it migrates valid blocks from source section into target segment
with SSR allocator, enhancement shows in below aspects:
- it avoids selecting young victim section which may have high update
frequency;
- SSR write avoids unneeded movement of blocks locate in target segment;
- source section and target segment has almost the same age (update
frequency), it keeps well hot/cold separation effect;

Patch 1 introduces in-memory curseg, since it only exists in memory, so it
avoids on-disk layout change whenever we want to add a new type of log.
Firstly, adapting aligned pinfile allocation to use in-memory curseg,
later, we will use in-memory curseg in ATGC feature for migration as well.

Patch 2 changes segment's mtime definition from recording last update time
to recording average update time, so that it can indicate more precise
update time of each valid blocks in segment.

Patch 3 changes segment mtime update policy during GC, 1) don't update
original segment's mtime; 2) inherit segment's mtime from original segment
to target segment.

Patch 4 adds to support 64-bits key in rb-tree node entry, and introduce
f2fs_lookup_rb_tree_ext() to support lookup functionality with 64-bits key.

Patch 5 adds to support ATGC skeleton to enhance effect and efficiency
of BGGC.

Test and result:
- create 160 dirty segments:
 * half of them have 128 valid blocks per segment
 * left of them have 384 valid blocks per segment
- run background GC

Benefit: GC count and block movement count both decrease obviously:

- Before:
GC calls: 162 (BG: 220)

Try to move 41454 blocks (BG: 41454)
  - data blocks : 40960 (40960)

SSR: 0 blocks in 0 segments
LFS: 41364 blocks in 81 segments

- After:
GC calls: 75 (BG: 76)

Try to move 12813 blocks (BG: 12813)
  - data blocks : 12544 (12544)
 
SSR: 12032 blocks in 77 segments
LFS: 855 blocks in 2 segments

Chao Yu (5):
  f2fs: introduce inmem curseg
  f2fs: record average update time of segment
  f2fs: inherit mtime of original block during GC
  f2fs: support 64-bits key in f2fs rb-tree node entry
  f2fs: support age threshold based garbage collection

 fs/f2fs/checkpoint.c        |   7 +-
 fs/f2fs/data.c              |   2 +-
 fs/f2fs/debug.c             |  10 +-
 fs/f2fs/extent_cache.c      |  37 +++-
 fs/f2fs/f2fs.h              |  50 ++++-
 fs/f2fs/file.c              |   3 +-
 fs/f2fs/gc.c                | 373 +++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.h                |  25 +++
 fs/f2fs/segment.c           | 331 +++++++++++++++++++++++++-------
 fs/f2fs/segment.h           |  40 +++-
 fs/f2fs/super.c             |  19 +-
 include/trace/events/f2fs.h |   8 +-
 12 files changed, 798 insertions(+), 107 deletions(-)

-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
