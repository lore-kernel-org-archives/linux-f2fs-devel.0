Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA78EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 21:19:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrnYf-0001gt-J1; Thu, 19 May 2022 21:19:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nrnYe-0001gn-1t
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QRGm4Pgh5p6EzwpDKwNNGs3/FmpopRUmvMlDBIgeBhI=; b=h1awvd1eDv5FARjPQrszULwXde
 VcU4u2PhNfAbErH6abVR8ZczNysS5JPLuGDtPbC/BBoJq43bPpmdsWfC1hbU+mYmVF7+uVSZbloWv
 Cgp/NES5E1a/69Yb2v04rRRlotTKzBpyn8FtAQKB9E/2TveGerZSv/DhfTO16suwfGhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QRGm4Pgh5p6EzwpDKwNNGs3/FmpopRUmvMlDBIgeBhI=; b=ZrICre1AZZS7FSNXW/qXrH6Iz/
 RmaofuazhtrfbOA00FRaxeW7+a4YZAeV5o+ORIOpybGA9cmmrMb3kVP5+xL1nD5YAbMFny/c9IXMr
 iw0tkk/0kbcoxsuxhOE8+iLC/X1gECiz6oOzUCpBND0XTKkOcFOc5NdRNC3NSkuHDSwU=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrnYZ-0002sf-2r
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 21:19:42 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id B46201F45F91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652995171;
 bh=9UAgBFTt2vdRr0ftu7setFAvUFoAFx2iq2uAUNBM4AA=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=Im0BK9bmSGNNu17ndQ3QcKrFatwtidljSZ1Er0F77FtlZuQh7qiPBsrDwBN3HoS9z
 3s7iPjaDsY6wsKyp5PT5fSORRHmklU/Umt0gdSgmXpUcI4XMmL5h0UzoktC2Rvb2l2
 yVdciciPQWWo5z+ckfX/T8eeW1KIWqsT8auOlXQ0B5BpiPIZwWSPsm6YxvONIy+FgA
 uUEDgOyRK0yGmCqT27wiwVhCYm6A9f+5WmRFuPXnDFE7tY0aXVSt5hPg6dmP8VZrxb
 eokjrTFH5cxCgiJhuGR3yXy2f98K3kOavn0Mow8PMeSc8HB2qVolTESqdaMkWE1hXX
 n090p52E/csnQ==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu
Organization: Collabora
References: <20220519204645.16528-1-krisman@collabora.com>
Date: Thu, 19 May 2022 17:19:28 -0400
In-Reply-To: <20220519204645.16528-1-krisman@collabora.com> (Gabriel Krisman
 Bertazi's message of "Thu, 19 May 2022 16:46:37 -0400")
Message-ID: <871qwpnrtr.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1nrnYZ-0002sf-2r
Subject: Re: [f2fs-dev] [PATCH v7 0/8] Clean up the case-insensitive lookup
 path
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Hi Eric, Ted,
>
> This is v7 of this series (thank you for the feedback!) .  This picks up
> a few r-b tags and has one small fix asked by Eric to handle a corner
> case in ext4_match when IS_ENCRYPTED() and the key is added during
> lookup.
>

Ugh, sorry. this is a bogus submission. please, disregard.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
