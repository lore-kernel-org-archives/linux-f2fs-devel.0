Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0192CCD1A5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEPNxtHojOe5SbweW7mc/g3GoK3yClxw8Dttp9IdPf8=; b=D9YcnAx4P28sPqJVivZ7S5IMcq
	i1VNU9hYjBf/vt/dwtBEqbzWMHYtPag6QLsCtUJo2lqXMwFt6IAmU5OLVHyWm6QIcf2dnKkvUCgKA
	VDPev8iroWYpsxVwEmYKxQRI0S+zbkAYR+F9powq19mjR0gDDMUFxPgiqHly6Qe53UYE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vB6bp-0004oA-1u;
	Tue, 21 Oct 2025 07:16:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1vB6bm-0004o3-Qr
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Oct 2025 07:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IuZy3bORYmWM3ATciEuz7ss8Rod/eltFRSKz+TLyRDk=; b=B1/4CFJBKQkgfptPju+EiQENYL
 kGkvN5kI7b1r92BSCdoQTxIFPhYm5GXdL4RyF13EORjw544ugmY9uRp9sp4XWVZjQPrtV9jrESlKH
 nSyw7Lw8FHNGXunOfX3/LkPNSZAnu9DSrelemxbjjrNb3IptykJC/m4L/KVCoF6a9mtk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IuZy3bORYmWM3ATciEuz7ss8Rod/eltFRSKz+TLyRDk=; b=lgVSHpRRaHek6Xd59oxGXg7Pd3
 wghPrAxCWuL89yXaDDibHqfk68iUMcJD+O/e9/fGzj8v3iOalLhtEhOvfmrtXVWViNkMiQaCY657O
 Z5riUFpjgMk2ipOUOQCo3AE8qZ1mJZM2kBdReQiv+Bfqbd62Wg1tvJd/84MHBsga4WGc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vB6bm-00075Y-Eq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Oct 2025 07:16:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A5C745275;
 Tue, 21 Oct 2025 07:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0037C4CEF1;
 Tue, 21 Oct 2025 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1761030987;
 bh=IuZy3bORYmWM3ATciEuz7ss8Rod/eltFRSKz+TLyRDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DB6GdZnbFbPZH7ONQh9UuBnxV4yyVPct2UBrbOx+acy6LJD3IJJ4TqeBWOFuTnxob
 yQcTMlx/xjhair43mI2kcAlGLlKR8ps3Y7a+miuwU084wFYaZ7cl83CGA5idAHpn4z
 C7ARslXbVSJo2wbFcP/tFMYJ6I8A0Sh0OKg8AlhA=
Date: Tue, 21 Oct 2025 09:16:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.de>
Message-ID: <2025102128-agent-handheld-30a6@gregkh>
References: <20251021070353.96705-2-mngyadam@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
X-Headers-End: 1vB6bm-00075Y-Eq
Subject: Re: [f2fs-dev] [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, nagy@khwaternagy.com,
 linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-nilfs@vger.kernel.org, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Oct 21, 2025 at 09:03:35AM +0200, Mahmoud Adam wrote:
> This series aims to fix the CVE-2025-38073 for 6.1 LTS.

That's not going to work until there is a fix in the 6.6.y tree first.
You all know this quite well :(

Please work on that tree first, and then move to older ones.

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
