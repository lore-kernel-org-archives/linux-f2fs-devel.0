Return-Path: <SRS0=mM0/=6L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7494AC54FD0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2020 06:09:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D112080C;
	Mon, 27 Apr 2020 06:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E8VtH8Ag";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cqeTo+Gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D112080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jSwwy-0005eI-R9; Mon, 27 Apr 2020 06:09:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jSwwx-0005e0-Fh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Apr 2020 06:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jarFmF2Oa82cNVc/HKobchz3BinECNtiAFkkvpNJtf8=; b=E8VtH8AgAmBNZ0a5UbhyMA8s1f
 nVZw4L+8o0m+Yaft2TMnnyktL0/+vNkLpAm49IJ1PKfJ0nSpEk7S9cRmgvaMMqq/ZgWdZl2QUg74l
 ahDmotY/flmGqMbDKuOZGVRREZ/qTP+tg20hKit4MvgnKsqQwSbtgMKTEx7bf7dXQktU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jarFmF2Oa82cNVc/HKobchz3BinECNtiAFkkvpNJtf8=; b=cqeTo+Ggu+VgD08YKnzbUUB8Ef
 bu7uzkzdCtfyGIS2B80ErubOBbqN4u9ZkDtHXIN7wB3ocTR9yRNEjm4HGN7kP4odELqOyh+a2Ixer
 8ytj4sZhX5pERJZQ56IFUHhxcVv/0kgaLzCAX21AWdIvfUnhRfVh/H2rNMwTZ1TLthwo=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jSwwq-00CRbJ-5y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Apr 2020 06:09:03 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3D62DCE1779533C62C14;
 Mon, 27 Apr 2020 14:08:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 27 Apr
 2020 14:08:40 +0800
To: Sayali Lokhande <sayalil@codeaurora.org>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <1587967204-24824-1-git-send-email-sayalil@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6cfb8f00-a36c-03b9-ffa7-12fe37a19317@huawei.com>
Date: Mon, 27 Apr 2020 14:08:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1587967204-24824-1-git-send-email-sayalil@codeaurora.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jSwwq-00CRbJ-5y
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: Avoid double lock for cp_rwsem
 during checkpoint
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/4/27 14:00, Sayali Lokhande wrote:
> There could be a scenario where f2fs_sync_node_pages gets
> called during checkpoint, which in turn tries to flush
> inline data and calls iput(). This results in deadlock as
> iput() tries to hold cp_rwsem, which is already held at the
> beginning by checkpoint->block_operations().
> 
> Call stack :
> 
> Thread A		Thread B
> f2fs_write_checkpoint()
> - block_operations(sbi)
>  - f2fs_lock_all(sbi);
>   - down_write(&sbi->cp_rwsem);
> 
>                         - open()
>                          - igrab()
>                         - write() write inline data
>                         - unlink()
> - f2fs_sync_node_pages()
>  - if (is_inline_node(page))
>   - flush_inline_data()
>    - ilookup()
>      page = f2fs_pagecache_get_page()
>      if (!page)
>       goto iput_out;
>      iput_out:
> 
>     - iput()
        ^^^^
			 - close()
			 - iput()

>        iput(inode);
>        - f2fs_evict_inode()
>         - f2fs_truncate_blocks()
>          - f2fs_lock_op()
>            - down_read(&sbi->cp_rwsem);
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
