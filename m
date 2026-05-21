Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF9CD4F5E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyXuyf65Vols4z2iq18c7NhwaBycSRIEI327qVjHYbA=; b=LSI5Id94cjS/FNu8o3HDFOO3Ql
	gbRhgNGEjBNw+e8kxndtVUuLNRcj7NFh888BWHdttcQuKeO6cwymI9K2AXgzY/6NVRFxdN7FsS444
	JRiA+Jy3Fsjpea3KcOymvA49Xj7HSu51ZP+Gi1+98PE8xUTNqAJrj2GwVH9und6Bwtpw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQ1js-0007NO-6P;
	Thu, 21 May 2026 11:38:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cem@kernel.org>) id 1wQ1jr-0007NI-5M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 11:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTwZ36g4KGNrjmP2zhYmYAfW/FKKRnhts60EBcPJrhA=; b=Rx+WsUlkQm4EJUMr++nPvoog3f
 IyK+XHiv85m80OVfKuhFnSLf26KSSR5MUAWyOAao0ngZmSkJGNWv7Uq6oIVqmkicli3rR31MOBG/j
 yO7VAba2Uvcgz3LuaV4JHYPcuOi2g/DAmpdo2SB8DWS3meT38p9hS7GI67f3ItU14dr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rTwZ36g4KGNrjmP2zhYmYAfW/FKKRnhts60EBcPJrhA=; b=N9UkaMPUwH8WYzHcHup9tXPHxK
 D5BdkwVyO166OiXWFT9BUPa6sAeJtvledECdS+XVSLxvjeeoONHXS1CSLjFlxRvHRlhpw7ywGUWUt
 WOQd98JuLt8w+wuWS4Z/M14rW1He2gp2UAO27k3rwl7k6hp/rsYEG60Et2VGVYCngbV4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQ1jm-0004ES-EW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 11:38:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43D94601F3;
 Thu, 21 May 2026 11:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41BA1F000E9;
 Thu, 21 May 2026 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779363525;
 bh=rTwZ36g4KGNrjmP2zhYmYAfW/FKKRnhts60EBcPJrhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DBV8PG4VrYTDqdN9t/cCQWnjSSYEiRIyWE6hcxudD8ZlgGK+7cSwHRHQLbCS9ZvNX
 249JW+NoKSWCXJ5+lO7HxMUDojyhtM8K+Ed5gC9qS4Y82fH/JwrYkDHfy9v04Yh23K
 3Q9M9ZnQHSiVs3u/g6gQ/EmahcO92BEQWC/BpNj7m7GPdu8V2Iz6s7eyZetIm06DdU
 AEPie4YNg7zKA0tizxBtdO3xTjCyt1ZPqapck9FBsTvnbgIs6jSyxArjshxxmOjkVr
 3Y3BIbRQxuFR0Vb7Yi2i/vYJCOjJFWEDFhWiZk8VHhE5smjMDKxishmH5E1PAQ6sIE
 QyjsJwtDSAIeQ==
Date: Thu, 21 May 2026 13:38:38 +0200
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <ag7uW7KQ5mVyCGEv@nidhogg.toxiclabs.cc>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260521090705.GA14254@lst.de>
 <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <gcw7zcg6p4s2egpufwizfig72g6ren7jfmuz5mqskkpb7xepww@e3v35j7bk7dc>
X-Headers-End: 1wQ1jm-0004ES-EW
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
From: Carlos Maiolino via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Carlos Maiolino <cem@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, brauner@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 21, 2026 at 11:42:13AM +0200, Andrey Albershteyn wrote:
> On 2026-05-21 11:07:05, Christoph Hellwig wrote:
> > On Wed, May 20, 2026 at 02:36:58PM +0200, Andrey Albershteyn wrote:
> > > This series based on v7.1-rc4.
> > 
> > How are we going to merge this?  It touches at three subsystem trees
> > (fsverity, vfs/iomap, xfs) so some coordination will be needed.
> 
> As most of the patches are xfs, it's probably make sense to go
> through xfs tree
> 
> Carlos, what do you think?

I was expecting this to come through xfs tree too if Eric and Christian
agree.
FWIW I'm adding Christian to the Cc

> 
> -- 
> - Andrey
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
