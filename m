Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43124C88E43
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 04:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLMS37XXQj0OSa28pwJTHHbIiJxAXnm6sAwzXR+L6eE=; b=ITpPYO4rNGdPrMP8N2UyWEwHI9
	HEuDImflrjz91iBgiTqJKrcFmCYYmXfzdX6f/bG78PmqgryaoxG3jfXnqFaCw7d9xLqibquraDhqv
	nDxoacC69MklnKoL7GDbOpbWQ3LxpeWXVrG27c9VNThCgArZKuwoyUOYRfllIrs8Knwc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkECO-00034q-UI;
	Mon, 26 Jan 2026 04:27:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkECO-00034k-1v
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWlyzFqE18EzA8mAvXHjCDsfbW8g+t78vYKC77yrgi8=; b=mgugZ4BTWlbzppfx1OmX6nc7xc
 HqZSYxiJWn1jwmLkKaXbmbiuZTT5pL/yJszokp4kwRwWNcKHaaExy5MNEMNcs10pLbGItr69wKhu/
 2qqPEZ+ckrbTp9RA/2qzODfNeu9cGYRWwCMwqEFKQmXlH1+qIKwYFEbv/z7vQM9f1YQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KWlyzFqE18EzA8mAvXHjCDsfbW8g+t78vYKC77yrgi8=; b=h5kw7YCO+yEY3SGUQm9GAkyk/F
 af0qnDAzeDJo8sGnchPltWp1334DYb+vD2Rm3CFEdSkUJVSGT1acNj7XBUoKPaVovFirAJq3ECOMu
 599BhozZPzxS+lxMdj6aAncbzZSjMtS0zAJk5f/bVMDiNB01jeYDhBO0MbQtKtJx/n6c=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkECO-0000lw-7f for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 04:27:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57D11227A88; Mon, 26 Jan 2026 05:27:27 +0100 (CET)
Date: Mon, 26 Jan 2026 05:27:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260126042726.GA30803@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de> <20260124192747.GD2762@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260124192747.GD2762@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkECO-0000lw-7f
Subject: Re: [f2fs-dev] [PATCH 04/11] fsverity: start consolidating
 pagecache code
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jan 24, 2026 at 11:27:47AM -0800, Eric Biggers wrote:
> On Thu, Jan 22, 2026 at 09:22:00AM +0100, Christoph Hellwig wrote:
> >  fs/ext4/verity.c         | 17 +----------------
> >  fs/f2fs/verity.c         | 17 +----------------
> >  fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/fsverity.h |  3 +++
> >  4 files changed, 43 insertions(+), 32 deletions(-)
> 
> This creates a bisection hazard: the new file fs/verity/pagecache.c
> isn't added to fs/verity/Makefile until the next commit.

Fixed, that was of course not intentional :)

Still surprised the build bot didn't complain about it.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
