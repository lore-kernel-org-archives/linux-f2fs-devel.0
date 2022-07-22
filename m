Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CB5C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Jul 2022 18:12:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oEx8y-0006EB-4x; Fri, 22 Jul 2022 18:12:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1oEx8w-0006E5-LT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 18:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5iPBleV2UrfDaZPMMg4QczBWZh05BtXe3QutunZ70qE=; b=NY+6n9aklKfEfpA6ngctoKiZhi
 B+aHemQVSe12/34Trk+wUMhK36boDajnxSrLYWJKyIfMnCe94LsHsP/iU2gekgSUaoyVWJLoD9jB/
 HA/YGBvTSOjsgit2uB6fP8SK8b0f8m5F6s2e2zNEIVbqfb/re2b4wKWFNugb48uu1YhQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5iPBleV2UrfDaZPMMg4QczBWZh05BtXe3QutunZ70qE=; b=eWRsHhLtBjuMQFJ719YhEr/Qp9
 S2HTAJNir/Zqs0Wvpl72a9aWzEhBlWj/o0TVQz4o0sFXKH7COLqKlQ/gXNeh4Fszh3SnUaXKMwtFA
 FFnoeknxZV4fQWibT70VI/WHpqBZJmsriJzT7+hrOoM/Vnk5Rg1HH/t53pfi2qXBjH5Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oEx8q-0005Hj-3a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 18:12:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id ACB51622E2;
 Fri, 22 Jul 2022 18:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3060C341C7;
 Fri, 22 Jul 2022 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658513562;
 bh=SXPNOONZxoOFfrmPhLGGVYznyVMyiqiQEmogruZ0f5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BDmaxFrpcwMbt5VIMHUiAVjCWcU4o7lcqAfQ5IgmvUvBYcnYCHkaixWZo4y6wPZUp
 JbLzrfPnOGqWMO4KBF8PNKiyZKfXAyk7ejCOIi42se9wOgWRTvj/MOn/z76bu4Vugf
 edPq0KXLmyeXgP7SoxA4OQrENNzK5dn6qcrXy5hGovzBrXl5Ajd3ajkiN/pRSiqFpi
 bpiblTmMpLOHY792no6R7uCY5jtaB/ZZd5LvGkdzd6WXPw8auWKDbkfb9bS5nQv/Eg
 oiiuSkLzAJhQz/VsCfdc7CwantT0+epSWV2z+Zwph7rIi8+EU0Szzp5eiMRUu3CSxL
 IKSLzxZpxe1pg==
Date: Fri, 22 Jul 2022 18:12:40 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <YtromC4cR5a0mog8@gmail.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain> <YtrkJgwOmCGqPO3E@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtrkJgwOmCGqPO3E@magnolia>
X-Headers-End: 1oEx8q-0005Hj-3a
Subject: Re: [f2fs-dev] [PATCHv6 11/11] iomap: add support for dma aligned
 direct-io
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
Cc: axboe@kernel.dk, bvanassche@acm.org, pankydev8@gmail.com,
 damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Kernel Team <Kernel-team@fb.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 22, 2022 at 10:53:42AM -0700, Darrick J. Wong wrote:
> On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> > [+f2fs list and maintainers]
> > 
> > On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the address alignment requirements from the block_device for direct
> > > io instead of requiring addresses be aligned to the block size.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/direct-io.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 370c3241618a..5d098adba443 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	struct inode *inode = iter->inode;
> > >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > >  	loff_t length = iomap_length(iter);
> > >  	loff_t pos = iter->pos;
> > >  	unsigned int bio_opf;
> > > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	size_t copied = 0;
> > >  	size_t orig_count;
> > >  
> > > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> 
> How does this change intersect with "make statx() return DIO alignment
> information" ?  Will the new STATX_DIOALIGN implementations have to be
> adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?
> 
> I'm guessing the answer is yes, but I haven't seen any patches on the
> list to do that, but more and more these days email behaves like a flood
> of UDP traffic... :(
> 

Yes.  I haven't done that in the STATX_DIOALIGN patchset yet because I've been
basing it on upstream, which doesn't yet have this iomap patch.  I haven't been
expecting STATX_DIOALIGN to make 5.20, given that it's a new UAPI that needs
time to be properly reviewed, plus I've just been busy with other things.  So
I've been planning to make the above change after this patch lands upstream.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
