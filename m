Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF6BD72340
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvNUCvjrtKmBImqyeYs3ustJkBpqjOfMWoo9YTtvh4Y=; b=iiXa+XUMeww8i3K8Qyuecihpya
	D+vMZJ8byG1Crr9F+WbVBAQU3uLLm7Sz7M/8IHWVgcy43XHWuhauEM1d04NoW/OFJ6uSik72NCPdG
	ub+1HNSmK8pzhc8uV8dZ2lMI+6zACQ4p5lhGwDVnuzyEsTCrSpRjqze01EGh7nTe7CQE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjBXE-0001eK-Af;
	Fri, 23 Jan 2026 07:24:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vjBXC-0001e7-U2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:24:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D5hT19nk1G0CmEcMDf6P+tt6pycdzLu56FhXz3+jIfo=; b=WxAOdo7U3yxIUmsuOMUANxltYB
 fBzZIq93oMTJL8AfNFB8p2FH/rY+Ql73PjbtZr0yhjzWoMUKI2xQC3rXyHewa41h2cdrXJPxjZ0Jz
 Cs3Q/hZfiVdd+UQ00ySFs/9cCkaJRHqoxR+aopExr6UmW5JIit2kB5b5XgpnvLm2bsEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D5hT19nk1G0CmEcMDf6P+tt6pycdzLu56FhXz3+jIfo=; b=g8GfBP8OCxy5f8gxQbfIJir/cP
 32ipG0cvZyfdtJNm2KwtUoliIjFQhSi7WNd/CJh7L8E11xNOJ11hVHsqXphwDWk0yxH7YEht7KlYH
 BiJNyAsbW+x3CFCOa80w9I34Cxzx512HmQXx1nBq+FXahAwE+RIr1JKX3XF/Ua99bVkA=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjBXD-00038j-3J for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 07:24:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 06C25227AAE; Fri, 23 Jan 2026 08:24:34 +0100 (CET)
Date: Fri, 23 Jan 2026 08:24:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260123072433.GA27421@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-8-hch@lst.de> <20260122214958.GG5910@frogsfrogsfrogs>
 <20260123051556.GC24123@lst.de> <20260123072329.GL5910@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123072329.GL5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vjBXD-00038j-3J
Subject: Re: [f2fs-dev] [PATCH 07/11] fs: consolidate fsverity_info lookup
 in buffer.c
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
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 22, 2026 at 11:23:29PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 23, 2026 at 06:15:56AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 22, 2026 at 01:49:58PM -0800, Darrick J. Wong wrote:
> > > Well this is no longer a weird ext4ism, since f2fs also needs this,
> > > right?  Maybe this comment should read:
> > 
> > f2fs doesn't use buffer heads.  So this is just because ext4 only
> > implements the easy parts of ->read_folio and ->readahead itself and
> > falls back onto the generic code for the rest, which then had to be
> > grow hacky ext4-specific bits like this for it :(
> 
> Yikes.  So I guess we shouldn't genericise the comment to encourage more
> people to do the same thing ext4 did?

I don't think so.  I actually need to send a ping to the ext4 folks
that maybe, maybe they really should handle all reads into the page
cache in their own code so that we can hopefully kill this entirely.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
