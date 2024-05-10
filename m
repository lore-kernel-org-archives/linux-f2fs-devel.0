Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A3BC10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:24:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5EzX-0003Yi-Oi;
	Fri, 10 May 2024 01:24:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5EzW-0003Yb-S2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dbcq9r4a1zuyNEODGiydTSBfojzJz8zigK0WVkCLQIg=; b=RHap0vNSgJfXDgCk86TCg9Ebq4
 QPTWg2FVMPifCT3te1RpfpZsJKNaenpGdxzpHgnwTqgkANvUzXgXubg4NW+ybF7Of+7mxbpnhW/X6
 /6eXFSvHEFQ2AuocGus0gN7YmKhdKXYLJzK1e0FxoB6u+aukMu9+jKZUVe8mnN5HRwx4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Dbcq9r4a1zuyNEODGiydTSBfojzJz8zigK0WVkCLQIg=; b=g7Oj0MSChDyZpRSCcaFwAzryI5
 deP6Q1UuMLc8mOJB21X1IbhU9OfuJfONKbA92tzOMBYqC/iwp2xUTyi9uL5dUKiJrJJBU7xofKWBC
 d5HcrUctSIJHB43frZpD7ZCDGMOj9zS3jXWXGhS7Q+1ZJQ6Iqbm/zJDAQvEq1UqAzSUo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5EzX-0007VU-CU for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:24:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 479FF61E06;
 Fri, 10 May 2024 01:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF57BC116B1;
 Fri, 10 May 2024 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304236;
 bh=tIyORSm6DKfQad0bExBOsbDG3bWKnUdmlkmb3uP/VY0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WznK5tlS6cb5FZPFvUTkVUxaKLtE9OHpwcxChR6TS1xr6gla47v2Fspn4KO+5bMWf
 6GC1OpBsnFOvoVGWxDT429Rjoh5zrG5OXloyP8cY+faxaCOILrCw/BPSbpDUI5t2n/
 y8LTRZiAi2CXSnslUU+CNPKcPDs9+Qt5tJGOI1vVbqZ7LVoFG45WeNVhavY7Z9v4Yv
 /Sfh+RxxkkjKqs8PnO8BcqL4bViFOS1jLEdFcD5b84+MEjw8LDue+z3nm0ssrbkX1f
 mk2bryTrOWHbSGklza+C9N+W9S9E+cacdVmZcP7ZBaImRxahllsC17zGvCoK7fOaNG
 Hx/6ELgMit/ng==
Date: Fri, 10 May 2024 01:23:54 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012354.GC1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-5-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-5-eugen.hristev@collabora.com>
X-Headers-End: 1s5EzX-0007VU-CU
Subject: Re: [f2fs-dev] [PATCH v16 4/9] ext4: Reuse generic_ci_match for ci
 comparisons
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:27PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of reimplementing ext4_match_ci, use the new libfs helper.
> 
> It also adds a comment explaining why fname->cf_name.name must be
> checked prior to the encryption hash optimization, because that tripped
> me before.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/ext4/namei.c | 91 +++++++++++++++----------------------------------
>  1 file changed, 27 insertions(+), 64 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
