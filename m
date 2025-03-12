Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51A2C28B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 01:23:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsAoM-0005qN-Jt;
	Wed, 12 Mar 2025 01:23:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tsAoL-0005qG-TV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 01:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2BkME6RAyPE5gIrBr5FD8wgvVVYEVmv74kfkpzdsfm8=; b=EqqDQUbGXrVxZChxHC8J4NKGzW
 m5lNGLZR/TgRGMkZrZavWwYs3Uyne56IISem55E7SHBq6jB3XsGfpNW5RbaoiuUsITSPJvAap+mnY
 9WO6QwWhI1HSIx4IFA4pBsoJW9ZRZRCRc7J7GLXP7GGIC+FwFDTTR2DBPllGEeF1Yuc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2BkME6RAyPE5gIrBr5FD8wgvVVYEVmv74kfkpzdsfm8=; b=C5qRyByJaY7j4TM8o6F4F4eOdy
 C1JSWpObK7zbdqu8/oHfhSwspQ5Kt653NF7RVX6CvR5al09l5hHOsCFPlLPj0poLR8tJKVPBNcQ0h
 6QOIrndtUFN7795fTXDXKGFtxN0gveX7rgrFf90V3Oscfws2VxZAaMbNJfqsLfv9P2Sw=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsAoA-0003jf-LY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 01:23:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EF339A46B5C;
 Wed, 12 Mar 2025 01:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D771C4CEE9;
 Wed, 12 Mar 2025 01:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741742563;
 bh=zmNim0dctvfuEGmbNDy9LxXIRA1vynbumloK6EoX7OI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iSuwI+ueQbilvaQvmASkAI9XTb2Uy8RGLqyyoqUD4PFKsmLVVd5MQbgxUQsZgwLT+
 NGUC4BLxxVBttJ+Ukw3iumO/DXAkiO63/sVi/s6gArWhDVseggV3ShLYP3lhwYT0Mg
 QSZ71aO1G3HXRCSC2RViynSMigPMlWj3+6sxQVYIEkppIpeHA7yeuawPIEMQoTvXYg
 TZ81b2JpzqHwNO079lp7eyrVaBpVBgwuVejL11APq8WQ4QVVjDVZBjOCTHGK2xQNwT
 4ZNu4oCG1ID2QJDmWQjlGbgZKcGHSXiB93rRqCFlpficQeapbldc919L9VvaEl3T33
 TybhysWLI5tFA==
Date: Wed, 12 Mar 2025 01:22:41 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z9Dh4UL7uTm3cQM3@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9DSym8c9h53Xmr8@casper.infradead.org>
X-Headers-End: 1tsAoA-0003jf-LY
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, patchwork-bot+f2fs@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/12, Matthew Wilcox wrote:
> On Tue, Mar 11, 2025 at 07:50:38PM +0000, patchwork-bot+f2fs@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to jaegeuk/f2fs.git (dev)
> > by Jaegeuk Kim <jaegeuk@kernel.org>:
> 
> Thanks!
> 
> FWIW, I have a tree with 75 patches in it on top of this that do more
> folio conversion work.  It's not done yet; maybe another 200 patches to
> go?  I don't think it's worth posting at this point in the cycle, so
> I'll wait until -rc1 to post, by which point it'll probably be much
> larger.

Ok, thanks for the work! Will keep an eye on.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
