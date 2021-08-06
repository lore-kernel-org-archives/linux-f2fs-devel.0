Return-Path: <SRS0=dspS=M5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A19C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 11:19:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE3A60C41;
	Fri,  6 Aug 2021 11:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECE3A60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBxsh-0000ut-DW; Fri, 06 Aug 2021 11:19:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=845ab97a1=damien.lemoal@wdc.com>)
 id 1mBxsg-0000ug-RT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 11:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qa3l6HVi5pvPf7KD4HGEr3+BWWl1wlJ/T/SsZXftpP4=; b=ZceP03tXxW+VJ91rkFQp1bXuA6
 U8Lf+kQTzZ6Pkygc8sym7MBmPXLASEQUkA+GYlGAVIbUUJg3sp5Vjaj2hi0HBoABh0Z9gunaEmdka
 1ld0uX4IaG3b1rqO6YvoIW0GvdmsqyDlQbhyoX9qpPE6fLllgwFkYu82n0C/L0AQaKSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Qa3l6HVi5pvPf7KD4HGEr3+BWWl1wlJ/T/SsZXftpP4=; b=h
 yAQw1jxzOhjbpqo/5R9MOFfKmmhf3fRymb4JB9R865m4y6koDPcQVys5tlezy9qSixwPduRyQGu2e
 qH5BeJEYzEqA1X6Fonu9aGebv5vUGWU5lnZlEM0RWfs1Qk/zo11YtuNW/pWsKr2kPfD+4kUzPyD/g
 6sfbo5XMzHzh5AoM=;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBxsc-00EcqQ-3E
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 11:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1628248748; x=1659784748;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4Nm8xJvK6D6Eb+y2OhfvZoCxVrMeFWiNC57rtvdI0Z8=;
 b=kz5N088Cfa7G/9jYPRA8+sjGpMvN/GelqiinGa0ACqvwuc0ceaWkTjyg
 p7UdthxxasATzO1YyxGMpcvoNA4AqdmIBH71TBhgU6sklRzIsIYWgIcGM
 zhijXbg97XulaS3hgnLNlRC0EdI4QcKWXTy89QX3O3UG0o6cC+Fas13+V
 rfAUejIHnYjhe7KfINsIPlH/Fxife3ZbQCdDUMnu+RgdW11Rt+NkdCeW5
 D4BtuWpQunAoP/R1TTVkaInLX/gUgMfNYA7F/w0lkoAwtyF97b4f9Z3J+
 2Vw1SCVK7ICcvcDLGruxZEA10FUNlRWhtf44L1Iq8cFR9CkiwgVVgr5EO w==;
X-IronPort-AV: E=Sophos;i="5.84,300,1620662400"; d="scan'208";a="176497158"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 19:18:58 +0800
IronPort-SDR: sgUMZiiMHz5s3xpxzyLzqLy5qdcqKm2wpRj7IUqxVMuDnkf+CjOH6iuyVKa6jhLtZ1ROtKg0Ia
 +z6smOf9uo3o13WUJ9GejJ7vlFRx89ZUy4LMGA7LOefUNM+Ffz4ncZe5Bd0hMjYw8do87uqX7a
 aJ9Q3quIJcY/Sjrr5dTl39R9NmSGvslxKI8ac+GK+0eGd/B0ukMGD0Z6uR2xmhREIKuwhWVvkV
 HBRQfGGtN7dNeLg0uCOnVgu2e0cbEHQ9zSv8k6Rapu8s5vf223GnWYgTIGtXt8s/rFgthbL960
 H5XuJyUjc+s5h7JSSprU6v4Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2021 03:56:28 -0700
IronPort-SDR: SIxZVF9dtQfoWIEv9z+PTY9l2YxibRVzoXZgfCV8TwN16yyOpO7Mv8NqzfbbtInY+1A0jyTjXo
 kLZtZcV2bDckY2mpLkJWayuwUYSkR93xGPJRyM/QJAXfauXhzhbvDY6r6hAUffkj+KHKbEcSA0
 TBPvz+gafbgwftvOVF70oI8T8F9W5lCWoorFf0bfVqZvtUvxSp0x9Z01OHcZ0CM1KsDM2YHt1F
 syEMdpA/5VIotn4+7cPwQ8QQwGh42bcO/11AGE504+X1ZrM26IUL1D1tOX5/ItBr0yDeGlE7Pg
 B8g=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2021 04:18:59 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Paolo Valente <paolo.valente@linaro.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>
Date: Fri,  6 Aug 2021 20:18:53 +0900
Message-Id: <20210806111857.488705-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Headers-End: 1mBxsc-00EcqQ-3E
Subject: [f2fs-dev] [PATCH v3 0/4] IO priority fixes and improvements
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series fixes problems with IO priority values handling and cleans
up several macro names and code for clarity.

Changes from v2:
* Fixed typo in a comment in patch 3
* Added reviewed-by tags

Changes from v1:
* Added patch 4 to unify the default priority value used in various
  places.
* Fixed patch 2 as suggested by Bart: remove extra parenthesis and move
  ioprio_valid() from the uapi header to the kernel header.
* In patch 2, add priority value masking.

Damien Le Moal (4):
  block: bfq: fix bfq_set_next_ioprio_data()
  block: fix ioprio interface
  block: rename IOPRIO_BE_NR
  block: fix default IO priority handling

 block/bfq-iosched.c          | 10 +++++-----
 block/bfq-iosched.h          |  4 ++--
 block/bfq-wf2q.c             |  6 +++---
 block/ioprio.c               |  9 ++++-----
 drivers/nvme/host/lightnvm.c |  2 +-
 fs/f2fs/sysfs.c              |  2 +-
 include/linux/ioprio.h       | 22 ++++++++++++++++++----
 include/uapi/linux/ioprio.h  | 23 +++++++++++++----------
 8 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
