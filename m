Return-Path: <SRS0=qvT3=WI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9B2C433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:01:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0913D206DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Fcc90R5s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UtcgWkb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0913D206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hx90q-0004rC-Ga; Mon, 12 Aug 2019 12:01:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hx90p-0004r5-5w
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Aug 2019 12:01:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Message-ID:CC:Subject:From:To:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FGQXMbxiqUI1xZ3Nq4AUE8u/GaLNExJNLsuQ3ajptCE=; b=Fcc90R5s+QL/f6dP0fnWzzYPr+
 xEa+cAbWe6BJegKgw5y2vQ7S2uNvRX5nXztjt0WMwzZXMV8Ir06SnHo8Ggm7o77P862PrpyTLKnKq
 LtWs8E3JI3nSiMtCbh+geS7U3VtTemGO+SiAGTd/fI/Ih/qj5Ovtw2EXWKXLnTt6orog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:CC:
 Subject:From:To:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FGQXMbxiqUI1xZ3Nq4AUE8u/GaLNExJNLsuQ3ajptCE=; b=U
 tcgWkb0ZHTm5SY6gUBV0kRrRdJ5uj6ug4oNazJjXtFFMnHAWw/3vgHOYV/DbjIkWOGIZlkmFurF4F
 gf/A+HfOIPVzeEfa0GuhDMYMTl44U06yf/zFpZ8dsN4mfemBz1WevAay+lNjD48gIqyn+iVGAQ93J
 pqNUpsjPR5Sr3xVg=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hx90m-000dK3-Vn
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Aug 2019 12:01:19 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 46AEF25BA7D14820FE4B;
 Mon, 12 Aug 2019 20:01:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 12 Aug
 2019 20:01:07 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3bc8584e-651c-9578-c25a-40c60b5cfbdb@huawei.com>
Date: Mon, 12 Aug 2019 20:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hx90m-000dK3-Vn
Subject: [f2fs-dev] f2fs_symlink bug
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

In por_fsstress testcase, fsck reports below inconsistent status, I found one
path can cause this case.

[FIX] (fsck_chk_inode_blk:1002)  --> Symlink: recover 0x1425 with i_size=4096
[ASSERT] (fsck_chk_inode_blk:1030)  --> ino: 0x1425 chksum:0x6983d47, but
calculated one is: 0xdb284b35
[FIX] (fsck_chk_inode_blk:1036)  --> ino: 0x1425 recover, i_inode_checksum=
0x6983d47 -> 0xdb284b35

- f2fs_symlink
 - page_symlink failed -> f2fs_write_failed() will truncate size to zero
  - f2fs_unlink failed -> symlink inode w/o data will remain in fs

Not sure, but one choice of fix is to treat symlink as fs meta like we did for
directory, so that checkpoint can take care of all data/node of symlink, any
thoughts?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
