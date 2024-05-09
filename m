Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57537C10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 May 2024 15:50:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s562F-00053M-CW;
	Thu, 09 May 2024 15:50:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1s562D-00053F-CI
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 May 2024 15:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WYxU5HJMz5HLIBUR2c0Dd6ti9T3sxll8z9kvkN/FPNY=; b=gSQNDlJorzwbUBs4Jou6wWycHi
 rfJiMyU/hrMxXA5mt6x0tSXRGhOBUviFiZ28sXxSdKMR0RCffBotDgw2PzBXgM36Ebr37Z41qkA6T
 JazMGvN+w7AHD1/Zxp6AQHUTSnG5aLd1l9q/3BxNFxzB2wgnSFF+S8HN8EVPBvIIBDXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WYxU5HJMz5HLIBUR2c0Dd6ti9T3sxll8z9kvkN/FPNY=; b=Ceo2MIdaU2kfKXwXgRwxRkwb9L
 OYjZF3syT8TsoJblFB7v2/Wohb6N5UIIBZjbTaD9KFZxVKzNqN0Xr2sLrAKDhb4WruJLTxILtytkc
 sIQumz2WceoZyrJA3zG+Xu42ImGGqDkjSurfFyCLRAM2spxh44XdSsp00yAz1kDVUo5s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s562C-0007t7-T5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 May 2024 15:50:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BFC86617C9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 May 2024 15:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49948C116B1;
 Thu,  9 May 2024 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715269810;
 bh=PVYxLVi7qmywbA3AVz6ygRy87Rw7WwcdjDJdNALqThU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LsWqlUPisLmYwN5tQdh1E0gO+IF2GCueWzv/buL6tw9bnn8FsE72xoBX/eQXqBH1s
 zQ+0cM7qRPDj20bIlatAyK9pebFMCpVhjCCmbi8R9zCYivIw27cKj/Czh437tqYUIM
 4W63s66NxRCvzJnVSvI3ogR2uNmF5rJ6GOxpSzwd15/np6b1L/NmIW7AqO39cciat3
 hOcDvePD6rq/sQ6Jiec1y/hh2won+7aSn1ltqAG//jfYcO5EbjOeWyQF73qhn0rk6x
 5oz98MkpLKG0DqznXsPzMHu78krvF+aCBMebSP+p0AylW5cPHv7mY9DZrmtiE2ENpt
 037Liu2sNSEag==
Date: Thu, 9 May 2024 15:50:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZjzwsB2y0AVNWY7X@google.com>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org>
 <Zjwc5QGJfm6XXzOX@google.com>
 <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
X-Headers-End: 1s562C-0007t7-T5
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
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

On 05/09, Chao Yu wrote:
> On 2024/5/9 8:46, Jaegeuk Kim wrote:
> > On 05/06, Chao Yu wrote:
> > > During gc_data_segment(), if inode state is abnormal, it missed to call
> > > iput(), fix it.
> > > 
> > > Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
> > > Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/gc.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 8852814dab7f..e86c7f01539a 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> > >   			int err;
> > >   			inode = f2fs_iget(sb, dni.ino);
> > > -			if (IS_ERR(inode) || is_bad_inode(inode) ||
> > > -					special_file(inode->i_mode))
> > > +			if (IS_ERR(inode))
> > >   				continue;
> > > +			if (is_bad_inode(inode) ||
> > > +					special_file(inode->i_mode)) {
> > > +				iput(inode);
> > 
> > iget_failed() called iput()?
> 
> It looks the bad inode was referenced in this context, it needs to be iput()ed
> here.
> 
> The bad inode was made in other thread, please check description in commit
> b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid
> inode").

Ah, it's non-error case. Right.

> 
> Thanks,
> 
> > 
> > 
> > > +				continue;
> > > +			}
> > > +
> > >   			err = f2fs_gc_pinned_control(inode, gc_type, segno);
> > >   			if (err == -EAGAIN) {
> > >   				iput(inode);
> > > -- 
> > > 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
