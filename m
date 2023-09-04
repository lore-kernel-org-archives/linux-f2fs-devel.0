Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B32C71153
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Sep 2023 09:38:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qd621-0005uO-GU;
	Mon, 04 Sep 2023 09:38:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1qd61y-0005uI-RF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 09:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UZkmHeZuhDbdtBQNooL110wT7dpbvORI4hG7bJsFk6g=; b=EwwXGZph/cjjQ5kSkfYpHDaMYI
 Vru/DZhuG2nVMiSkDslp2BjguAggRTfbgAf2Jx/Bnb84bEcKoWGlxse76fr9ckzLa6SRcVPEz8b73
 h6w0X4W9YTCibW5CPgIYAdnuAkx5lVzQXb0DRfk4l/aaEdb5RmvRuFBXvCi+TkIgR1xE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UZkmHeZuhDbdtBQNooL110wT7dpbvORI4hG7bJsFk6g=; b=aISRLwgj9SlrPiFFpndI9NjWiL
 f+04zv5q/XbuBUfECHheS0ut+j848XIesU/blBYZVTMr2wb+hv7wiQr5KghGWIVmsBCbKOou/X6+H
 0+OewVp3TPyBO15TPY8/Zxkk+OEtEAqIRjAicGBbWg7HPkgk0fk0HFAabp9M74bfZlLA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qd61u-0004zv-Ch for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Sep 2023 09:38:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 65EF361538;
 Mon,  4 Sep 2023 09:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93463C433C8;
 Mon,  4 Sep 2023 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693820264;
 bh=0Ik33Yv016rCo6eme+x5SGC/ICJgl1qh75BuncMETlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MNfTeWYfzXJeH0UCFNOg/c0GoULakcQjn9VfWyUVERq4CF/GjwF0GqntM6SDP3JOZ
 HmWkjCX0fWCD0NTKEH60CwhxbThIKelKwPhRfwlUENM6XFv/l0IS1o7emDiU3H4sDY
 gBdwt4UfhIf4zsES+N5uNZjpkjwhbVWi5Ab2OqyRyLp8TjL/51+ZKLnqqjiaytC1AP
 9u5Hfrd311fN8uwk04vQvyQIEWGhHff8ReEnBJpxmNpAhf+mTtmR61x3ITKiyEvg8N
 IV2NFewIfJBwDwTjOygKdvYQVenO5HAiINSRfH2ApWi+qCWlvA9GPQvzS06JcPFvo3
 SRfjpmfcvOp9Q==
Date: Mon, 4 Sep 2023 11:37:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hao Xu <hao.xu@linux.dev>
Message-ID: <20230904-qualm-molekular-84b4d1c79769@brauner>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-11-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230827132835.1373581-11-hao.xu@linux.dev>
X-Headers-End: 1qd61u-0004zv-Ch
Subject: Re: [f2fs-dev] [PATCH 10/11] vfs: trylock inode->i_rwsem in
 iterate_dir() to support nowait
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Aug 27, 2023 at 09:28:34PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> Trylock inode->i_rwsem in iterate_dir() to support nowait semantics and
> error out -EAGAIN when there is contention.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---

Unreviewable until you rebased on -rc1 as far as I'm concerned because
the code in here changed a lot.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
