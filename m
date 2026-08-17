Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEC1C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQgFr07YkmqjXLP6D/iSTbZRzyHcugVBvax6USXunzM=; b=cWkqyHK/U9NOiIUt9iLrNhQu/0
	0FtA8y/xvpwj7sZZ/xOvpTMjj7PvkeRNIDJ1EedPXt5Ak5YPEhVAvOi3FxK/pMZ/WSArvnRx2gOJr
	PE2xlHsiiT6s5NpYh0ml+JNMsQpEnpicagktYJBBFmUCJGRKGAuLxGF/3rz96ju3vOdw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvzw7-0000wj-Iy;
	Mon, 17 Aug 2026 16:11:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wvzw5-0000wd-Sq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:11:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0nV0ITWCr+SwB/qQVV59nZ8a7Fv35HT3JcbHcjhrXNo=; b=DqB14coxvDV7Hpw/YOSwPauiKc
 NGnb9LzYcxx31CGksado0jageQ/iCb5QEjSpCa/6qPAt3jKiNHZSmJpnY8U5W7xiRXlXHVYID/StH
 69VkfOCMwUju1FOVEGueqImqa87WXgxsP7P75+EdP47xcNBl9/MdyMfdD0OFtiFnzImw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0nV0ITWCr+SwB/qQVV59nZ8a7Fv35HT3JcbHcjhrXNo=; b=kkx87nnjPoHMMQHbqZJpw0/7Tg
 dAz4YJZf7EmlPjYETHsITGhu3ul/wF7A6Kk42d8V+SjM9psbR5pWWJR10UWJj3kwZrIaL1lsNLp5R
 vzntMYfmWx/YPKavOi16l/ojRP/3Yu/DK6GaBir1EjYMMouoVKR9qK8n87hR1KE8ZMRM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvzw5-0005MR-Cp for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 16:11:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EB8942ACF;
 Mon, 17 Aug 2026 16:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD191F000E9;
 Mon, 17 Aug 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786983092;
 bh=0nV0ITWCr+SwB/qQVV59nZ8a7Fv35HT3JcbHcjhrXNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hnqRopGyXK2yZB1YmPItzCn7//8PjNAn3JpS8iYUtl8uBYIEEHLtqCaKjGW4HTc8r
 /gTRYE+X6V0J90TARmPzfMLSjzzoldSayEaLf4deskBvRiRHBnuDB0OQHXTQ9Wztoh
 LgePo89MCNJF+5TbT2bQadem4bYTgKv6kv7grc8d2X8x/FQ5WHIeAYRgAUEjDNFC4O
 UnSOI0g4qB8M5CscknyTbyD95664Mb8ejFS5wx2gJFrzuQ7bTwePYLe6HmKuGiuG/1
 YT+g9+A/pF4YyV2q+kv4bmJuxIr3pe7mhQAMDP9BXMsFDB38V8sPMc4OuH8WJyZV6E
 8hi//uG+Ehr+w==
Date: Mon, 17 Aug 2026 18:11:26 +0200
To: Christoph Hellwig <hch@lst.de>
Message-ID: <aoMyh4b1qxa0k6eZ@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260817070240.GA17371@lst.de>
 <aoMZaqbKxmp9lhKs@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aoMZaqbKxmp9lhKs@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1wvzw5-0005MR-Cp
Subject: Re: [f2fs-dev] [PATCH v15 00/25] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-17 17:37:13, Andrey Albershteyn wrote:
> On 2026-08-17 09:02:40, Christoph Hellwig wrote:
> > On Fri, Aug 14, 2026 at 11:24:17AM +0200, Andrey Albershteyn wrote:
> > > Hi all,
> > > 
> > > This is next revision of fsverity for XFS.
> > > 
> > > Range-diff with v14 also below.
> > > 
> > > Patches without review:
> > > [PATCH v15 07/25] block: add task-context bio completion
> > > [PATCH v15 08/25] block: don't delay bio task completions
> > > [PATCH v15 16/25] xfs: handle fsverity I/O in write/read path
> > > [PATCH v15 18/25] xfs: make xfs_free_eofblocks() work with fsverity
> > > 
> > > The patchset include some patches from lazy-bounce@hch-misc series for
> > > BIO completion in task context
> > 
> > A different version of that landed in the block tree.  
> 
> oh didn't know that
> 
> > So let's hash
> > out how we want to handle this for the 7.4-rc merge window after the
> > dust for the current merges settles.
> 
> 7.3-rc?
> 
> > I can have the lazy bounce series
> > ready early for the merge window, and should be able to send it out
> > once all depdendency trees hit mainline.  Does that sound good?
> > Or should we split the minimum requirements into a separate
> > branch?
> 
> Then the only patches I will need is IOMAP_IOEND_INTEGRITY with the
> helper. This is probably a bit too small change for separate series,
> but this will also work.

oh and the one which enables task context for read ioends on xfs

> I'm fine with waiting for lazy bounce, as I still will have at least
> one more revision.
> 
> -- 
> - Andrey
> 

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
