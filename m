Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861BDC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 03:36:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrWxG-00040O-32; Thu, 19 May 2022 03:36:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrWxE-0003zw-Aq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 03:36:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Its71XFVYoa58WQOt8++SgemsdzWmGq2JONAUc7smE=; b=OG+f8vw6GyZWP9dwb2oOqeWUt4
 mP3LJNSk4xOCNx4CpzK25VxsO/b4xoO5ymDErx8NK5KlnHF2VUvmW+MyB2QbsRaAZMPlb38xGvrKW
 ZRnGdgThyM6fPEv64+P/V9jcoUIAUD9h3QmM21S011LtRyLzw0CyxF0dnedsQcYxJEgg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2Its71XFVYoa58WQOt8++SgemsdzWmGq2JONAUc7smE=; b=Ae2rQzFWD+QemOv8wPEtz8APQP
 xyI6IJ5ozJFZqjcBKxwIEJUDW+GviixQTtaB+llUqPJO1IrGceLp50y3cS8oaCDofRAjeFqUXF3V8
 girLCEATRN6vIjfMQRYZyrQpVrObGPnrMDWcIbn2Otwfmu9vfcPCf9DNNtBomYI9u1K4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrWxA-0004bI-UD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 03:36:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D68E561962;
 Thu, 19 May 2022 03:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71687C34100;
 Thu, 19 May 2022 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652931348;
 bh=NES1fN52Zk0zMrldfi2XEcba5q9hgSK/AWFsZ5uhd+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g9IDVAWlVKhFMx2ww5WFcfUCc8NQnSuhV7A4S/xBsz/3EzqjHRQQBu97zVrN9bqXP
 E4rDCNrP0aoGZLoX4d6TPY9PzqCKobWMtFMGA9t9I7k97nYgXoLPCgOWU5kV7R4zTU
 AaaTcKKgtjb4ymo0DW11d9FQLP0yz9vjAjKHsEKBw3IHm4tCWY88HQ/FSMIyN2UPje
 dUAlLAcOYr852LGHhMjlJwDKSCCeVLq2Iws5mDwVn4TFTHC4F07XfGwwjUKfWMGLKR
 rkTu9QzwlrLPos62heovwUIaUQJOcQ0PEiRJ9anN8kV84yRu8n70/yuJvLQnp5jYxW
 RXeG5zivD1z9g==
Date: Wed, 18 May 2022 20:35:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YoW7EhTqz0CPOZCL@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519014044.508099-4-krisman@collabora.com>
X-Headers-End: 1nrWxA-0004bI-UD
Subject: Re: [f2fs-dev] [PATCH v6 3/8] libfs: Introduce case-insensitive
 string comparison helper
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
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 jaegeuk@kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 18, 2022 at 09:40:39PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 974125270a42..c8f40ee35743 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1465,6 +1465,74 @@ static const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
>  };
> +
> +/**
> + * generic_ci_match() - Match a name (case-insensitively) name with a dirent.

The word "name" is duplicated above.

Otherwise this looks good:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
