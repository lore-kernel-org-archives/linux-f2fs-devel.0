Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63607C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfyqXPaQGcFoPf4NpUf2OjbR+PpJAzu5UxWlI9AM4q8=; b=XWO37qSi04gFaFCMF0oLTuSCZb
	BDbVuV+/ZtfsuPwSv3Cd+BEyA3R268Mj1Cp98X8FsSGA1+XRWuLEFW2y+iECgg1jBSnRBltIoK085
	qIzWH7p3+HUlp7uOajxitxYRdOlwUo+SEluPq5Jp1zQwagZ6JnYtGoI0N6jd6mPnVTuI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyWMI-0001C6-PN;
	Mon, 24 Aug 2026 15:13:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wyWMH-0001By-EM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bfNTPzrQW3MYfLtOrnort7VY3Ro+LqKmQi0rNCTN4b4=; b=U9J2k8cZe4j/z2MVdycre+uFdB
 qccoaVuzQYFyaQAMMDTLxoOOhDjB//S+Lm/fsbDkFpHlJNTwry+H2xDZ5MJk0jXv1/5M+gnJ2u7vY
 dir/04S/77lh/OEI2U51AAjEfFlsyAUrS487fd6/Ec4QMz96pqdl1BVOgACjY8oMb4JI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bfNTPzrQW3MYfLtOrnort7VY3Ro+LqKmQi0rNCTN4b4=; b=e+HWmhgR0+gti85GjKr62umSKj
 HOKV55qz6N9hNF6zwva27Rb4m9L2ARa4jtgsK87f7Ai37YQkGVNkeoFWzE/hj/bLBq9+Q8WKviZ6r
 Nt3OP2orwJh9R/NErhAtt8EIvCFlFSoV9BYBbONvdd4I7hWi2SyhXZ+zN6udGhri2hfQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyWMC-0004lc-Cz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:13:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBB6443687;
 Mon, 24 Aug 2026 15:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC5D1F000E9;
 Mon, 24 Aug 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787584378;
 bh=bfNTPzrQW3MYfLtOrnort7VY3Ro+LqKmQi0rNCTN4b4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mqNsRPL6V6PHTGWqScu1tgf5GWaMZ1K13nvndmPLjzYtmUw21/bkEyutK0hhMwzIJ
 NHdCahlEo3v2PjPar9XEjsFySsqlgdaAqg/CaFs4O4uIWJkazVoD8R20U/jp+5jUFD
 BksZooILZx4FsBO2VfomwjNRc40FAhFB+0vnPCZLiNdz0NMCBOzKuw1uJTbswl3T0L
 4hPSBKxu8JprKKH5TnrKeGfg19Vmh7mtlsUM1s9HlCKLL0htLlADhmcMNpAvnqkxzV
 Low6uZC/pVtw24tOL81v4UOOKKeuKQSsBlhUIQGDaVlWiwOC3sl/dctqalaYacNN1C
 GdzVqYGkoe9hA==
Date: Mon, 24 Aug 2026 15:12:57 +0000
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <aoxfebJ1X6uV_D88@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com>
 <20260823095648.3107875-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260823095648.3107875-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyWMC-0004lc-Cz
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't leave the hashed inode while
 it's unlinked
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Wenjie,

Yeah, valid points. Let me send v3.

On 08/23, Wenjie Qi wrote:
> Hi Jaegeuk,
> 
> It looks like the original symlink construction error is lost here:
> 
> 	err = __do_unlink(dir, inode, &dentry->d_name);
> 
> If fscrypt_encrypt_symlink() or page_symlink() fails but __do_unlink()
> succeeds, err becomes zero. f2fs_handle_failed_inode() then releases the
> inode, and f2fs_symlink() returns success even though the directory entry
> has been removed.
> 
> Is this intended? Should the rollback result be stored separately, for
> example in ret, while preserving the original construction error in err?
> 
> There seems to be a similar issue in the give_up path. If rollback fails
> in a DIRSYNC directory, a successful f2fs_sync_fs() can overwrite the
> existing error with zero.
> 
> Regards,
> Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
