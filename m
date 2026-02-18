Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B24E9A03B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Feb 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8qfyoSPyPfjE0jCCqLhRQvm/sqiAGHIjfAWqfboNlU=; b=RkWhXHvppUywsCzc2Xd21kxPHy
	GRCGk4AKId7N+LufCrpLI6BBJjbLOuIGnXvD9TM47KX8VUXbamoNMX6WSdhxBBAMPOkrCmC2z4e8p
	JBeJqCqKTNpFapMc7owBMPZPpyzd5mJ9Oja2tut45/jqmBrMQ7KnxFHA3QsBRKJKmBoI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsaIh-0008Oj-TT;
	Wed, 18 Feb 2026 05:40:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b7a6f314dcfbee4e7dbb+8214+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vsaIg-0008Od-8r for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 05:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=i/rZBo7FJmNNRgNcdC8PpZCpuw
 y7tCvM18BVxvDHGgIDwnRxW81qtqWXs3ZeZSuL91GyKI7Qh2G32Q+AkxaoW1MaPmeXBkEZzh7z49j
 9z/9cYOtmcls8WEEX5ZRTaH3dfTf5MdMF6qmNpVcHG9y5mJMxho6zY1CnfUPN4dr3tuA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=icDO56uBrQiyRCXWtgJrclvI0o
 uvPYT6YGM3Qucgj0EZKA3qjEotP8ZqwgANmCIOY9qC7rla+GXxDUJR4Orw0hs8wDY9o7zPN05Ohxi
 JY3ZfiRrotls3xNn/1te/FN8df8utuWCulDyOyWsSLuedlNPI6oJazKSl0gLCBIes8kg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsaIf-0005LZ-Jc for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Feb 2026 05:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tt0nwSjMtedYdzGCQ5zHFVm9um
 IByaGHFymBAHbIPrb/hD+iMF5LrAWveAhyLZJrGwqhP9Cl2YmDypLqY0PPK8zwO/Nxwk/wkYze7gA
 bbnWPrdRUD4vm/WzbcGScN8L5fCYplqEHzTIbhCHhKqZvvuHumsNGfwBH2jE/yA+5lGwL9LciZ/T7
 GdrFLA/IZZSwE4M25uWxoNCiAbL5kBaQZxm7iwwxJyXSiO48RsQs03cuXXyS+NwdYkgumjWJEhPdl
 u84Vl2HMXn9oha7rEqKnp7ekSa/YEbyR2ficy2rzwSST4xclt/R8IfU6q90dGiEvELDmzILHDlSr3
 YrlMXJ6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vsaIV-00000009KRJ-0gbl;
 Wed, 18 Feb 2026 05:40:27 +0000
Date: Tue, 17 Feb 2026 21:40:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <aZVQyzy0R1AM8O-z@infradead.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
 <20260218010630.7407-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218010630.7407-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vsaIf-0005LZ-Jc
Subject: Re: [f2fs-dev] [PATCH v4 1/3] f2fs: remove unnecessary
 ClearPageUptodate in f2fs_verify_cluster()
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
Cc: fsverity@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
