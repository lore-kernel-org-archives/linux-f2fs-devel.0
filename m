Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90560C3DA70
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:26:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sYpgD-0001Ck-Aa;
	Tue, 30 Jul 2024 16:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sYpgB-0001Ca-LK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jul 2024 16:26:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=trucinTH/HQonaIoqAbCh+X2ScT1bvpR+R1y/CxbOMk=; b=B8TrKdwX/S551m04V4r+BdNh+z
 j0VnyTh4Ngd4jgxwthy+2QYaZ9cN/Xq8GmTSUxOgmxZDBzsS6gTTljtUvATemBAfAcihyFPuCDJFS
 /rJRIdFauhcVrlxbDbyeoqQS8h/GNVy36Vf2aYLzTENnvuU5OLHJ/ESHWlwhjjAVD5Po=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=trucinTH/HQonaIoqAbCh+X2ScT1bvpR+R1y/CxbOMk=; b=Rr3U8qUXlj3hwbNs+NMRxEBe5L
 RQ4JG8YWSoKEaHSe9dSOAb/u5YatHDdt86NSygVm7tleWP2XBhIEt3m9f8YqhA+XEpCUvV67iFF/g
 aQNtZXapCKf/voKgBwWHgcLOol2vMflMY+az6fC9j2ennIn3WTQXYGqhl8i09Xyred8o=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sYpgB-0006kU-IJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jul 2024 16:26:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7714DCE1133
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jul 2024 16:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A35C4AF0E;
 Tue, 30 Jul 2024 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722356774;
 bh=dVkDjxt+MI5jEKXFqONpZnrpH8uhWQCwH8FHk5L7onM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d3u52ZS9c4CL0IWkn7vhhTuSz7XyDFgkSuKPlGIFPE/gD6RSQZnWXREhxRVv/QOCj
 MNlYP2p1ZGfULYyLtAfd0m4VxV1WDZaOKkCBt8iwz5a9v5LS/PaIjHpdR5SVncjObM
 zfHw6cQVdGEYbNNsYlIGgNQOc2oe/oPSzJjTy04ullD/sfr/6Sa315KoJlKVJRdwB2
 s1Vu+IMdkN363Kw01f25oTbf/SPDmbQMCJbQYfS6xhm5PQA6Acp66FMx1DMCoAKnbq
 GXRnb1Q9SN0/hfUT18wuTGJZn274tUSDtH/xQ5WzdKGU1pzC+hFiDZbrFvju67B7Yg
 OrW0hM1+CFCCg==
Date: Tue, 30 Jul 2024 16:26:12 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZqkUJAMJzW_4ANhY@google.com>
References: <20240726012204.1306174-1-chao@kernel.org>
 <ZqfCwDcg7nvJPenf@google.com>
 <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
X-Headers-End: 1sYpgB-0006kU-IJ
Subject: Re: [f2fs-dev] [PATCH v2 3/4] f2fs: atomic: fix to truncate
 pagecache before on-disk metadata truncation
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/30, Chao Yu wrote:
> On 2024/7/30 0:26, Jaegeuk Kim wrote:
> > On 07/26, Chao Yu wrote:
> > > We should always truncate pagecache while truncating on-disk data.
> > > 
> > > Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v2:
> > > - fix to use cow_inode instead of inode
> > >   fs/f2fs/file.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 6c62f76474d1..54886ddcb8ab 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> > >   		F2FS_I(fi->cow_inode)->atomic_inode = inode;
> > >   	} else {
> > >   		/* Reuse the already created COW inode */
> > > +		truncate_setsize(fi->cow_inode, 0);
> > 
> > What if the below truncation failed?
> 
> What about just dropping page cache and do not set isize to 0?

Can we also check if there's any dirty page before truncating it?

> 
> Thanks,
> 
> > 
> > >   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > >   		if (ret) {
> > >   			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > -- 
> > > 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
