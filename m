Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD808C44500
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OV5+xGgh8xzglSrQ/rLXa18g0P6/QOgRGrku/mLuXCM=; b=F/qaRAEyFIJ9tzH8kiyocSgDCS
	TXc2kv2z+rNN71J2qGpyeo6PqMfgUd9CZbMT1SxIqVh8NyC/88jKqFnnrJm4Vts3722YIQ53yPTp+
	vFVBRHakP1/Z3qk2NFZH9N5TTfUwpIJ6/Z0o/eDs/ZMmL87OI5YwSdR+AMAuelCcL/eQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viq9J-0000Bj-NS;
	Thu, 22 Jan 2026 08:34:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+561f00ef1fac768e3611+8187+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1viq9D-00008u-0K for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 08:34:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wyKG6mSVnYVdf6WsGgp/YJqBxiUMWc/coML45itFX9Y=; b=R8D5TK4dnLnBxy4BG+QFNth5Fs
 O4kpwEEOggsDuh6dJeE+b1e2ppVMF/AgWsJDoMMty7bIKzLxa74XJYtWmxJnZXu44/dZ51CGZsXR/
 iKEcZa0LwN4mb+pAIsBZ7wrflZFT0XoM6p2iH/Bq8W4zCc5trG7eXXNB+EwJcVbZeLbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wyKG6mSVnYVdf6WsGgp/YJqBxiUMWc/coML45itFX9Y=; b=MVFPK9bgWSMDvltcB8GVBBKn8+
 A/MuYWVOxSRL5N3r+2+fDPaTB3GlmERngDcXRUaJyxRHdN5u6xJJ2N0/9Xv6706FMzxSJqlG/oJL6
 P5hghLzfhpKW19kVLK227f9IM/WgFKTAwY2jUDdcQgTTOy8R4aCADqIbbFH5ngMrP2jI=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viq9C-0006Bw-Ha for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 08:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wyKG6mSVnYVdf6WsGgp/YJqBxiUMWc/coML45itFX9Y=; b=2moXo0MM7AqnOr1r91L6tzTt0Q
 8Y4djegXXpfVa/iRYwy5+HfmImkZq/F+jqFu0eN101xM1Pg4Yrcu22qbT5qeBmFHTF99Bh2iU2yqP
 NDIWpRfPtHUvqb5CZQ+RrNe7mFT79LRaVE7alJFRxUFZva1lmQtuTOHuNG5guqb6Z3G+9W1HzS61b
 vl/P6QVlwyhzxjm3wXWTGtIw+fewNWfjVG8hDKxyaCGgvJuLMKdjcaSy8KvcI0wt54yOVytH12+GO
 H/T+2MD+uAlklTccD9cnGVXmeGOjcl+CCavvGFgDqXe2LExL4CnOnZPvlEGe0Q+98/UPz13rAA08k
 2sNAS85g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1viq96-00000006epL-3gs3;
 Thu, 22 Jan 2026 08:34:28 +0000
Date: Thu, 22 Jan 2026 00:34:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <aXHhFN-feFYFcKYu@infradead.org>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
 <aSALfvLUObUGSx-e@infradead.org> <aSCpzRW8mUhNnjHB@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSCpzRW8mUhNnjHB@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1viq9C-0006Bw-Ha
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: improve readahead for
 POSIX_FADV_WILLNEED
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Nov 21, 2025 at 06:05:01PM +0000, Jaegeuk Kim wrote:
> On 11/20, Christoph Hellwig wrote:
> > On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> > > This patch boosts readahead for POSIX_FADV_WILLNEED.
> > 
> > How?  That's not a good changelog.
> > 
> > Also open coding the read-ahead logic is not a good idea.  The only
> > f2fs-specific bits are the compression check, and the extent precaching,
> > but you surely should be able to share a read-ahead helper with common
> > code instead of duplicating the logic.
> 
> Ok, let me try to write up and post a generic version of the changes.

Did this go anywhere?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
