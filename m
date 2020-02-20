Return-Path: <SRS0=SnCE=4I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CCAC11D0C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:02:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962C6206F4;
	Thu, 20 Feb 2020 20:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="blDwl7Y3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hp0JnupL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otE+N0vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962C6206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4s1T-0004Io-75; Thu, 20 Feb 2020 20:02:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+d8ceb162cb84e4d8f427+6024+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j4s1R-0004II-36
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Feb 2020 20:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+/UHJ6F1pbYDweJDUZAgvqKfayrQBowwGTnz0WdYGiI=; b=blDwl7Y3C5+yHquKv1g5YCsvac
 Hrw5ygRXkdur0JpKGeDxS4NuBoprzZY34AL7ynyt1Fuv8y2RMXcGCT6Fh33odYRbMjGldDtbZrh0H
 WS2kX9761surJWc17/zD2VzQjvc6yxza3hQpEAJoOWYwqBHJP2DKH0oZA4sXmrK3fnZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+/UHJ6F1pbYDweJDUZAgvqKfayrQBowwGTnz0WdYGiI=; b=hp0JnupLmpl8BxkAkBiELq7f4+
 m/NHA5YXMbD7lDA6JsUB7tEdqHpKSdTXufgeIaabxFiNcujRbJseSH0OUkL8fzFIZx9bC+wq5rHub
 faUF1UeuQ4aNT3c/OmTGxabAs6RR4qmuscdrx6N8KF924zliQdbIpeyj4RHOU+K2BXn0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4s1N-00C9cy-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Feb 2020 20:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+/UHJ6F1pbYDweJDUZAgvqKfayrQBowwGTnz0WdYGiI=; b=otE+N0vtlyX9xN010Sejc78VWm
 +Z6Nhr8BvmGUNrIO9afuJHhxoLPaunjuFqSB3Vbfkg92cFJ3CGndTAJiSloW8688jbu+LsyPnwsfM
 7+EZh4a1KpVzbLiwzv7LZrgnYjvExYmxe48vBmhmvCOPmZ7sVJnLeHwyQwYksv3nnnaQLNldoXsYQ
 u1gQv6uFtIOengP5ajM30qweiLUQ49UDY3r+ygUvyonu17lsTwaYIiH/5oz7IhvQ4fhsYNWJY/9Ww
 eOATcZg8cPjWf2FcknrxS05+tCQGLf31jvSwLk8Ndl9n4CBxBjuYStE6NyuIbPzCKDkbX2IXV3hgI
 bWJ8ZdIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4oCd-0000Ht-HF; Thu, 20 Feb 2020 15:57:27 +0000
Date: Thu, 20 Feb 2020 07:57:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200220155727.GA32232@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-15-willy@infradead.org>
 <SN4PR0401MB35987D7B76007B93B1C5CE5E9B130@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200220134849.GV24185@bombadil.infradead.org>
 <20200220154658.GA19577@infradead.org>
 <20200220155452.GX24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220155452.GX24185@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j4s1N-00C9cy-Fb
Subject: Re: [f2fs-dev] [PATCH v7 14/24] btrfs: Convert from readpages to
 readahead
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
Cc: "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Feb 20, 2020 at 07:54:52AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 20, 2020 at 07:46:58AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 05:48:49AM -0800, Matthew Wilcox wrote:
> > > btrfs: Convert from readpages to readahead
> > >   
> > > Implement the new readahead method in btrfs.  Add a readahead_page_batch()
> > > to optimise fetching a batch of pages at once.
> > 
> > Shouldn't this readahead_page_batch heper go into a separate patch so
> > that it clearly stands out?
> 
> I'll move it into 'Put readahead pages in cache earlier' for v8 (the
> same patch where we add readahead_page())

One argument for keeping it in a patch of its own is that btrfs appears
to be the only user, and Goldwyn has a WIP conversion of btrfs to iomap,
so it might go away pretty soon and we could just revert the commit.

But this starts to get into really minor details, so I'll shut up now :)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
