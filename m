Return-Path: <SRS0=FAg2=BA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD936C433E8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:38:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BA920720;
	Tue, 21 Jul 2020 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QQUXb4SO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ALlp4g8o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a6Joc3XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BA920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jxvHs-0005N9-8Y; Tue, 21 Jul 2020 16:38:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=46497140d=aravind.ramesh@wdc.com>)
 id 1jxvHr-0005N2-4U
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 16:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ICcYYXdd6gNDU6lZxMcVYQ7BrxlJLyrAiTaNJlo39OE=; b=QQUXb4SOWdw2TK0hZD5u5wRxDw
 sQ5AHjy0QGczhAnO/JD9JUnutL94qnTnFnbD8sswzVB/+mIKiplX303oUm+GNnbYHDVchmpYb1aPe
 4OIhQFQFba7+leaFeqByyApPC7nckYWHpXzpx4hWrzkd0QyiQ7U2yumLtVX8DcQQvxEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ICcYYXdd6gNDU6lZxMcVYQ7BrxlJLyrAiTaNJlo39OE=; b=A
 Llp4g8on432Q4cCi1fn4YPw9+U4iPBVOUv9rbdzdXWY1F4u9a7ezxGnDpsNUlJS0Ymyyyky4QwNqD
 2s7hlhHtDyQM0+RwsCMu914QjVz1JDCr9SCiw1OuSMu8ysVplWQaa6TwKS/b9dF2h6BgpOoiI7a6r
 ccTiv2O6LNvt65o8=;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jxvHp-00CK8T-4f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jul 2020 16:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595349517; x=1626885517;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MmLLFpJl0RS9aAqHSbIv+5m/AzB8aWmztrexg0b0egQ=;
 b=a6Joc3XFwHx5LTlRrr/KDRU/WqcLNp/tCewZrMI/ICB9cyvBc/L73kle
 MqA2qk86367Ji9TxOxzEHplpN0+PdojLJStsbnHQ8Lw+gf63F9nBU4jfC
 YaBwnFDn8rrpg24hU4QQiBYILfYtYBcnHGU6Ax1VKFmOq8GS/9x3wxJQu
 Hokbqz2b5Wcy2E0yhu4YXDyWghqd5q26h2ECYvnYbdpTcp0nSamXH9ev9
 M89SMUBamcfYYKXRAUM8JEBLOxMDOBCQjdQmSt+gEl2cMgpejZLpfuN0u
 tkngLJwabhyz/DWhFY+5cof2dpUbLeNlsVeSm2/Vd8tF/8u76MRXPYdgq A==;
IronPort-SDR: mv/R5lpatNOgYVS1NgAl0NeIeDF/YXIz9ch1CNOwL42ggYQGb0EuVrkGp88p6i/a9QULQf2eNe
 2r/nynCJKM7H6xyIp0hCi8jo9QFbHSK3xh4Cvc8v0qrG+0mg4gNuCOPnUDobIZcHz+RR1S7Tbd
 Dzl7bULIndq5xKDbZLysnk/+DytY379r+OwOmot3eT5YP58VHgm4MQ9KcHI5JNkTCLcLunHfsa
 g8klEUwP3TTznUZ9xP0wHqsxJME3DWDGwk7RaFKGqCwVYSD2qnFNXATzlQxpgQTDI1pio28JM0
 AiE=
X-IronPort-AV: E=Sophos;i="5.75,379,1589212800"; d="scan'208";a="144300014"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 00:38:20 +0800
IronPort-SDR: wowwNGgzbLr5fK1vQnJ+ZErysXEiywYMLmAZp5ILrdWhS22307zSkOjkNPP60s/65hnZugTlEg
 u49N17fRmd01WciSZa72mmwSdvf6m8Ee8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 09:26:37 -0700
IronPort-SDR: p/gRtvaCarFcs93+nQqcA/8cqEjBQhL2CMK37ekCweVllMoasSRRid1oyf7XAHUZsUqKup5Y2l
 9LsCFAl8v6dw==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain)
 ([10.64.18.44])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2020 09:38:18 -0700
From: Aravind Ramesh <aravind.ramesh@wdc.com>
To: jaegeuk@kernel.org, yuchao0@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 21 Jul 2020 22:08:10 +0530
Message-Id: <20200721163811.18593-1-aravind.ramesh@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Headers-End: 1jxvHp-00CK8T-4f
Subject: [f2fs-dev] [PATCH v2 0/1] f2fs-tools: add zone-capacity support
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

This series is based on the git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
branch dev

Aravind Ramesh (1):
  f2fs-tools: zns zone-capacity support.

 configure.ac        |  4 +++
 fsck/fsck.c         |  5 +--
 fsck/fsck.h         |  2 ++
 fsck/mount.c        | 75 +++++++++++++++++++++++++++++++++++++++++++--
 include/f2fs_fs.h   | 41 ++++++++++++++++++++++---
 lib/libf2fs_io.c    |  1 +
 lib/libf2fs_zoned.c | 52 +++++++++++++++++++++++++++++--
 mkfs/f2fs_format.c  | 25 ++++++++++++---
 8 files changed, 190 insertions(+), 15 deletions(-)

-- 
2.19.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
