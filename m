Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35222C55160
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nsl1qeXSKeRZljjnAxn8QMwdxDTepLksldE+/EeKh40=; b=iwJMrqcTgRtiaXeEVrwN6PdHPw
	560YxUiLeijGpIc7xtTTuk0/RqcCKEUIQUw/BurXzqx6sNXwPMklX6PWmwrqtQAIgo1bDfLerg68m
	I7hU+zm6DTFVz8HBDljWv3nQgoC2Ski5qbAGDSp4hdZu48AEq7xj4afzMhs2ZfSSnT/E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpNvg-0003nm-Fy;
	Thu, 30 Jul 2026 10:23:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wpNve-0003nc-I6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GsbS4Sw15ffaz8qVeqdZl5yarhOra7Ro1zRToupS0NU=; b=LRZQWRTuIg/b6FxQBzk6zKL0WS
 MtNv9wOKjxl57UpZ2HoZOx3fi4ibBg8ElPjl35onylJj3LyxrBBvcrskazQiEy6eCz0TS0hYFPIGR
 EQvekclKLQY2nZyiOUQRlVlJ2rEFjbC73LCTg9799/0qmwOQ3+kuj5FywH6nbU/8ckeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GsbS4Sw15ffaz8qVeqdZl5yarhOra7Ro1zRToupS0NU=; b=K99ePuZbziHJUvNyhjhSqRLx+p
 G3Wvc0t7J8F/G9bnkJQRF27DtJ6XQKml36mjNz5WpDVyq7K0AuzaG1cH0Jk36WpHhkFCWE1LVjwoj
 kwL2IQrAQIGodDRFyTqek+dFRnadktyroJcaQCZuSnrJF/pWrsWIa5uPOgRjRO6RXfeI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpNvd-0005m5-RS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:23:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E2FE600BC;
 Thu, 30 Jul 2026 10:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CC1F000E9;
 Thu, 30 Jul 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785407027;
 bh=GsbS4Sw15ffaz8qVeqdZl5yarhOra7Ro1zRToupS0NU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=OOlAKKWH5ZLW4C4vRqStaiLEwGPcFmygYug/aHGsoHcnv84pN+zBCWP3wF93rw3vv
 0PIBoAJo4wAlHH4er7u69Q2owCaDEpzPQ4cWhH6lJ6c6zOknODiyvPwoHmDSll3NrN
 UWUXY+yi+F//BQz8wBCMl+uLK5DhgCL/1TiA0aJrE8s/Sddo3d0FB/uuMH+IbXnFWN
 0qCkLTxIQ+oz2tJb06CQwc02ccXJY/jo266ABzN9gwRNJJwcNvu8zgQ9oH89Ioy2z3
 D5NssKKrsXf+IcF/ysQ67DgWGxrfjvG81CwidTrDH4zZ6k8A2FASFI/h8LD3URJ6nt
 RwJd7eHy4XaMA==
MIME-Version: 1.0
To: Rochan Avlur <rochan.avlur@gmail.com>
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
Date: Thu, 30 Jul 2026 12:23:42 +0200
Message-Id: <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9VBLNDT4VKqFoxo1wXCe9pbICUl3NYjOWY9OtJVLAHY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlqxmWTf0f/bf7xn3mAxK9+ZxRlgvObqq7ncGgkrjGJ
 KFde/eKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0djD8z01hMDV8MvdJyAaT
 /bItp/pY+zItfnWzPY129WJUO8UqwvA/c9GOGadPLetY2OAY45bKXyLgo90lOJHl4fwX9WxLrfa
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wpNvd-0005m5-RS
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Rochan,

> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Seems generally fine to me,
Acked-by: Christian Brauner (Amutable) <braurg>

-- 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
