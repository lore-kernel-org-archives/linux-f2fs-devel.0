Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D09CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQniPkUTLdYDRRgkDPplRjPI9OnhggrDdiYQtOPkojs=; b=PAT9M4LdydBu3ESonsugQHV8Rf
	09kDsOK8kUdeAjrhqV4GD6lRndVjYlREfPaUZ9a4BpGeJ3vzEQitSze3jKrUcrDBP3W+vrUnPPhJ5
	JUGb6f6i2c5GmuixNl3nvkWvE7SfSJTm3Hpyq2bDv7rRiGrXbcfJizb1DzUp7q4zIXFI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNqn6-0007PV-3Z;
	Fri, 15 May 2026 11:33:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wNqn4-0007PN-Om
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 11:33:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qP4J/3MbqmVPdYK3GrljdHPsbVgj4MVvh5Ql1yHR2O8=; b=hh2d+aBuUr3sxEZcX5VSgMdJ73
 IPRaYOla9LKz/iKge1ggLjhB1UzsTpE5W8/CRUtW2dSzKbl9b+iiBTay3PpcV6+aZ4Fc7ALbohB7/
 z7UWpWNaKs4KIgZLoFprhKL1l7sRbDDqSoNJfN+nEDb5EVbDJxSkZNHld7OXPkmveoHw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qP4J/3MbqmVPdYK3GrljdHPsbVgj4MVvh5Ql1yHR2O8=; b=LEortAgO77ABxOwPmaJQE7Wuj/
 kQRG+HIjw4btvnh0aAF996/RkvnNaIb3i4BZP8Q4TfIs/jSD3Ozvy7vfVnSYpyGkDcboSmq+PN20l
 kASz2Uwo8F7ZOsCuJmfxCRN9qNwKBdVfM6zMUCAUN+FLHEhfdwOSfcltl1WxWLjC1CRU=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNqn3-000394-A8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 11:33:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1E85C68B05; Fri, 15 May 2026 13:33:05 +0200 (CEST)
Date: Fri, 15 May 2026 13:33:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steve French <smfrench@gmail.com>
Message-ID: <20260515113304.GA24980@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
 <CAH2r5msnYVb3hhXHwqDVHGGC1h4E6mLCRS4ktCrQoD9zdUW81g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH2r5msnYVb3hhXHwqDVHGGC1h4E6mLCRS4ktCrQoD9zdUW81g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wNqn3-000394-A8
Subject: Re: [f2fs-dev] improve the swap_activate interface
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
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 13, 2026 at 03:34:03PM -0500, Steve French wrote:
> I just tried this on 7.1-rc3 with the swap patches (full kernel build,
> on Ubuntu 25,10) and boot failed with out of memory which I had never
> seen before.  Any idea how to workaround this with the swap patch
> series, or is there a fix for this in the swap series already?

Is that a failure with the patches or also with the baseline?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
