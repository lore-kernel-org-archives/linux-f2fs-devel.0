Return-Path: <SRS0=EpCQ=AN=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461BC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:10:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB9F206BE;
	Thu,  2 Jul 2020 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LeUfaLZJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NGHaym3s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dlrcKtm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB9F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jr1mz-0007cf-I9; Thu, 02 Jul 2020 16:10:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=44573aa05=aravind.ramesh@wdc.com>)
 id 1jr1mx-0007cE-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jul 2020 16:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qCFljSNBHsa7+8kYyDJ+k86WyrDSja7BazKh4HE2SA=; b=LeUfaLZJxD02s0ZXlTYV7XCMOC
 c3Oy/tE/ZCIDD9fH4/ligQ4FKoL1cZ3Y+tBYZstGsV9dLSNPnCTtqN+qOqZg/8O884tCd0p9aaN8X
 TuntQmkfOoVqFQmUb4Gj5x8QhrhxXjkfCtIfb4BNJgYT9h6m0dPhj+LFNVtVnXijlNss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3qCFljSNBHsa7+8kYyDJ+k86WyrDSja7BazKh4HE2SA=; b=N
 GHaym3so9dJH0C0rB9Qqjg8wV2/xHnRi9TufZd0/D7hKCfslY/SG4gV3tDFqB0jjGCqF6Nr8tobgI
 RstbjB3GZvDf4CodFVpTRkyLVL5SpsmhFCgAOuQ8o+ezjkRa9L8VC0mx/f9OTkCflIJ8dl54Friae
 kB76zxHQQ8azil9Q=;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jr1mt-005v6l-C9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jul 2020 16:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593706211; x=1625242211;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KIvJiv35gck7PjjBJH/QA2Hwu9WfaSvRFBLqCzMzdB4=;
 b=dlrcKtm4rlq75dWcUm6d5IisoAswWQNgR2nC3cJ48TT7EiU9rfEDoH7r
 perw3VISbL7llmpN9Fl68XPzM4T6kuBASTRkJXjTiQVqNsS5TBpd+CVio
 aBfUptXVA7I7DUV7eIJuP0a3yUociQ5GfKryLnQ7u4PIfchTgtkaMp9dZ
 q9EEGaCq1tuC+0qcrEkj5LY1N4lxYueTqhbAVyhDMid8TtNV51xoSdZLf
 m7k8tscd2XzSq5nRPn+qEzYc0sDFDLwfcrMMfBrv4iQ4MjL02LsQeqzhd
 ENaGUDm/3FZqH1Bmi6UF36MWqz2gvk18lE60lVVdEZnzw/cIT3YPcgEBt Q==;
IronPort-SDR: 7czmn1Xu1BQnE4g4uYftLPcr9Pee5SE6XBKXhWMVb6h9ATIVkPzCYxdLG+JRXR/ZGCF/my2+k3
 pK2xSToWabapBjhGPUOgKAZWc3HJZpLjpwWsH1+Iyz+T1O32HHA9zMmSW2yX15Cei7qzGpzzk5
 8O02M8urnZZJDq4nSM65PRNKKSbMR2ufAk/0RIuSOulvrvN1SdDbihHzhSZ9unVU2JP/IXOYpV
 yEaR4JZFFUStgfjYIANQu6HCAHcKCQDCUQhtx2B6DlqbWISQJbjyHSh2Er0BypN702YORWcJvO
 23g=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="145822149"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 23:54:33 +0800
IronPort-SDR: 8UGq92Kv4m/tz2NcU3bt75t1pfqSM8AMTfFCxR9Kx9jN+55ReUjsyw2WJ1B2Sc2nraQ3sAVgrK
 dhrElPi4N8v83JFmj0jjNpnz/Sw7OkbVM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 08:42:47 -0700
IronPort-SDR: mHmICmlMitvrX34WgFxeaANX71Q9C+mRVmQSAAx1xfJOHnJbJ1Bx8o+URjw/b1SVPLqeGksrhx
 UghcijJdZbrw==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain)
 ([10.64.18.44])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 08:54:31 -0700
From: Aravind Ramesh <aravind.ramesh@wdc.com>
To: jaegeuk@kernel.org, yuchao0@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2020 21:24:25 +0530
Message-Id: <20200702155427.13372-1-aravind.ramesh@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Headers-End: 1jr1mt-005v6l-C9
Subject: [f2fs-dev] [PATCH 0/2] f2fs-tools: add zone-capacity support
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
Cc: Aravind Ramesh <aravind.ramesh@wdc.com>, matias.bjorling@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

NVM Express Zoned Namespace command set specification allows host software
to communicate with a NVM subsystem using zones. ZNS defines a host-managed
zoned block device model for NVMe devices. It divides the logical address
space of a namespace into zones. Each zone provides a LBA range that shall
be written sequentially. An explicit reset of zone is needed to write to
the zone again.

ZNS defines a per zone capacity which can be equal or less than the
zone-size. Zone-capacity is the number of usable blocks in the zone.
This patchset implements support for ZNS devices with a zone-capacity
that is less that the device zone-size.

Add checks in mkfs and fsck to consider zone-capacity and calculate the
overprovision ratio and free_user_blocks based on the usable segments
in a zone.

This series is based on the git tree
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git branch dev

Aravind Ramesh (2):
  mkfs.f2fs: zns zone-capacity support.
  fsck.f2fs: validate free seg count on zns device

 configure.ac        |  4 +++
 fsck/fsck.c         |  5 +--
 fsck/fsck.h         |  2 ++
 fsck/mount.c        | 75 +++++++++++++++++++++++++++++++++++++++++++--
 include/f2fs_fs.h   | 40 +++++++++++++++++++++---
 lib/libf2fs_io.c    |  1 +
 lib/libf2fs_zoned.c | 51 ++++++++++++++++++++++++++++--
 mkfs/f2fs_format.c  | 26 +++++++++++++---
 8 files changed, 189 insertions(+), 15 deletions(-)

-- 
2.19.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
