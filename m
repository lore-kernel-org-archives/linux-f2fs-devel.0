Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25123C2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:47:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sLnmr-0006qj-Me;
	Mon, 24 Jun 2024 17:47:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sLnmp-0006qa-Hp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yao0KXdlKc5X8m2RO1NZXJPBoZ1JXNVjAtjzDI46TtI=; b=e7Lt2smGZsYbOcxJMg2bMzSe/S
 Sh1zAu6VLprxwHRkVQbL1z78szCOwCVJPEJqfOHvWYt8YtaUvgSRcrDUQuDrhEoSXPNngKUEiY+RV
 GB7/TBxTg/Oe4hQmODgeXRuNz2+vVMNP+NGGPsnzaN/LJyl377mfUKBaOCn2619skGGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Yao0KXdlKc5X8m2RO1NZXJPBoZ1JXNVjAtjzDI46TtI=; b=iQSs/++aCoE33pg2cRrjxixUoo
 1hfExhRS0iwobyNo4ZPcwKjR8QI27Jlh2I7ikeolXCgMFPdQT1i5qH5MEXzuHdWoIWXUaG9Q4pzsz
 zSXrhQ+9UVGtGjrNnhWKXys1VlTE6vKpnsR4nWl1Vt/AZkmeXGvoEAFuKMSB6dH26EWg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sLnmq-0003B6-2Y for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:47:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EEB2C60DD0;
 Mon, 24 Jun 2024 17:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5AC2BBFC;
 Mon, 24 Jun 2024 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719251236;
 bh=Oz2btTRqlYmLB8ZxcZd8zXogqsv7FU1VjxDC00TshrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r0Fo0KSqW2CyCX7Y3Dw7BZ1VqIuLjJ+8QE6m2pl0mfJflxOEYR08quoEJs2t4dlA8
 WgjhZaa/w6GKP+sWfyq98B153uHKCiqBXTTRMi7EW58sxfTI6ZwlLWEmy+c1GnRdF9
 YzIoHJ5Fcj9lPkQ5JF+67Onv3tJLp07AxmSu8J00E4yN9+hK2JbFxxbdw102jazsfX
 KN+AMJ4mYslm/rcKBk5GwXtgnn5PJW8dh5dOTm6X0nk//PFCJShYLvuEDGExXUb7Wd
 eAmctgtf0I+oCWne4cs6HoTNEmQjdzPw9WJwplsGVfufvF8xMfjyb6fkpk4ak8mCsx
 AP4rEvDRvOqPQ==
Date: Mon, 24 Jun 2024 17:47:14 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZnmxIuq7sqopF-cJ@google.com>
References: <CGME20240611234050epcas2p40bd72d91c6a7b67e411a5ebfcddbcb97@epcas2p4.samsung.com>
 <20240611233906.2873639-1-jtp.park@samsung.com>
 <4a79eea2-e360-493d-8c98-d93aacbd4d00@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a79eea2-e360-493d-8c98-d93aacbd4d00@kernel.org>
X-Headers-End: 1sLnmq-0003B6-2Y
Subject: Re: [f2fs-dev] [PATCH] f2fs: add scope based f2fs_putname() cleanup
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
Cc: jtp.park@samsung.com, Jeongtae Park <jeongtae.park@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/18, Chao Yu wrote:
> On 2024/6/12 7:39, jtp.park@samsung.com wrote:
> > From: Jeongtae Park <jtp.park@samsung.com>
> > 
> > This patch adds a new scope based f2fs_putname() cleanup to reduce
> > the chances of forgetting a f2fs_putname(). And doing so removes
> 
> Actually, f2fs_trace_rw_file_path() won't change frequently, so the risk
> of forgetting f2fs_putname() here is very low.
> 
> > a goto statement for error handling.
> 
> The code logic is fine to me, but not sure whether we should apply this.
> 
> Jaegeuk, any comments?

IMO, we don't need this since it's a very trivial path.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> > ---
> >   fs/f2fs/f2fs.h | 2 ++
> >   fs/f2fs/file.c | 8 +++-----
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 1974b6aff397..284024c12ee5 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3402,6 +3402,8 @@ static inline void f2fs_putname(char *buf)
> >   	__putname(buf);
> >   }
> > +DEFINE_FREE(f2fs_putname, void *, if (_T) f2fs_putname(_T))
> > +
> >   static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
> >   					size_t size, gfp_t flags)
> >   {
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 5c0b281a70f3..c783d017ed28 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4511,22 +4511,20 @@ static void f2fs_trace_rw_file_path(struct file *file, loff_t pos, size_t count,
> >   				    int rw)
> >   {
> >   	struct inode *inode = file_inode(file);
> > -	char *buf, *path;
> > +	char *buf __free(f2fs_putname) = f2fs_getname(F2FS_I_SB(inode));
> > +	char *path;
> > -	buf = f2fs_getname(F2FS_I_SB(inode));
> >   	if (!buf)
> >   		return;
> >   	path = dentry_path_raw(file_dentry(file), buf, PATH_MAX);
> >   	if (IS_ERR(path))
> > -		goto free_buf;
> > +		return;
> >   	if (rw == WRITE)
> >   		trace_f2fs_datawrite_start(inode, pos, count,
> >   				current->pid, path, current->comm);
> >   	else
> >   		trace_f2fs_dataread_start(inode, pos, count,
> >   				current->pid, path, current->comm);
> > -free_buf:
> > -	f2fs_putname(buf);
> >   }
> >   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
