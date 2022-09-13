Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC378C6FA82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Sep 2022 03:41:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXwnf-00033T-0c;
	Tue, 13 Sep 2022 03:41:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangqilong3@huawei.com>) id 1oXwnd-00033N-JL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 03:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B3iNnSZVRm06lO8RN7lLPW4/igTYdEzTVZnK0HIYxqk=; b=MMyaHLKlJXhU0Y43JnZn83Z3eV
 nx7rnlEb26HjlgHuzMPyZB5MKW+GhnZZ1hAbQsdnhUkHJU3u2kOPJbYnp3ByD5q/40qEW8ringfGz
 NaPf0rxEL5vPclYWDWrcnhfZGTBzP/WCmj81ofw8x593vONNF15Dlx8rtuyZTHu0lkno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B3iNnSZVRm06lO8RN7lLPW4/igTYdEzTVZnK0HIYxqk=; b=HQq/x0eYB5LR/M7wb6pKy2nQSc
 GpHeOg0P1xOH6eK6tNOSWiKPogeZbU1IsQnUO/pRb7U/OsNliAt44TwyxrWt06JMVjhenQVGOOhu8
 i361OzRFfqXFKYzD4tpljwJSyikhXdNwCNzELG12F8ER9apditGOdXDiNMOQfcptuDgQ=;
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oXwnZ-0005n2-Ax for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 03:41:25 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MRTg05WlGz14QZB;
 Tue, 13 Sep 2022 11:37:16 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 11:41:12 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 11:41:12 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Tue, 13 Sep 2022 11:41:12 +0800
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Thread-Topic: [PATCH -next] f2fs: adding truncate page cache after being moved
Thread-Index: AQHYxx+z7HSWJPdxBUGNkR78i+7hia3ctEag
Date: Tue, 13 Sep 2022 03:41:12 +0000
Message-ID: <4430326a24364b6aa92332c1393509f4@huawei.com>
References: <20220913030529.3944-1-zhangqilong3@huawei.com>
 <293a41a4-7c7d-aac8-0bc2-15d47b7bd538@kernel.org>
In-Reply-To: <293a41a4-7c7d-aac8-0bc2-15d47b7bd538@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.246]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Headers-End: 1oXwnZ-0005n2-Ax
Subject: [f2fs-dev] =?utf-8?b?562U5aSNOiBbUEFUQ0ggLW5leHRdIGYyZnM6IGFkZGlu?=
 =?utf-8?q?g_truncate_page_cache_after_being_moved?=
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
From: zhangqilong via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: zhangqilong <zhangqilong3@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> On 2022/9/13 11:05, Zhang Qilong wrote:
> > If we do not truncate source page cache, user can still see the
> > previous source data after being moved. We fix it by adding truncating
> > after __exchange_data_block.
> >
> > Fixes:4dd6f977fc778 ("f2fs: support an ioctl to move a range of data
> > blocks")
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> > ---
> >   fs/f2fs/file.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
> > 771f1f7f3690..e3ff648aa496 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2789,6 +2789,10 @@ static int f2fs_move_file_range(struct file
> *file_in, loff_t pos_in,
> >   	}
> >   	f2fs_unlock_op(sbi);
> >
> > +	filemap_invalidate_lock(src->i_mapping);
> 
> invalidate lock should cover __exchange_data_block()?
> 
> > +	truncate_pagecache_range(src, pos_in, pos_in + len - 1);
> 
> truncate_pagecache_range() should be called before
> __exchange_data_block()?

I have tried it, but it do not work. So I move the truncate operation to the back of
__exchange_data_block that it works well. I don't know much enough, what do you
think of this issue.

Thanks,

> 
> Thanks,
> 
> > +	filemap_invalidate_unlock(src->i_mapping);
> > +
> >   	if (src != dst)
> >   		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
> >   out_src:

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
