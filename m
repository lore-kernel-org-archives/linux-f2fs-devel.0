Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2243C5AC82
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/u2FKuzTQi9ae0tX5APR6cBh8++Rtg9CKx+Xv5PghE=; b=NzDbbXATPkfu93hh0HmTyriTIa
	dsAjwGbTHTpS51waprn214HceevSrYb6ykkY1fp8hWN9ks0c/uSAkIZE3JX9ENbYdVW7IqanGxEUb
	gyiZ4Qxck+q18U7vQAq0PAJjGfm4hNXbClvBbPQDV8UV5hsxB026DaCMSLDF9hHMiSXo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtLNa-0003OB-Kb;
	Mon, 10 Aug 2026 08:29:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wtLN4-00039e-JP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 08:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ooJ1K9gJPbRSmciql3NBWA3FYXEMtRNBkMvQDxZ9OM=; b=FMdFOciV+XFn3zx4F4DlZyIKlf
 cO10OaRq0Ecq5xYbJhN7RcJXt3+WfsMfIebvRfv0GBO+JOIKKQnjpMdIeyQ2kIcSEL4E0yEUOW94d
 s87WJ+s6uHUhKzzZffxSOrXXQqqBaHvpe8J8Pngooxwl0BvURkzIh1+B2+H21k93NU88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8ooJ1K9gJPbRSmciql3NBWA3FYXEMtRNBkMvQDxZ9OM=; b=BPYFG3jrR5vydaWcOhDEJrMemS
 vhf2J1NhGObb2t4fIpFXez6spO7EusIcXOo464MrV/jUy1emK+OIPTO89UxRHnLe3ugkWMJmjg/9R
 z45s6daryc+lIMdlVzLr21FQT6Shr7WvwyVB91G1/4RDOku5606kR6vQJeI5qpfPSh+E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtLN1-0008Bd-SW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 08:28:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5E0D600B1;
 Mon, 10 Aug 2026 08:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1461F000E9;
 Mon, 10 Aug 2026 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786350502;
 bh=8ooJ1K9gJPbRSmciql3NBWA3FYXEMtRNBkMvQDxZ9OM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OHSjCgb0zyYYJnpVXHkENn+EQu/H697chYZZJkFhESi6/NP7iVQcFRaPRbj2caJgl
 xocFGq5ItG0BNFugzGkJIih4QVQSt7Efs/VOhLmVcuJR+9fbHTMYyG63BqdHzg7wer
 eYwX0A7sLiPpI3xJIkx6lk3HPbFW2Y1JpD6FFecaYLISsqFnMQ+Pb2l/c6MapY/Oea
 kCnWp6UIWyn4IbDssy5z3mc9UXSKmUjC5Ar+Eyl5doYemGydfLVLqu6eqO0EY4G+vN
 al6C0EkcLaKaMi8tV7xa0eWlgFSffXjgc3g0LHInhLZgf5gFVRaiOzhazHcgOfdEqP
 ZYFQN2F9gv/UA==
Date: Mon, 10 Aug 2026 10:28:17 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <anmFWhPNOqe4uyht@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260804173548.GA13900@lst.de>
 <20260804175203.GI3556460@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804175203.GI3556460@frogsfrogsfrogs>
X-Headers-End: 1wtLN1-0008Bd-SW
Subject: Re: [f2fs-dev] [PATCH v14 00/21] fs-verity support for XFS with
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-04 10:52:03, Darrick J. Wong wrote:
> On Tue, Aug 04, 2026 at 07:35:48PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 03, 2026 at 10:07:50PM +0200, Andrey Albershteyn wrote:
> > > This series based on v7.2-rc4 + lazy-bounce@hch-misc
> > 
> > Oh, I gave up my hopes to get this into 7.3 and was waiting for
> > your series to land first.  Right now there is one outstanding issue
> > I know of with the series, which is that we need to clear REQ_POLL
> > for bounce buffer I/O, and of course the somewhat complex cross-tree
> > depenencies.
> > 
> > I can try to get it rposted, although this week I'm travelling for
> > two conferences, which doesn't help.
> > 
> > If you only need a few patches from that series and they are kinda
> > localized to xfs, maybe you should just cherry pick those from
> > my series and include them?

I'm basically interested in the BIO in task context patches + read
ioend use of this

> 
> I hadn't noticed that this patchset had added even more patches and were
> waiting for review, but cem told me this morning that he thinks it's too
> late to put this into for-next for 7.3. :(

Yeah, it's probably a bit late.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
