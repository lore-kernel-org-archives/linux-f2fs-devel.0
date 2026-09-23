Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9982CC982EA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awdpgre5ox5uRj44YNgcDp4EbycyrUR+CVD6qlp0xq4=; b=YLIw5xgaB4VgxWZTNkTAkz+EGI
	9bY/QIFsFr5d9aks/561hbBOIzCjxAn+kB4Frhp3d2vp+I4264fP4sexiMdOZnnTgwn6vosqaglDn
	8aMwaWts84yOcjXWFMMlu1Q9ZNars+0HzWK8zIi5FQwIjYk8fUmjgvGrH91CfWbwAjHM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9Eq4-0003Wn-TO;
	Wed, 23 Sep 2026 04:44:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+19c7796b17eaa921aaf4+8431+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x9Eq3-0003Wh-LT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 04:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3rrTkfCLkv5vG8mm0BkucV5d5ipKmcNjzN+oEKrrF4Y=; b=eGc0yzQ/C4Hob7ysLbuxbEEn4x
 it2DPIjBEwQdVpFNC+yjTMJSH7/smxbnD6SrRqfSxwfWimX3APrAHkDpUxtKce32Qj/SdtiXBQET0
 9WYFg+u9oFuIKg7iaTznL5fG/7Ck6rbFuzcDU7eSe1m4lu7c+o/gS1BEEWeGDkgrCTAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3rrTkfCLkv5vG8mm0BkucV5d5ipKmcNjzN+oEKrrF4Y=; b=b9HqvRx/9MwTlXPJHUGsomRCnH
 DUUq4dOCSsMS2CwVVsjMMSt5PUrglFO05SMu/JoelN4XevhVOvRHnHNVmHnLf5WlXBXZ0sdP8U3xt
 l/HseHBYvmjP9a8ccywYZstCm9SqdrWAzgvnduQ95c0UoUE3QdcjfLP8QIhEf+eNhcvY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Eq3-000376-0V for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 04:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3rrTkfCLkv5vG8mm0BkucV5d5ipKmcNjzN+oEKrrF4Y=; b=JOydNZmkvLmfHed3Px4rMYO9fW
 ovH3G1XC9S1RqxA9m4xOFtseOap20xWrt11xXV9ro3mhmrMkwLiQYjNx9DJ5OU/jVvreTwXo7wkz7
 E1RmjRTmmDGMGPxsBWYQg7xSUEeom5MHDX9CHR1Q4ZreWi/JrfahFI/iCKtQ8HNGSMoQ2dhqsLcdd
 2SfRB5K4vBZ5g/6EgsFwSXMO/pALL7eqXnGTTnUKUmY+YTY/dtuus6GWDlk6fsqjUDYTUemDMYNPE
 1Tcaegw/NCnx2HYskpeIz3PqJkEAbcypYR6nU9GSgrKqBcV4Y/NKFmDUOpnxl/f+lLsiPYVaScByF
 3j9NSTaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x9Epv-0000000780Q-3ycD;
 Wed, 23 Sep 2026 04:44:03 +0000
Date: Tue, 22 Sep 2026 21:44:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <arNZE37P5khvkJYK@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
 <arIszDCcy0VbRVFp@infradead.org>
 <arI-5Ejg0Xw7OVmH@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <arJ1dfejt4DyCsvG@infradead.org>
 <arKAqsuSoxvM1yKt@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arKAqsuSoxvM1yKt@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x9Eq3-000376-0V
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Sep 22, 2026 at 03:27:54PM +0200, Andrey Albershteyn wrote:
> > 
> > Yeah, but what is the ilock trying to protect against?  ilock is
> > the innermost sleeping lock and protects modifications to the
> > inode fields and the extent mapping.   Higher level synchronization
> > is done using the iolock and the mmaplock (which is already taken
> > here).
> > 
> 
> hmm maybe I don't understand what you addressing here but don't I
> need ilock for xfs_itruncate_extents() used with this transaction.
> So, doing extent removal.
> 
> With this function I want to remove post EOF pages from pagecache
> and then remove post EOF extents on that inode.
> 
> iolock is already hold, mmaplock is for pagecache truncation and
> ilock for extents removal.

So there should be no reason to hold it over the call to
truncate_inode_pages.  I.e., you should be able to move the locking
and ijoin below that.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
