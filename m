Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E916DD73EBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yE93E1XpfTVZLzp3ttz8A4kp4zUE+ikh4mXdf2c5sww=; b=BsMxch7ztYPLr8JFl1WivYrhXH
	mXK20l2NTEW4g+Z8/AgJRuIo06AP6jvueM/GPhM6+argMnrxZuc0AYnnHOz9h6jZoe8pPNUa0Lncr
	6BZorg2zv1cXxKh0skaAzehWw0BTF/TxYxajQvGraZabyplcpKFCH2WiYypGoaNwHFJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vlhN6-0000db-0h;
	Fri, 30 Jan 2026 05:48:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vlhN3-0000dS-Cn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 05:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uIZ4FgjPpBtxEJieDWo+YXJaGh8LsG4MzQMVbui02nc=; b=ewTqSsqO6oKsg19OoCdUeEKfyT
 9Xe0YdpZeVJfuKtSp8y1jPt4X11xnamDG+TrZ8v3T6KJmkMgtEEg/dwVUre99bDSgfPndrrzxHNy3
 MGnrNKOanWcLcen+vOb+rliCfl8obGOgl+j2HrfBMH3LiQVt/vdKY5D8AbxxbqfBkup0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uIZ4FgjPpBtxEJieDWo+YXJaGh8LsG4MzQMVbui02nc=; b=eLW+2DdHIAp/DS64wxUnohtzG1
 TBTxaWrJzt+bWOYuKHwHW7Oxpesy2p3Y3ZQcx1fJ9q44j9TJcL6zbuKk5liu1Dv8m4ml3oRGgmTT3
 jmbVTsJESOcDzsOcHXPlwxNHheblLH6qiXvFGMWC+I7UdYJY8LtU/I9FY46dUwf8qubE=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vlhN2-0001iu-94 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jan 2026 05:48:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20A8268AFE; Fri, 30 Jan 2026 06:48:32 +0100 (CET)
Date: Fri, 30 Jan 2026 06:48:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260130054831.GA622@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-8-hch@lst.de> <20260128234814.GC2024@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128234814.GC2024@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vlhN2-0001iu-94
Subject: Re: [f2fs-dev] [PATCH 07/15] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
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
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 28, 2026 at 03:48:14PM -0800, Eric Biggers wrote:
> This patch is still incorrect: when IS_ERR(folio) && folio !=
> ERR_PTR(-ENOENT) it falls through to folio_file_page(), which crashes.
> See https://lore.kernel.org/r/20260126205301.GD30838@quark/ for a
> correct suggestion.

Sorry, I missed that part that only applies to the version after this
patch.  Fixed now.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
