Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D1E109C035
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aW/tBRVW3Cct8Pdkw7oxeB7meRVbsWNw4ae53VReF2U=; b=ZE3EhcXV9IjAcYKa3F1/lRJB92
	sTUNGyL0QoTsfJmQieIXHUi+8cquqev8WOsANkPvCw3uINUMHzPugzBY7CieGWUIC+/6T+m76pTax
	gH6XNTh/vktlIssd1otTnU1TlcyUrI3R+2FMyCMPAnsKEkcfxs/DouH2pNRFX8Vdl5VI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Qgm-0003hz-Hv;
	Wed, 25 Mar 2026 16:02:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w5Qgl-0003hl-5r
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dDzkXf7UHrCfT2cHafkqgA7zukocE/8dExusRMzytQI=; b=Fhum1YaJAL7vI33TmXrj/dK0me
 FBTthV9TtY9Oa+LINol1s+7f14zoE7Oy1KqMR2FytlSlFMiy8QxXKn6Bno/kjWLYB1FXTOMMzJ0pZ
 wcs9YBgIuQAs6tF8QeQgzURx5ppU0w0pGpVyjEpmlqm2WrUiQctkz1ZN2z/qxLwfWr+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dDzkXf7UHrCfT2cHafkqgA7zukocE/8dExusRMzytQI=; b=KZu7JwzLv2Wtop0LLWJV0n08w8
 4dPBGFXkPtKC64upmWxlQnzkSxAF5vAnLmJzRysPd5sBFfTy+OWvC+9K47Z3q3/hbAmG/e7mu+tS4
 m48OUW+LxJnL5/59H4orNK2kk39Ha6oVyk+IhkDM0iVWx0n+tNGg44BKCWtpfkaDcAI4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Qgl-0004Ds-CM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:02:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EA37D43418;
 Wed, 25 Mar 2026 16:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ACCC2BCB3;
 Wed, 25 Mar 2026 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774454544;
 bh=vJ5xGASjMp/TlxhmM7CCfj7w6GupzT6n+xYGWNCGtRs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B+2FchYbbkhWOofwvjIv9Q9SCnlXi2yRnZCJyFCjE/4lIXvKo7/3kCKeDOLwQg/34
 ZiDtgzoi/papPZGLWU9JlD52PxCDTJ980jG5ZuhDQGf/bgZzvD5effQuMJ6p16xp/F
 VBK9/3dNU7Vc1H6G6Fg5kZq9BP22TEMnWs/dKZiaQTlPnPT1yT7hcAB5v1MXGP0q4j
 SXTJ1/xW7qVVP9awRDMj5dxDxCTO34dPiQfePoIKCM9W280FQ7CfsnbJDhMI0ONFZ+
 za9Vojisydqn+4vOQVw8wIxrFjFDVNSpFv4rltLNOSvB8dTcoLnW0gxg6J2rBsbpe+
 KlR96DzdoON3g==
Date: Wed, 25 Mar 2026 09:02:24 -0700
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260325160224.GT6223@frogsfrogsfrogs>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-2-aalbersh@kernel.org>
 <20260325075402.GA952@lst.de>
 <3lllvimldwcgi7crh3kgwy3a5z2ng2ugcka52ab47o5mwx4dnu@xyzbelhykn7n>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3lllvimldwcgi7crh3kgwy3a5z2ng2ugcka52ab47o5mwx4dnu@xyzbelhykn7n>
X-Headers-End: 1w5Qgl-0004Ds-CM
Subject: Re: [f2fs-dev] [PATCH v5 01/25] fsverity: report validation errors
 through fserror to fsnotify
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
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 25, 2026 at 12:41:23PM +0100, Andrey Albershteyn wrote:
> On 2026-03-25 08:54:02, Christoph Hellwig wrote:
> > On Thu, Mar 19, 2026 at 06:01:48PM +0100, Andrey Albershteyn wrote:
> > > Reported verification errors to fsnotify through recently added fserror
> > > interface.
> > 
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> Thanks!
> 
> > 
> > Btw, would it make sense to enhance the interface to tell why the
> > data vs considered lost?  i.e. checksum failure vs
> 
> > (part of) device disappeared?
> 
> isn't it something filesystem should report even before fsverity
> gets the page?

Since the verification code is mostly called from read(ahead)
completion, doesn't a merkle tree verification failure result in the
folio remaining !uptodate?  And all that gets compressed to EIO...

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
