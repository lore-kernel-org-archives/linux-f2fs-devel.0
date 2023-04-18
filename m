Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798D0C77B7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Apr 2023 16:07:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ponrQ-0005xr-JQ;
	Tue, 18 Apr 2023 16:07:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ponrP-0005xk-8U
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 16:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FDZnBEDu+ikq3D/KC2GhJ3TxrICBtm5OiFFqxphBwNU=; b=L8v9/Ble8PHh4c9J0vmpzHU9Yy
 0yHoy53ti64hQ3oXCvEA/yEcOApcj/spE3Pk6eZi5gSU0ZBFuBqUoRhcLk+y+70cIxSWaB0HvhARJ
 0L4VAJgO1fUvaZi0Z1m3thuxVovPBaDMmHTL+ModvRxTdp9cD1bm3xfJc0zENsgM80jE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FDZnBEDu+ikq3D/KC2GhJ3TxrICBtm5OiFFqxphBwNU=; b=ZvcrWkFF+T8dcfoWISy+8L4bdY
 lzT0XE50+Fuqpuu/B/1nqm/Fi57N9JvxhYxPEav1WiYGxHRQsMwFyVHCy631cUh1nZVtPNYtaByBo
 4Ws4qEkmpYS5QIgMAf1vy5nRJo+eMJ4H9L0mU77tKu+sizqaitnNWYw16oGWddT42zrw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ponrJ-0006vM-3O for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Apr 2023 16:07:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BCB3263642;
 Tue, 18 Apr 2023 16:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E79C4339C;
 Tue, 18 Apr 2023 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681834023;
 bh=nLK3HuPjSuFH/vS2H+8eBQtgXoA+Y82Z7zfq+WISfx8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=avsseWId/13Cvdf1kXTPI6USe0FJrQFGs4MG6TrSJxcnOtLhj6aAv47sEhbk0GcoF
 ozxEGyTlI2ONLQeyYiqnCgnHwVNDkaoB6VFiGJVlM1gxV6nMFltQEc4Sc7/xIyYbyM
 wexU2ee4vTwBr0GM7gGHFF1mL1aVI3mvSM8ne535DgKyFLRSjt7qj07h/CRjjRJ9YH
 3XEXNFaLdNPxPyO7fq3UylLAScovoCKU9JIzZczCrSU2+qQi6Q+gg27eM5lwrs/UHX
 9dqcxJ5cUORICAMpVeB+tDvkqf78wgnawffbYwgCHQgrFaPZxpfYa6BCraefvn2BCI
 VlW4ezJbSgw7g==
Date: Tue, 18 Apr 2023 09:07:01 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZD7AJT7ZYPji8TWk@google.com>
References: <20230414104308.6591-1-bo.wu@vivo.com>
 <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
X-Headers-End: 1ponrJ-0006vM-3O
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: allocate trace path buffer from
 names_cache
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
Cc: wubo.oduw@gmail.com, linux-kernel@vger.kernel.org, Wu Bo <bo.wu@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/18, Chao Yu wrote:
> On 2023/4/14 18:43, Wu Bo wrote:
> > It would be better to use the dedicated slab to store path.
> > 
> > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > ---
> >   fs/f2fs/file.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 15dabeac4690..27137873958f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
> >   	struct inode *inode = file_inode(iocb->ki_filp);
> >   	char *buf, *path;
> > -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
> > +	buf = __getname();
> 
> How about:
> 
> buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));

This looks like a hack using names_cachep?

> 
> >   	if (!buf)
> >   		return;
> >   	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
> > @@ -4374,7 +4374,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
> >   		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
> >   				current->pid, path, current->comm);
> >   free_buf:
> > -	kfree(buf);
> > +	__putname(buf);
> 
> kmem_cache_free(names_cachep, buf);
> 
> Thanks,
> 
> >   }
> >   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
