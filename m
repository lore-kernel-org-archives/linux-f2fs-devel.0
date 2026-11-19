Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C74606A337
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OIZVRune;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dBegyZip;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FEDgq54Y;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUsuVD2N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Jm5Rbpy7nrwQZEpJ47u2BNi/dYmtHcRRERQlimh4Q0g=; b=OIZVRune3FUbfTjyyN+NpYnvOt
	Li58U3bz+l8NatcZK4X+TOs7GnWc8fjWT1g3d/7vX0i9Ny7EUA8f0oAp3FTUS9ECXu01A9QbCJoMF
	NVkCCsRMVuIFC/CKLTjlf/TIJACTJILP3ZuLZ3GZYjRGZh8rVk2wj/Ag14M8yG7jiHV0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU94w-000000000X4-2TAL;
	Thu, 19 Nov 2026 20:49:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xU94q-000000000Wq-0bwV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6uUyYlgjM4gUdz5mj1dp5lYq0596fRi9TUMCukh9VpQ=; b=dBegyZipqJNZDBrtTySfRfeXHT
 TU0MKuuSB2+pnVZ+k0fTBfLujIHrFSmxeS+GK5qiItzEJ+eUtf7L3R5gaVU5RTg2rxa1u8vLcPZqB
 kmKamhlYPyV8xYW4qFWPdYoaZFctpATsbfdkVX2yEOSAEuapO6CUvfYXxZBmYwsiohuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6uUyYlgjM4gUdz5mj1dp5lYq0596fRi9TUMCukh9VpQ=; b=FEDgq54Y8FFDKAxKTaE3jDRFS4
 0IL/xacf4S6Bz0bqx3kptTDBF96W0Iyv08iqwBi4OyibUBD+q9sxrR6BvWane+PA3DE/v8oc1fSpW
 m6Cgt/qxQk03Wi9HEBaOZGM85sw+EhCT+FoXlDdDFgT8lyULuQo4PL5q4JG/Hkxb/Axk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU94o-000000003jx-387v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:49:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CAEA62290;
 Thu, 19 Nov 2026 20:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C419A1F000C0;
 Thu, 19 Nov 2026 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795121384;
 bh=6uUyYlgjM4gUdz5mj1dp5lYq0596fRi9TUMCukh9VpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XUsuVD2NP90/zfhUq9QbKDAGXZhdmG7O0dpAwPuMLXYuHA+VoVSq3LwTuzGNJ2xoy
 pV7h6GlpNWJZdh+tQ7T8BoZICBsaA2neeIJsyeGJPjHbEd8sWe8qD312t0m4XYkqV/
 LoSlP2csABz4sBDz1ttLmKZMKk3vQnxk3YuS21AsxlarQsWPozwmZMwptG4NWo0QR9
 N1wVktid4Bxzu54Xfs2Jy80X4EjDqQKBN1ZyQpXn7zh7DxjSVlmxETqGvXpTodcoIJ
 /PHgRfyNNNvlC/QJrm8d/c88bX+m/rrMjwyCSXG6XjQiLY63pymmDeSx+CM73mL4Pd
 /Lts2Y92lgbmg==
Date: Thu, 19 Nov 2026 21:49:39 +0100
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261119-geben-irren-erspielen-4456e4be9246@brauner>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-3-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xU94o-000000003jx-387v
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> Every filesystem that supports fs-verity keeps a private runtime inode
> flag meaning Merkle tree is currently being built *_VERITY_IN_PROGRESS.
> They all serve the same two purposes: reject a concurrent enable with
> -EBUSY and let the write paths recognize the special writes done while
> the tree is under construction.
> 
> Hoist this flag into the VFS as a new inode state flag,
> I_VERITY_BUILDING, and manage its lifetime in the generic fs-verity
> enable path. The flag is set after ->begin_enable_verity() succeeds and
> cleared after ->end_enable_verity() returns (both on the success and the
> rollback paths). Add the concurrent-enable guard.
> 
> A new helper, fsverity_is_building(), is provided for filesystems to
> query the flag. No filesystem uses it yet; the per-fs flags are
> converted in following patches.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/enable.c       | 22 +++++++++++++++++++---
>  include/linux/fs.h       |  6 ++++++
>  include/linux/fsverity.h | 21 +++++++++++++++++++++

fs,fsverity:

as prefix, please.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
