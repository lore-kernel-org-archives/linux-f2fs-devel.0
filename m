Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C555109C034
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1n2bocafqvghwZYWnHAMFN8QYljEYQ2Y0BjHx0y0wc=; b=UritjZIvcfhOHc/RdJmKorbB4f
	oqmX9y+nNVfRI6QgRYgas+Kp5RrQ7dBNdnalTMcbT53ybkuAkIFAvO0Mp6RPOd7WdsRhua0+BQu7W
	22V/uARZTlO9GyJuC7H16j/CNH6Q1izpvZpg6/kKW5aCX74fCH+XpObLSk29y+4zysYo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5QEl-0006y3-5k;
	Wed, 25 Mar 2026 15:33:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5QEj-0006xw-5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BRxLAD5LKF5cjGrLrGDf1pCupjHl6+C9Elc1FIuKjPI=; b=VF7qg/OG2Z86Il88d+Up+wL+/T
 qnbbZKC5Yq3yGjYFRYYzvoQlKPKF+HuGQB53N62rlbRbvtB9TFx4BUWXTKTjOqn/6vsgPZzs/Zjmg
 kq91hI12Lx9XBQ5cQvcwRp2i6n+nofZpjqLXqY2TzxKGaj+pZ0ArvwVEByAx2UW7xgik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BRxLAD5LKF5cjGrLrGDf1pCupjHl6+C9Elc1FIuKjPI=; b=BWp4rOhWX+LR3KqMgfkbVwlFY+
 CJA9GUDKE9NngrwBMTRadMzLIE9F3Ca9OXfd7O+Nl6bGkU1RpOt4FEPDx9qLgO/RxCZNvgT3BRReQ
 ChvSy66J//TEENx9VkwFQ7AVVF1q5r5o1KLT0pt5tv2bFwrWmzqie8hweabctE6Zw1dg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5QEi-0001ua-Gv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:33:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 11D6C68BEB; Wed, 25 Mar 2026 08:54:03 +0100 (CET)
Date: Wed, 25 Mar 2026 08:54:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325075402.GA952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-2-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-2-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5QEi-0001ua-Gv
Subject: Re: [f2fs-dev] [PATCH v5 01/25] fsverity: report validation errors
 through fserror to fsnotify
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 19, 2026 at 06:01:48PM +0100, Andrey Albershteyn wrote:
> Reported verification errors to fsnotify through recently added fserror
> interface.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, would it make sense to enhance the interface to tell why the
data vs considered lost?  i.e. checksum failure vs (part of) device
disappeared?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
