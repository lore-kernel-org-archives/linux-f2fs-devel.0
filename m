Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98A7C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BqnP3VDmK2hToVHljr7xXwZVmZWmLy0yMN4M1L5e3o=; b=hZgQrgBcuMPb8r9PGtmvf+wvkn
	3KB19mdnSOPlcDIQCO8nJyP9DSCLSdnEiQwpICi+7wMnbdclqFhraAn+vqlFA3M83EIzbU1oHc0R6
	1x4Fo012f71c8y6P0Bapc5O1EOuuP03fOxg/o1Vqp+q5SfK/M+g19Nbi9i1tL08tll+c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI1e-0002tT-0k;
	Fri, 24 Jul 2026 15:41:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wnI1c-0002tL-Pt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vp3uPHdG112SgKxd8a986oZMiBqWhSeCaU25fUr9XoI=; b=gx7kLZEr+7z0yz7q1ZKWHfsOEb
 3sSdtS7U0idykcukBW+6Ttrvw6BcOOeEgWsZD0nArwFDkOBK+0vwUhnfEuobn3dZ/DLjKZYs158rx
 UKQqQcYtd3QqjXQCA+7xwZjjpDI94EGaJf6HAC72J9dNYmZeTn1kpVjSWDgwJI85YIY0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vp3uPHdG112SgKxd8a986oZMiBqWhSeCaU25fUr9XoI=; b=jFthkYOAbbMVD9VGUHn2RwaKE7
 lHgYUqjL0b+jVOwikVAw8IYmkpznirIaAR0MmoTc0J6/xUgDHm/O0amT+A6EnNy3ORYqMf9jrOXv5
 KKURLbOm91ECJ6FTpyKv794aaxs/gl7WhRZ5/of/4jvWdbpuHdVeWw0MRfPQmmF/BX+g=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnI1a-0004kh-WF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC81F68CFE; Fri, 24 Jul 2026 15:14:30 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:14:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724131430.GC27878@lst.de>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-8-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wnI1a-0004kh-WF
Subject: Re: [f2fs-dev] [PATCH v13 07/23] fs,
 fsverity: remove check for fsverity being enabled in
 setattr_prepare()
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

On Tue, Jul 21, 2026 at 08:40:44PM +0200, Andrey Albershteyn wrote:
> The check that fs-verity is available in the kernel is not necessary
> here. Filesystems could have fsverity files even without fs-verity
> module, then truncate will succeed. Previously, this would return
> EOPNOTSUPP if verity is missing, but if it's not EPERM was returned
> anyway.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
