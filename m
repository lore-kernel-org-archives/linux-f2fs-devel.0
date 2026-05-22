Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A766CD5BB5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=daOmDTnHRwYiemCOEHt1m7xtE9CpsyONUUCEhIX8k80=; b=GANepLHHxaRq6yLLvp6p9MBYIG
	PBDaDOxE1+vJOqIZliIBJSeihRd7lLzPC5f2Du7PiHCvppxKUn+IUSCu6j7wahh4NzZ4wouISL/Jq
	m8kzZjHJiIBJVRrcYDeiZIwNj1Nk6eli16UIETNcgyEMYQvLnkCBdviyecy+l/IWVmlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQOfn-0007FU-Pg;
	Fri, 22 May 2026 12:08:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wQOfn-0007FN-1Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 12:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eNQ/HffRfGqu34qOeK7EX9b4MT170ZPwpkS66bXp2gE=; b=AYTJdoW+d3QYwuCSfSL+Dx+G+Y
 8af0LjGXx5yBV6OnDpqq46mlfd7TvRv+SB4u0mr0FLGIvZ/dPjAS93EGU7ZGR9ntoRou6d09Qn6kf
 fRDCqz/Tna42D6wKgp/FXsnB7md0Y+fPLqkvQUZp9nNntzIJIzgY+kOCIahS8uKeIQSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eNQ/HffRfGqu34qOeK7EX9b4MT170ZPwpkS66bXp2gE=; b=LctjVBDbUgIeOenlUVmVKJNl5g
 Dh8uzUFpifRhtU7DLUOKwTD0icIX/NwWHsx9+pBCh5QrXC5ThrgRAd66xE9kp8DHKTsFNuTE1t2Ki
 a2u/BBLH2zGvyME1WTgC0uKy8GHEOtD0qDz9SxcVkXAjRYBGvx4/8+bEDaJnNm2zJDBw=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQOfj-0001MZ-M3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 12:08:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE61C68CFE; Fri, 22 May 2026 14:07:57 +0200 (CEST)
Date: Fri, 22 May 2026 14:07:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20260522120757.GA21041@lst.de>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
 <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
 <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wQOfj-0001MZ-M3
Subject: Re: [f2fs-dev] [PATCH v10 00/22] fs-verity support for XFS with
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 22, 2026 at 12:03:20PM +0200, Christian Brauner wrote:
> > I was expecting this to come through xfs tree too if Eric and Christian
> > agree.
> 
> You may take it through the xfs tree if there are no conflicts with
> vfs-7.2.iomap. If there are I want to add the iomap changes into
> vfs-7.2.iomap that you can pull in.

Merging the iomap bits through the iomap branch might make sense, given
that iomap usually tends to see quite a bit of activity.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
