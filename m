Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA18C98306
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHH8gxxdU0c75aIKtN4w9HwDZBOM5Yv/a4clxyZu3f4=; b=MDKbE7PHwi0CrjxWfjk4w6Oe+0
	DUDGuECZbi5RqJ9Gv23Qq1cLxbgFLhXDG0aO0DrnrI9ToaH2sfSYBn/geO69jXG3jNCzZBsPjhltP
	eP2k/j4iUhGXEsmfGTiTREFVFa49i+fA1k8O/G4ktaseZR0s5ENNT+T6lA0haEywJPxg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9xef-00034g-Of;
	Fri, 25 Sep 2026 04:35:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1x9xee-00034Z-G7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 04:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zhr096L6XvbdPA3YcsFKVElUuzXOCYo2Y4MR6wHtjpo=; b=YyQVb5pEBnsnE5hjC4EP0j5qbb
 1qaZ9oAmRxnRArmT9RkBbKXaDaOVEedVwi8xYjdtr2HzAjWAf85ifkqnDb67IPiJTy1Skfkl75SSA
 a0yuXE8I/9JBXSGsosUqVD6Ra0Lja/5+g4+3tbyyNGvEQ35s2aKWCkd5chFVTPzyHN1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zhr096L6XvbdPA3YcsFKVElUuzXOCYo2Y4MR6wHtjpo=; b=gIGHGt9koetCb7lLEf9CiAFoRV
 dAvYIvSrqRBQ1GNwShqnOG4oguiuFcfv14uH/McFE+RCcTC4DWk4fd8vInrlNYBq+l6sQ+SbjXjN1
 FcixoQgwlMVTdU3F2K02AEnxAZDJo3waVbNRMJIYrLgDELKP6esH7nXY/yBawq8r593A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9xee-0003PE-2o for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 04:35:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 786836022E;
 Fri, 25 Sep 2026 04:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34AD1F000FF;
 Fri, 25 Sep 2026 04:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790310918;
 bh=zhr096L6XvbdPA3YcsFKVElUuzXOCYo2Y4MR6wHtjpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LgJqt2NWo6BFs/+wgDPyGBTzIsX/1RvRLX+mnaNexso4Gf46fMt7p6RykygWjkYKh
 CJEizl1or0wBC3zFbQJedjNWAFUTGkCreAZPQ8L/tcJbe9dO8w7vdFlqOhly+QwvRU
 ZuzV8kZiyYD7yNY/IQSrHitpV4KkXEkSHRydpv8Da2dQU810R5UJKx50RAd3vnebY8
 8c7U6FCwYCdTAkCglGoiVDjvgL2C9s5QeQSVbvOR71u5a29aAFRPUxzEc8NTEtV6ZW
 7dHpBx1o5pRWyGkHhxq9EpUgt4b55ZnI6wH1Ahl8gVYepIJAV2PYe0JvL9x/QkkBxm
 HVq8Bk6FVHaSA==
Date: Thu, 24 Sep 2026 21:35:16 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260925043516.GB112369@sol>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-6-aalbersh@kernel.org>
X-Headers-End: 1x9xee-0003PE-2o
Subject: Re: [f2fs-dev] [PATCH v16 05/21] fsverity: don't allow setting DAX
 file attribute on fsverity files
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:17PM +0200, Andrey Albershteyn wrote:
> When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
> it checks if file has DAX enabled and fails if that's true. However, the
> opposite case is not checked.
> 
> Note, that the only other filesystem supporting DAX and fsverity is
> ext4, and ext4 does check for this case.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/file_attr.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
