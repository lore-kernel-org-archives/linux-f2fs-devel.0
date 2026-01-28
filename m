Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB1CD3566F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5xRWDLoAxtn+KsxlmCDSWEw6nZN0cD41es3B7TI+LlE=; b=IUGduraUNJN+KDEQj1ObIULw2V
	OH15MMcV+MqD/O/um8jch8e2X6FXV48WecJOpGXZPr4fO1U7Z6kLyR8+6slid5OnsVpXyw6Dull6d
	6Flhb+1hNb9NSjXSN9oOQ03cORpqDcbo0Hkvj1IsOQ2P/O7O66aKenpqk077rJBYgiSw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkwXz-00034G-U5;
	Wed, 28 Jan 2026 03:48:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkwXy-00034A-UG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:48:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dLiGlREeMT858PQ3Gpz22kWtl8jzsKSpPWko3/4HMVQ=; b=lvTHdJMBR4BaKl4d0LH66Cyg27
 tVCzKali++WPE5hlPTRutY4gbKTceBiQXRM6Qw+XKQHb3NNLAHelrelEEps9gK83G4SLE02LRK1Q5
 wE2PxcizA6y//m40IbHHL43Q8vowmiB+5svzDNRDf6FKJXeoemDY9oVDn/AnJD8oRyk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dLiGlREeMT858PQ3Gpz22kWtl8jzsKSpPWko3/4HMVQ=; b=klx2nj77mrLIO1XfCg7oTLKMGI
 Cu/7QdpKbAblqZM10A0B70pi4l64C+umKeEvTvOwYi9RU3elPNlWfKX+jKQY+ELr7rvd03uqiqtz8
 mcUNg56RzkmQ11LSEwQ6JexRDkYaQbXe5qr9beEKT5fXwkLyOzRbUV1rzhVIdDfaUlOs=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkwXy-0001Ls-Fs for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:48:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE668227A8E; Wed, 28 Jan 2026 04:48:38 +0100 (CET)
Date: Wed, 28 Jan 2026 04:48:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260128034838.GB31178@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de> <20260128032817.GB2718@sol>
 <20260128033519.GB30830@lst.de> <20260128034405.GD2718@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128034405.GD2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkwXy-0001Ls-Fs
Subject: Re: [f2fs-dev] [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 27, 2026 at 07:44:05PM -0800, Eric Biggers wrote:
> On Wed, Jan 28, 2026 at 04:35:19AM +0100, Christoph Hellwig wrote:
> > > Is there a reason for this function in particular to be __always_inline?
> > > fsverity_get_info() is just inline.
> > 
> > Without the __always_inline some gcc versions on sparc fail to inline it,
> > and cause a link failure due to a reference to fsverity_readahead in
> > f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)
> 
> The relevant code is:
> 
>     vi = f2fs_need_verity(inode, folio->index);              
>     if (vi)                                                  
>             fsverity_readahead(vi, folio, nr_pages); 
> 
> Where:
> 
>     f2fs_need_verity()
>         => fsverity_get_info()
>             => fsverity_active()
> 
> If fsverity_active() needs __always_inline, why don't the other two
> functions in the call chain need it?

I wish I knew.  compiler inlining decisions are a big of black magic.
If you prefer I can use __always_inline for the entire chain.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
