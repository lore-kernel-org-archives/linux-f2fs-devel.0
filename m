Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B32CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5utzbNgJUqhbovmaswsebED5OCIejuoJ2dbHpCZR/zQ=; b=gK4msfsaBT/NRJk2Jf/SndV2rT
	Bs7Hc/RAma7SZl11pnqzO0UYu2S4RFIWQdkAjWkgbpbfybnrpLrS+1hBfIrenZW29jBdhhzcgpfh+
	igVo8T6exscxaQW1cjDaytw9EmVNp5vVNRFFUSMX9RG7iQf9ytS40YqUaCprX99WVeDM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhQO-0005KR-6T;
	Tue, 12 May 2026 07:21:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wMhQL-0005Jm-3X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pMTiTFWiENQamzxHXmbPJRlT0qzqpOu+k05ZoAu8TSw=; b=R/c1vnYRbWYJcPBcD6b40afskb
 8r6/yw6WeacZDMnVcmpR4ujbMBubIxnBL7x6tmMyeMUl98Z8G1x+ako1XQua3qWNvyBOGpknmdPod
 xl5uuKJdHfy/PglMpQGb0dVZN43orqmG+OFvqX8KK6tJ3iTXdAQtQNqWq+jCqmydU7aA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pMTiTFWiENQamzxHXmbPJRlT0qzqpOu+k05ZoAu8TSw=; b=k/XFcbqIP39y+gjMh7afDGmQPj
 dXg3H1qpWIhGGaIbZcTtdjBWg6CwZSVKDCF1DoNeYQgEK0XUNNLIj8dbteC9Okqm7jl7BjrUX/6FA
 +pZRG7GvuYH6EdCXtQwM8GHAVTS7zsVmmgflXE3RNoziDQDZkNk2GH7N5sGDLFRl7zIg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhPv-0001dA-Qf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:20:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EB1E668B05; Tue, 12 May 2026 09:20:22 +0200 (CEST)
Date: Tue, 12 May 2026 09:20:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Message-ID: <20260512072022.GA32622@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-2-hch@lst.de>
 <03dddf72-8755-4ebf-ba79-456377f0f25d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03dddf72-8755-4ebf-ba79-456377f0f25d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wMhPv-0001dA-Qf
Subject: Re: [f2fs-dev] [PATCH 01/12] swap: remove the maxpages variable in
 sys_swapon
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-cifs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, linux-btrfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 04:08:35PM +0900, Damien Le Moal wrote:
> On 5/12/26 14:35, Christoph Hellwig wrote:
> > Always use si->max which is updated setup_swap_extents instead of copying
> > into and out of maxpages.
> 
> Checking mm/swapfile.c, I see s->max being set only in swapon(). Is this a typo
> or am I misunderstanding this sentence ?

It is updated by the file system methods or the generic implementation
called by setup_swap_extents currently.  So the above is a bit imprecise.

The next patch then removes this confusing update.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
