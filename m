Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E766CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+u8ejSMsTBYehhA0NfXB0k6zwz29Xak5Yy1nvO5plQ=; b=WUxLQfoeTt5pCQ6J037gmyo9X1
	EFQCf3I5pqNuNM4AuIMJjfkoNGTxDlCii7+Q/GbkjBsiHpUYA8PwdKsDIwhpKVucyBPhLSAGO0AoP
	D6dfm9xwx6TjQrWgrhxq0PEBsk+0HLJso7aH0Qe6ZiZGRtKM7Tl8JC5SjhOO6ImjehDc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wN2aB-0004Tj-Oy;
	Wed, 13 May 2026 05:56:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wN2aA-0004Tb-PM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 05:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5TCj2cJ/ZZjo4hdIuBCz/5ReUhnh72x/ISsIQifvmo=; b=VgxSGK//VPPY8+KDhBnRxaNr4k
 Yow8M3gaOVNUDARybZGKhMVxjX4hZsTOLUDYH3bUCHZCEOSdsB5LIEmNX8ZOH340bl3cKcrt+Wmxx
 sMN6yGlEb8sHEDO+/KhBHtjfyDpe7cf6ut9MOVK6baFgf4hX9aW1oixrArbaZa8meQkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v5TCj2cJ/ZZjo4hdIuBCz/5ReUhnh72x/ISsIQifvmo=; b=HajIh7bPnzNgZJuposLOXd3Tk0
 b6M3AalutTOEfuiLkNrWyGhlzfqtuP3RnR4d0ha8Us4FkziA3kF6EA6wtPzl/qNy7fNHS5eHOr4aO
 IK2hfR9x8vIl1L6eMypWqw7aYZJl7iwYJRL9MQ4wqfzYQf+T78WcObrk8iSpS835zVTQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN2a6-0005Ed-Ab for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 05:56:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 693FC68BEB; Wed, 13 May 2026 07:56:22 +0200 (CEST)
Date: Wed, 13 May 2026 07:56:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260513055622.GA1236@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-6-hch@lst.de> <20260512164308.GF9555@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512164308.GF9555@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wN2a6-0005Ed-Ab
Subject: Re: [f2fs-dev] [PATCH 05/12] swap: cleanup setup_swap_extents
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
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 Chris Li <chrisl@kernel.org>, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
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

On Tue, May 12, 2026 at 09:43:08AM -0700, Darrick J. Wong wrote:
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 651c1b59ff9f..1b7fc03612f4 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
> >  {
> >  	struct address_space *mapping = swap_file->f_mapping;
> >  	struct inode *inode = mapping->host;
> > -	int ret;
> > +	int ret, error = 0;
> 
> /me wonders why not reuse ret instead of declaring a new variable?

Because when I wrote this, the setup methods could still return a
positive number of extents value that must not be clobbered.  Since
then I added patches before this that removed that, so we can use
the same ret variable.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
