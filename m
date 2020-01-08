Return-Path: <SRS0=jKbZ=25=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10298C282DD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F3C20692
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lY3+1v/H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IW/GxFiI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EY7ctXSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F3C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ipEee-0000Bz-7b; Wed, 08 Jan 2020 16:58:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+7810ff36a5d14e23d204+5981+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ipEec-0000Bl-D1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jan 2020 16:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2/grOTBgUAvethVaNAqsX059fFfNkvhqoW88UGGxm7k=; b=lY3+1v/H57XHPTaW2gDVB4Zjyy
 WUPqIP9wMfSkNSaBXzkAu+Z3I6iQhk++l7aFDIYsl0STX55a3Xfn5hKHllH8wFeDyL7GHBPrZ7M8d
 M9fRJo3kC1vW8EId19eU3K7oGOvOBBU+rTqPDEOtFVju7kNLbiMeEMSHTvBsSYMZuP3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2/grOTBgUAvethVaNAqsX059fFfNkvhqoW88UGGxm7k=; b=IW/GxFiIU9JRkzedt4H7h1jrHC
 19zSEFReDf6vCzxOS1qTqG78YMUWojy3FTOu/OHaZk4lH0SnzRbPClfN4wS4l9z160Q/bdyfLyG9Q
 e4ZYkQbFT8Ptv6EP1MWTpiPl+q+aISGUGOlveyrQsV9GwJ+b5QM77VAlqdmOLonCCPpg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ipEeM-00DcUY-33
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jan 2020 16:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2/grOTBgUAvethVaNAqsX059fFfNkvhqoW88UGGxm7k=; b=EY7ctXSukj3r60Zq9V0xRGPZt
 pcoHDTBrU9/U/T9W/u7/lPBqYmJdHvn5joBgWqzJu1kAAB2agXa5CJ7F/4uJphAZaXGoYTLf6G5/P
 gcJvpUoZeccH3ZtoOX32cTJpBHYG4bWhyo6nyjiT6dZmk740K9aOUnm8QH7rSdOi2RFCL8bD+uHyw
 QMufaqnCW10JBHm5uCzrI3oylj/Q+JMQz+H5+Is4pS2PxVaj+FSGfRn1VBAKYsNfDu02oZlBsEDqJ
 sDCbs19FvbQfZpWPe5oSLlGfx2J6RXwCniDvD/bOgDRH5OzetrI29+4h1GU4MPNhYPQahNaivzf1l
 /o3ltpAug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ipEdq-000890-Pg; Wed, 08 Jan 2020 16:57:10 +0000
Date: Wed, 8 Jan 2020 08:57:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <20200108165710.GA18523@infradead.org>
References: <20200108131528.4279-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200108131528.4279-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1ipEeM-00DcUY-33
Subject: Re: [f2fs-dev] [PATCH v4] fs: Fix page_mkwrite off-by-one errors
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
Cc: Jan Kara <jack@suse.cz>, Adrian Hunter <adrian.hunter@intel.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Sage Weil <sage@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, YueHaibing <yuehaibing@huawei.com>,
 Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I don't want to be the party pooper, but shouldn't this be a series
with one patch to add the helper, and then once for each fs / piece
of common code switched over?

On Wed, Jan 08, 2020 at 02:15:28PM +0100, Andreas Gruenbacher wrote:
> Hi Darrick,
> 
> here's an updated version with the latest feedback incorporated.  Hope
> you find that useful.
> 
> As far as the f2fs merge conflict goes, I've been told by Linus not to
> resolve those kinds of conflicts but to point them out when sending the
> merge request.  So this shouldn't be a big deal.

Also this isn't really the proper way to write a commit message.  This
text would go into the cover letter if it was a series..


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
