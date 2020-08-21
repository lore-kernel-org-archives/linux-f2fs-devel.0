Return-Path: <SRS0=Tg9B=B7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0646DC433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2020 04:23:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71D32076E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2020 04:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G2nDM5MF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hhZFX2jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71D32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dlrobertson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k8yaP-0002TI-BL; Fri, 21 Aug 2020 04:23:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan@dlrobertson.com>) id 1k8yaO-0002TB-0e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 04:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q7vc1bp7hPJ7acbQFf4g1oMpjc5/6uB6sBcbsD/m9IY=; b=G2nDM5MFIR0qOS4H6SSG9W4RPQ
 OYd+GgAWftxXFlNVuL8ibgkQMsIybbn8lwAIpSUabrOB6th6aNVdr9vXFz0uBc4zdNMLVxo5r/Kt4
 ypfcZVXZEl+DBptb1m8G09o2kTlweXvpJJjqHU4YhHsW4Jn019GIa3uCXbcBDjwIjCec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:
 Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q7vc1bp7hPJ7acbQFf4g1oMpjc5/6uB6sBcbsD/m9IY=; b=hhZFX2jxvIWzUI+XKEVnVuQaW7
 DTkOV76UpWgPyYShTVGF/9TW5vR1oIIPJ6smVGWkU/q+0C+pNtVEFHMMTgnfqNSCE6JkSs8qsEY69
 VC+TwFlOWWWfv+4IWiiOuWV2cjL3IYOx22lrETqV4pcdzFUh4p3oPCrntoszI+yHEO8I=;
Received: from sender4-op-o14.zoho.com ([136.143.188.14])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.92.2)
 id 1k8yaM-0000aj-Kw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 04:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1597982867; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iKRDrpid2CISPexjdKgwPVe5/rIj14W5AKH+hzCfQktWzU9VYU00Kjb8keon72DIfngExe/SWVDb284qCsunwuvAyX87vPuEVZEC+pO42MmyrFG83xm+q0Db2ukB5BaDE1hgVKv41lZvmQpwNhw2uXbwbAJ3CDuj/2ouuJ46/aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597982867;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=Q7vc1bp7hPJ7acbQFf4g1oMpjc5/6uB6sBcbsD/m9IY=; 
 b=Fo6mUxXPhmYgP1le+KONxcucwXjX7FVGq2YSRFij4vd1aQxJJ1M2RPWAxxvIByxWAiIzQlUKEv8MB52sZtMlibri8SOOyk4j7vwM2fcDoYDrBABStOR/LaA6D54RYPcOXM4df74RPexVTbg3X4QRFGxhgzVstmA0pH/Ujm+PQm0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=dan@dlrobertson.com;
 dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-108-28-30-30.washdc.fios.verizon.net
 [108.28.30.30]) by mx.zohomail.com
 with SMTPS id 1597982865564153.02167245062083;
 Thu, 20 Aug 2020 21:07:45 -0700 (PDT)
From: Dan Robertson <dan@dlrobertson.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Message-ID: <20200821034732.18182-1-dan@dlrobertson.com>
Date: Fri, 21 Aug 2020 03:47:31 +0000
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-ZohoMailClient: External
X-Headers-End: 1k8yaM-0000aj-Kw
Subject: [f2fs-dev] [PATCH 0/1] f2fs: check output position in move range
 ioctl
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
Cc: Dan Robertson <dan@dlrobertson.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If a negative value is provided as the output position to the
F2FS_IOC_MOVE_RANGE ioctl, f2fs_get_dnode_of_data may hit a memory
bug like the following:

BUG: unable to handle page fault for address: ffffed10b30435a4
[...]
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009) ...
[...]
Call Trace:
 f2fs_get_dnode_of_data+0xa68/0xde0
[...]
 f2fs_reserve_block+0x3b/0x230
 f2fs_get_new_data_page+0xf0/0x8b0
 ? f2fs_get_lock_data_page+0x1f0/0x1f0
 ? rwsem_down_write_slowpath+0x8d0/0x8d0
 ? rwsem_down_read_slowpath+0x830/0x830
 ? ___might_sleep+0xba/0xd0
 ? f2fs_get_lock_data_page+0x17a/0x1f0
 __exchange_data_block+0x11bf/0x24d0
 ? f2fs_ioc_release_volatile_write+0x170/0x170
 ? __might_sleep+0x31/0xd0
 ? ___might_sleep+0xba/0xd0
 ? rwsem_down_read_slowpath+0x830/0x830
 ? __init_rwsem+0xa0/0xa0
 f2fs_ioctl+0x469c/0x6980

I am reletively inexperienced with F2FS, so I may have missed something,
but I think a simple check of the output position to ensuring that it
isn't a negative value should resolve this issue. The simple test
reproducer I wrote no longer triggers the memmory error after the patch.
Comments and feedback would be appreciated :-)

Cheers,

 - Dan

Dan Robertson (1):
  f2fs: check output position in move range ioctl

 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
