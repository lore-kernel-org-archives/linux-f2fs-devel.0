Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AA606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wzer1rHW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UZnTita+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CTfdHJuk;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISY4GPo6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MfvWU1WiXaQkSlEz3Lm67oKuX9JfNNKbmQjLOlZkmwM=; b=Wzer1rHWAI9XDGKz0yJWgef+Wy
	FJBdSDvvXjmeU22HLNucMvLnenF4jt/THyqfiAPBN5w/snuKCgcCnhom0Wx9RGr/gWfytXxIe93UF
	zzcgPWHr7ZK+UFygHhTHa3D8V4dj/6JqwB1LDspAlVpsrhZseHh2OBH/ZsFa1WJemdrs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQuVi-0000000069B-33QJ;
	Tue, 10 Nov 2026 22:40:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xQuVg-00000000694-3XdY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4iouw9kc7osx9xZEFyrpkl1mggM2R9WmYHa9c3AIRng=; b=UZnTita+cuxn1LOxjalOS44P9q
 gcyOfKD9Mv7c5spPi2ZKYgOJbppF7qfSBsnzllrvSgSkxri3DZu4/610XHmF/Amx3YG+PZhpHEJ3t
 jrnbBc7SI6Ja1Uc6oenrJoc4Oby5vwcT2RtVuuwprnIwfgHSYuTQzUCVxp09L2cl2MXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4iouw9kc7osx9xZEFyrpkl1mggM2R9WmYHa9c3AIRng=; b=CTfdHJuk/pSPohaiGKA9Jjvmye
 4BiMTk3Nqx5SyOQyVpvkd1m33w6puEVHc3l5MjAgiHLwU3Vavsxkt8ATGb1YDFJZg4VoGZVFWkSsn
 Py6ilRIo5UYJ4aCbxSiDse9PiVE/xlQa1fw1gR8FGmzmRt0QE1hgWTw7iuRSZc0cn+YE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQuVf-00000000326-22kS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 22:40:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F1FC44891;
 Tue, 10 Nov 2026 22:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A21F008A2;
 Tue, 10 Nov 2026 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794350406;
 bh=4iouw9kc7osx9xZEFyrpkl1mggM2R9WmYHa9c3AIRng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ISY4GPo6d9hu862k51MLskyNBVJS45r1xWEsVdvI7Hzqyhdnfnq4Ug+2eAQ5VD8fH
 FoOsff4V8+y6+wVYuMAOnOkUJ2HQDLCx4AFPBlGjPFt08ncGVXWF6OjD94ZSn15Doo
 yJORIAtTbeMwT1bXXdwsDfvCb7U0sCfHaINhXR0s4uop3Ejdc6sV9RgOZ1ERp0OVOI
 laD1dozcxPkmhOhE/nWRYFVbxxZpNT7N4jyJlwKzedox2VgqRuzStkTRgBm8Trof1U
 jfkkMRFvT6nuq5mMgaMdHqrNT/ZT9ac3vFQDgoomWHkdLttdzGwAkQKsK+vum23YmC
 313Yzqjqix2Fg==
Date: Tue, 10 Nov 2026 14:40:04 -0800
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261110224004.GF1907@quark>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
 <20261110223526.GD1907@quark> <20261110223741.GE1907@quark>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261110223741.GE1907@quark>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQuVf-00000000326-22kS
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, brauner@kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:37:41PM -0800, Eric Biggers wrote:
> On Tue, Nov 10, 2026 at 02:35:26PM -0800, Eric Biggers wrote:
> > On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> > > +	} else if (inode_state_read_once(inode) & I_VERITY_BUILDING) {
> > 
> > fsverity_is_building()?
> > 
> > > +static inline bool fsverity_is_building(const struct inode *inode)
> > > +{
> > > +	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;
> > > +}
> > 
> > It would make more sense for inode_state_read_once() itself to take
> > 'const struct inode *'.  Then the cast wouldn't be needed.
> 
> Also, we should include an IS_ENABLED(CONFIG_FS_VERITY) check here, so
> that it gets compiled away to nothing if CONFIG_FS_VERITY is disabled.

Never mind, it's already there in the !CONFIG_FS_VERITY section of the
file.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
