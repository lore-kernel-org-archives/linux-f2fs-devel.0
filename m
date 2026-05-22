Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1FCD5BB5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0P6uE9c0IW3KrWIp5r1a/3A2aHb8cbM24ihDXhuUdA=; b=JiJG7IteVripdHQFnKlqerT/2x
	QKE7IulNlM31D41NtwGMezDFNVG1GjwgyZ35IhNdoLEXuHrdn3Z14Zy+idK3Cc4qaghvkn/bATRGd
	Q5leHXKvaUjaIk8SPDq/Qv/L70acBt2v4IY85YVI3hw12XX148ZtZQeluWBQrVQg0AMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQMjG-000074-7d;
	Fri, 22 May 2026 10:03:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wQMjE-00006y-V2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 10:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EE7jglkWc5b02EajD9Hq94MBW3TL9+QMd/i5HrD5hLk=; b=QPuvcwmAv+/LMp7blD71pc8NQ4
 c4PgKfVixvkCZmUPWac3wcBSiHrQdXH7SfzLBAJVxYqFKBYgtJstfNJt4RsBMrHiMZp43TLacqF0L
 uDVTOXqUup9bigvv8nbFgppJaBJDCY0dwAA7Tv+gBNM6Uua1llixjFkJ4yyO41CGabZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EE7jglkWc5b02EajD9Hq94MBW3TL9+QMd/i5HrD5hLk=; b=Lq1h5yxbWLz4d00C37pCKD6kEj
 XPfqToYWvO36/XmHPmVWjvGDnItunxK74IBWutYwyyIKlrlNesrRIwB1bsmR9/jfI/98FGGqBIkam
 G+MUtYqzfXTR3wsDyelzxzyqY0/48GT+GDuLdN/+UKSJwk6vp8rxFMg2Nd3Hdx+YviAQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQMjA-0001NE-J0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 10:03:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C0EE601F3;
 Fri, 22 May 2026 10:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1E01F000E9;
 Fri, 22 May 2026 10:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779444205;
 bh=EE7jglkWc5b02EajD9Hq94MBW3TL9+QMd/i5HrD5hLk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fXc8/bqE5m2G9NEvKfhSpZy/CbTM6but4CMy/iSqgF60B3nrQyz8f0utXEFOxdil+
 P9+L7Vg7+dL5oU8/pe9hR00UqggP/TKnh7bcf8hQ8CElz45jdgnQOF+MSkRupA7pqw
 hAGDNvrzV1oUbeupPtwVTRgRtRqanW5BnOcvIHbDFddqfJIP3Uelyv+1ZK+4vo9PU2
 aVUAeDPJCBGQmlexODZiwr7nRZVfBGPaTuWdp+0wT2xRA8ggKinrOyEtXZ/Ntdii+l
 r5zKxDnskkUwp2l9kiezcdJjtq6/xnqDFIbp2onQkt0qvdZQy/1IjZ5C9PQDFGaBh/
 1UHtSubvYuffQ==
Date: Fri, 22 May 2026 12:03:20 +0200
To: Carlos Maiolino <cem@kernel.org>
Message-ID: <20260522-unbehagen-baumethode-erlesen-811a4065eeac@brauner>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
 <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
X-Headers-End: 1wQMjA-0001NE-J0
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 Andrey Albershteyn <aalbersh@redhat.com>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 21, 2026 at 01:38:38PM +0200, Carlos Maiolino wrote:
> On Thu, May 21, 2026 at 11:42:13AM +0200, Andrey Albershteyn wrote:
> > On 2026-05-21 11:07:05, Christoph Hellwig wrote:
> > > On Wed, May 20, 2026 at 02:36:58PM +0200, Andrey Albershteyn wrote:
> > > > This series based on v7.1-rc4.
> > > 
> > > How are we going to merge this?  It touches at three subsystem trees
> > > (fsverity, vfs/iomap, xfs) so some coordination will be needed.
> > 
> > As most of the patches are xfs, it's probably make sense to go
> > through xfs tree
> > 
> > Carlos, what do you think?
> 
> I was expecting this to come through xfs tree too if Eric and Christian
> agree.

You may take it through the xfs tree if there are no conflicts with
vfs-7.2.iomap. If there are I want to add the iomap changes into
vfs-7.2.iomap that you can pull in.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
