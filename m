Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DDC77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 21 May 2023 23:56:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0suv-0007TJ-Ec;
	Sun, 21 May 2023 23:56:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q0sus-0007TC-Ig
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hKSB8EoIIZdNDO3pwDZPENWgOr8qAdmee/t6mnJ6cuE=; b=Fl9mwinzOo4FOl7ERimIdKtHvV
 Dn2zABUivHwmc1Tc4+bUzOTTVAr+vKuchivdvY2fnG1PvHLVYmrWFD3ipx89J0okLGFDng8FxPtnz
 Alpt+a4LBb5Enn6OeK+o7l6dtJIAbM8PI4LhzQKkcURcXiOifvZTCyqOPn0jJGRNNa7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hKSB8EoIIZdNDO3pwDZPENWgOr8qAdmee/t6mnJ6cuE=; b=U3t5qd1jOYSowT+PgxQHiq3xjC
 MWFMlVlHsct9x9qXP62IdTaFUjAqpG14rZ0X6VgK1f5Y9G+cOiaq4RXFKvTgicQDB9puWtnT5zaur
 +vdGCvUU7tzLYi+MYIsFc430sLNYLMw3FcwvkMBPiR0wgNploKMSOgmyQq5KACE0caio=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0sup-0004lM-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 21 May 2023 23:56:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9796561866;
 Sun, 21 May 2023 23:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D9C433D2;
 Sun, 21 May 2023 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684713398;
 bh=WK+H08Abjgxys0xDqd/U8tYXnOZJ3X8F5W55cIj1HCw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z0UIsZmHFp90UQn/0ZDZSobLdQtjW4rPu1tqdDMNYQsGw8zH8/kGrQZAEyUH335qN
 jx+PcuHH194DZCYw13SBnxFHv8qR/dJGf6af0XZolQ4pY4NwGz561+BSCiSdq+NMfp
 pP9GaP2rqUcoup1eDTQaC0u9ku+LtvdS5oXq+YIcnSZNrqaJQPgnGcdSglE7zJQQJ1
 mDglCPYJILcH8STc9acJkDdPcqcszqdqt1XtSzFpR3uZ4Vt/dLyxoG0U8QpJUgK6tJ
 zPiZ0smPzXHGDHdVfPjHk4iQopmGL94L8nywJnqwdSEEkEN2OyqqJI94LwhMmFDAGq
 dnU/Dyd7Whn7A==
Message-ID: <5703f49d-177a-a810-6f1c-b32aa1abcde7@kernel.org>
Date: Mon, 22 May 2023 08:56:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-7-hch@lst.de>
X-Headers-End: 1q0sup-0004lM-W4
Subject: Re: [f2fs-dev] [PATCH 06/13] filemap: add a
 kiocb_invalidate_post_write helper
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/19/23 18:35, Christoph Hellwig wrote:
> Add a helper to invalidate page cache after a dio write.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nit: kiocb_invalidate_post_dio_write() may be a better name to be explicit about
the fact that this is for DIOs only ?

Otherwise looks ok to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
