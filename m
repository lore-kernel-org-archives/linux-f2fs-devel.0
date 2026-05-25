Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DFBCD5BC0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrhDnWRhQXTOd5mNImTlszmpoysLCFhkO7qkw9T1xTY=; b=MQAGBhhweiSHJstP4penuo8PlU
	BEwyflmQkBvOXeIfOJr7pS1Q75by0LfCWR4HDZY9HeCbKec+uUKW9kkMCc0WOfyCOFLlPR5cTFzd7
	yckzQq/w30uiyIG5AQs1IX9uMJZSmea2HEz1MQSTV3zWVWY7Sz2nOsKyZPf/6zTXWZd0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRNy1-0002hx-9H;
	Mon, 25 May 2026 05:35:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wRNy0-0002hf-Cx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SjOlFOCBBZ2U5TlW9/X+d8/c+UE/9CSqg4DdbFuTHrA=; b=BN1yq+unHQT+nA9OjVMu/zqrLr
 3u6KnlMQE+DIp40RZQGkq6PYz44RWG8+t9zRDaqZqlv2kD9swmpXnxPsQxo+oiW0lnuF3Bl/V46fL
 XW4u3TxdJevbel37xYTKBHHjZNDZKx7dWCcrlDHUJ0MoGTOycgFK1uSAMJbA77L4m5/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SjOlFOCBBZ2U5TlW9/X+d8/c+UE/9CSqg4DdbFuTHrA=; b=WqbSzaWZi3gC1PRLM7SM1ZHs/J
 lNvzUVAeESeI2ChNcoRS1NFBNmgJaeocenpWfOY1El+wJA88LVUeuqq+qdnyFWmcrVyj6RCPnmmD8
 l/nfO5nmal6jLA+M3+hoitT8/9HBJUfWgxYQ8d1FF3dFt+tjC7iCGYkEIGK6DFh6EnG8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRNxx-0000nM-3R for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:35:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SjOlFOCBBZ2U5TlW9/X+d8/c+UE/9CSqg4DdbFuTHrA=; b=PoRi9mLv+pykgcHYmVN+LtRYwG
 o84cO0GmTfh7sTw5dKv4OPvIhTi4W1vIUduN4gLw3pMAOJl+0eBfGzQOdC8FL55Bc297/BjTtk8Ud
 LI6mJV81v6Rjcnf6Zn0gIuovjWt/YscFFyxZRC1x8zzsXTzUN/VEHmfPFaV3YlKVzL2+hi99YOOQm
 CvD8I9B83nWnR/LHHeuCkU5k4qu8bq0/EbcDn8wddjuk6dxsIDDegfy+OIUOZ1gxosuGGFfXGBDKW
 HHj1G/KwbB3CTTeke2TqJG3zO7g5P3tGR9zSruJKvZTKBnmlzYu4LtTtGsnvzdgOhgU91M7/R92hi
 VyvvcuaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRNxm-0000000GKdP-08i4;
 Mon, 25 May 2026 05:34:54 +0000
Date: Sun, 24 May 2026 22:34:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahPffhaOi2CBtWof@infradead.org>
References: <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahBii6bk0KbK_NHV@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wRNxx-0000nM-3R
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> This was a quick buddyinfo right after booting the device.
> 
> Before:
> Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> 
> After disabling EROFS large folio:
> Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856

And what are you trying to say us with that?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
