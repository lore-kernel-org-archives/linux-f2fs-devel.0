Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084E0C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCdOo+sVfo3o1fm0ip4S+pjvxSkhiCVBQ9KDsdMYn6A=; b=Kauyr5GH83FDAtBOOpBb7F4WZ3
	InaCIejLHuEISVbsIZ/ehMBwZDm6OYobfAxhtrsFe9m0Xqp86Qrs7bk8oFU0N3OVG1VKaKaXL4TPs
	baAI5BXsMEv+OjWL8OukKlxCwPsuKi8jG3B0fGiwFTnmihk3OsRlCgIsHdVAzpvQrZEU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrKJD-00050R-HU;
	Tue, 04 Aug 2026 18:56:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrKJC-00050K-5o
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFk6R/B/BKxw+kr+MboqGD+mfukfGOz2/GgStRKasCc=; b=m0MHHfwuyzWtRZk5VcQrydzV5k
 mU3iqHxbFFrGQgtJy++B+Kv8QSr+q2uT6Ik/h0tmT3d3Oa/iXqeu9dGPl3OrJ81O4yJnM4pyaLAiq
 5LKphr97nF2lfDwAIh6wlDwH90skINlp4gvGYJx5p46gQzdRXWChBTJA3UcTG408ekEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nFk6R/B/BKxw+kr+MboqGD+mfukfGOz2/GgStRKasCc=; b=ahI0v1JK5YeeruVJiORalvBfOg
 OoYRE32YFIbZR0Cephqt9WgCzfePk8l1UPQh4DKupovIH/SLaPnQClXc42tCFA6rVDV7e4eNdAvKP
 dzyu42afZ7NP+uPSz6gNsNZWl+Olbo5SqV+Z6jUwG6c2KAkJ82sWMZ0WWgUbWNlka4UM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrKJB-0001ps-RW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:56:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 83ACC60A78;
 Tue,  4 Aug 2026 18:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1E5241F000E9;
 Tue,  4 Aug 2026 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785869764;
 bh=nFk6R/B/BKxw+kr+MboqGD+mfukfGOz2/GgStRKasCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SHEa/nwq8r2kvOtxBoue7o7cfuRCShIJ4uDViRyPz3GjLxNsyGRBt5ITQ+c1xLxWd
 W8VSDB5WxQuUpV1UASJ4jDc+gspz8sMZTEKtZuDcmIjudDMoLsYKw+ra/WT/ppzS97
 wF9IcCtTdylxCYWTO0q2ZgggUKP935iq0t+TMbHz2ioVcpwJDYBVYRQaP84DDp3nHu
 9JeimgeUsic3VQFPGqSqlrypSpDF4mpXUVCJiiERgHpCT+3Eq060NZSYmzx9qzcSbe
 9cKMHCDsDyftSezqsFvw05wQcY4FsdoOVOvAdGbU9A3mQlWEMVQd4YRKq1kMlMqdyZ
 he3Tp/rp1XbOA==
Date: Tue, 4 Aug 2026 11:56:03 -0700
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20260804185603.GP3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
 <anIzawflI11C0FT2@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anIzawflI11C0FT2@casper.infradead.org>
X-Headers-End: 1wrKJB-0001ps-RW
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 07:46:03PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> > The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> > flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> > systems. Open code folio mapping and flushing to copy all digests at
> > once.
> 
> Have you looked at the implementations of flush_dcache_folio()?  On
> any architecture we actually care about, all it does is set one bit
> in folio->flags noting that the folio will need to be flushed if
> it's going to be accessed by userspace.
> 
> But, um, do we support mapping folios containing fsverity data into
> userspace?  Can't we just delete the calls to flush_dcache_folio()?

I don't think programs are allowed to mmap the fsverity data, right?
I know there's an ioctl that effectively allows read()ing it.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
