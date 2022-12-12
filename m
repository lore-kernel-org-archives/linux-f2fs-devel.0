Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D49C00145
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Dec 2022 23:05:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4rrM-0005r6-G8;
	Mon, 12 Dec 2022 23:05:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p4rrK-0005r0-Hv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 23:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vX68QzEG8TaR2u946P1xBUMPHIpJQFQjU2rlcfM+eCQ=; b=ThAhuNYiaUNCIn+lgz0COCRsmg
 UfLOHdgWI4zlbLu0nwHhDBqvAk2pYQTE1N9EzW+8iZ/z1VIdYlex2HgOeFMpTDEIPtATh5LgDW5Pv
 IvWzhm5V0g79sWmoOrSdFpQ1H2+Cvn5Fz8SJCgh9tV8uztNPfFgykUey3Rhbo/fqzY6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vX68QzEG8TaR2u946P1xBUMPHIpJQFQjU2rlcfM+eCQ=; b=iUeml/h8XEXXcpW1frOBIwCMoW
 23Ueu+ws4lcWUR+IJ49tAitugn5MSL29SfhJ/j/UnUA6slBxX3YXBsDrmmp47eRfC8BvzHBQQ+wso
 MAW3AKgMYjbixzECf76zuaH1IE1pKl4iF8YbQnwLHqnGvioGqHp1es65EyHBv/nTl4e0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4rrJ-00F9q4-CJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 23:05:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 23F75B80DCB;
 Mon, 12 Dec 2022 23:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD07C433EF;
 Mon, 12 Dec 2022 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670886309;
 bh=x0cHRAp8vVmV/XZj21AnddH1EoJNiefnFUy3qnybb6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b+/1GchgKTLX0JfWUgJtfxQ4wzp/NGEXf3sZVFK/yDrTCoKjwYrdMIM34Qg22IANp
 K+PcxbGsDnRoP8NgRvAXzEq0r7+/B9q/pXKRKYQnW/p6HIRQTL1lBHnHlCBjy5vGbY
 zxNp+SAIHriPUIvi5w0xS7o2zeru9lTLEm+9GIxBZu9M0lEjdZZJofNCAIEMAuBcP5
 nxteDNzk2ff5CyrVBx6xSEEOF9jiHYY7Bqcm377Uqi2vf17WSSrTLVNbKBZMuivlX7
 NqFmqDMCFDKi/weI5IAp3YEwCBJgO6lCwqprgcd67JBUZkQqF0Lt2t3KuSTcI6Qnhp
 tecPtKV2M1HPg==
Date: Mon, 12 Dec 2022 15:05:08 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: zhoudan <zhuqiandann@gmail.com>
Message-ID: <Y5ezpOwd8sOTTaW5@google.com>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221212122109.GA714122@mi-ThinkStation-K>
X-Headers-End: 1p4rrJ-00F9q4-CJ
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file
 is not compressed
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
Cc: zhoudan8@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/12, zhoudan wrote:
> Maybe I'm not describing it clearly enough, but I think there is 
> something wrong with the logic here.The 'f2fs_release_compress_blocks'
> method does not determine if the file is compressed, but simply adds 
> the FI_COMPRESS_RELEASED flag. 

I firstly lost your point since f2fs_release_compress_blocks() checked
f2fs_compressed_file().

> In particular, in the current Android system, when the application is 
> installed, the release interface is called by default to release the 
> storage marked as compressed,  without checking whether the file is 
> actually compressed. In this case, when compress_mode is set to user, 
> calling the compress interface returns ENVAL and the file cannot be 
> compressed.
> So I think the implementation of release needs to be modified, and 
> only set FI_COMPRESS_RELEASED when it's really compressed and the 
> storage is released.
> 
> On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > On 12/08, zhoudan8 wrote:
> > > In compress_mode=user, f2fs_release_compress_blocks()
> > >  does not verify whether it has been compressed and
> > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > return -EINVAL after calling compress.
> > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > is not compressed.
> > 
> > Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> > with zero i_compr_blokcs?
> > 
> > I think the current logic is giving the error on a released file already.
> > 
> > > 
> > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > ---
> > >  fs/f2fs/file.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 82cda1258227..f32910077df6 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> > >  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >  	if (ret)
> > >  		goto out;
> > > -
> > > -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > >  	inode->i_ctime = current_time(inode);
> > >  	f2fs_mark_inode_dirty_sync(inode, true);
> > >  
> > >  	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > >  		goto out;
> > >  
> > > +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > >  	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >  	filemap_invalidate_lock(inode->i_mapping);
> > >  
> > > -- 
> > > 2.38.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
