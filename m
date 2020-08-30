Return-Path: <SRS0=NE1+=CI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9CC433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:56:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81A3207BB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Up1wpDpB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MWu/r11b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A3207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dlrobertson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kCBdj-0001mp-0O; Sun, 30 Aug 2020 00:56:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan@dlrobertson.com>) id 1kCBdh-0001mc-Un
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Aug 2020 00:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uUqLR9oT2n12Yp+03B9g3oPlkoxl7gyLGZ/i/fFmgcc=; b=Up1wpDpBE2fbJn3efZjAW8FrpJ
 wnY43OYLIw7I++t4UGw6dT2WUzGGz8EytJf8ozTl+NELOOKKRx2ae1EbYyx6wYCtA5u4+1+CuCgMD
 FDatFkm5fXq1v0hYMoU93caDp/ohYA4rIIdWzqJlH/kSM2YUEhx/UmdqWihdl3JUVO70=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:
 Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uUqLR9oT2n12Yp+03B9g3oPlkoxl7gyLGZ/i/fFmgcc=; b=MWu/r11b7F/HYT+SAFoo7LzO/a
 0orbyAKVutRdWI+WwAzDZXYkOWjXIcaruZwv+1UGLgqBQpw1msZNI91f4LZ8sPaf26hyzjX2OThvk
 D5oBD7OKSUjtQMe+DZkiq2O/SZm3uHtT1Iwnq4UF6UrsXnQ3B01Pe9+O9BrlGsRbRa8Y=;
Received: from sender4-op-o14.zoho.com ([136.143.188.14])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.92.2)
 id 1kCBde-009b63-Mn
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Aug 2020 00:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1598748954; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S2QX7yzQPJCZibqlCyq6dF1UxdXMVkbj+EV6Z6tUeUC6syE5Ie7TZPxkY3CAjMvib9b20pANME8yV7yevs/nu9RLDy2KcQoAFpz09w9F4CGB9/nmCOUCjOwhAPlvl7PLCJ+ljN3CNliKPi7lUMQSmUz1Ej/QBQ5HmGQ6I9Ywq78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598748954;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=uUqLR9oT2n12Yp+03B9g3oPlkoxl7gyLGZ/i/fFmgcc=; 
 b=YcRSX6shQ0OOC4NzWKgBxaeWdsDdUMt7WXz6k3AGwfqztAJWBFx3s86YqTzI52AEAyZAF9Mq9OBFjBn9lbGZ4lEyZHWTGXtNFxsZpsIUSKxYRjaWvbM2Sqhs7b6e0T6zI4BD6CkphCds0WUKWAYaUdSJ4EfzQ5HEuDdszsZ7rFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=dan@dlrobertson.com;
 dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from localhost (pool-108-28-30-30.washdc.fios.verizon.net
 [108.28.30.30]) by mx.zohomail.com
 with SMTPS id 159874895136455.57581622016562;
 Sat, 29 Aug 2020 17:55:51 -0700 (PDT)
From: Dan Robertson <dan@dlrobertson.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Message-ID: <20200830003520.6542-1-dan@dlrobertson.com>
Date: Sun, 30 Aug 2020 00:35:19 +0000
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-ZohoMailClient: External
X-Headers-End: 1kCBde-009b63-Mn
Subject: [f2fs-dev] [PATCH v2 0/1] f2fs: check output position in move range
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

Changes in v2:
 - Moved check of output position before we lock the source or
   destination inode.

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

Dan Robertson (1):
  f2fs: check output position in move range ioctl

 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
