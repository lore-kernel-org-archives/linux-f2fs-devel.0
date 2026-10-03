Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0C2CA5FC1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Oct 2026 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HL8/vh+6bumVxblNoDSn8g8HrldVe8rvqGKeJ+16EJo=; b=Gi5nhMBqlALkA7LEHT2OiHF2dI
	Bwxj5Zbc2PGaMQn9G2wronfm0AaPc/4j00PZJVrM+c2BTW7Wy1j3Xkc8qaJv6hR7TwK8oyj920iUk
	rOIx/Y+aqm+7U0s57nb7khMzk9rSX4Fz1EJAciAV/Ku9mifsaXLeiNbawmXbpTCHzsTg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCyWg-0006mf-DF;
	Sat, 03 Oct 2026 12:07:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cem@kernel.org>) id 1xCyWf-0006mZ-TQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 12:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EnFaP/Rj6/FO7QhoFI4cAaoDyUrDm9rWa6WobuyTgnM=; b=gwDWRH7uuiwPY42CeNo5PCY+Aj
 1f6uunLB650VnCNyNqsuJBjuQx74eEowO9/FSMG3AWZQv1k+8epJRsS9xk77OELQ1Te+k4qsA9YcR
 g+dc1O9Dqz+YpNJh7MUOCj5VUJ5KN7Cn/IiGsbCO+gp7eQ/zcUWzOTQyxFIVF7L8Q3qQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EnFaP/Rj6/FO7QhoFI4cAaoDyUrDm9rWa6WobuyTgnM=; b=ULU0DbiHtoD1PERu3JwtfSC7QS
 wTOStEuFQky2zEy87n3cChh0+geArmSb6AgvHABLdZ/8y1071ypLZRtB+PhZzEq0maMZNGvWqBuXy
 ra5hbzWjc0+4FwU4wmv898rZpLmTrwO0e5MsRw9hJuX9DrN+SvRWrDuuRx5dg85ILwHk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCyWd-0005MV-1C for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 12:07:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64FDC60515;
 Sat,  3 Oct 2026 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192971F0089B;
 Sat,  3 Oct 2026 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791029248;
 bh=EnFaP/Rj6/FO7QhoFI4cAaoDyUrDm9rWa6WobuyTgnM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FsG07AbR32O0eAWDEJ+kolPUINuSS/W/hWYnOEbW1yICoXQ1mL1BHF8uqyqyVKdxW
 KzHbZi2UebWAh1TPFfuJt8mSJgMLVSskFAdLZrPqirZcCyl9mbXYY47NUR8sSMQGP5
 f7WGG3f6w0hOd58m40O2deJNgZbk2T50TUHVkWGe564svrY5ivna56btCVpuTSZX6B
 L35uvOGCIWDkwwDvvL9SnQ/v6hdjYe+r7OH8X1Cghzwj/PFbvDdL/cVCBaTGsrtusi
 fZSS3iS5wsIzw38RbH+aYuJukEae6cUna3S1uZiutQIK7Hatu+HPZfuz9KfRxwwqLl
 W/epvyyGy3k7w==
Date: Sat, 3 Oct 2026 14:07:23 +0200
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <asDvqctUgrxflcCa@nidhogg.toxiclabs.cc>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002232542.GA15366@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002232542.GA15366@quark>
X-Headers-End: 1xCyWd-0005MV-1C
Subject: Re: [f2fs-dev] [PATCH v17 00/21] fs-verity support for XFS with
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 02, 2026 at 04:25:42PM -0700, Eric Biggers wrote:
> On Sat, Oct 03, 2026 at 12:36:41AM +0200, Andrey Albershteyn wrote:
> > Andrey Albershteyn (19):
> >   fsverity: report validation errors through fserror to fsnotify
> >   fsverity: expose ensure_fsverity_info()
> >   fsverity: pass digest size and hash of the all-zeroes block to ->write
> >   fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
> >   fsverity: don't allow setting DAX file attribute on fsverity files
> >   fsverity: hoist statx reporting of fs-verity flag
> 
> Would it be helpful if I applied these six patches to fsverity/for-next
> for 7.4, or do you want to wait for the full series to go in at once
> (presumably through the XFS tree)?
> 
> - Eric
> 

It's your call, I *think*, this is too late for xfs 7.4, so I want to
queue it as soon as possible for 7.5.

If you want to take the fsverity patches into 7.4, go for it, then the
xfs ones I'll pull in once yours are merged.

Sounds reasonable?

Carlos


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
