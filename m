Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA5C41535
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 19 Dec 2023 22:56:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rFj0k-00070x-FG;
	Tue, 19 Dec 2023 22:56:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rFj0j-00070r-Ih
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Dec 2023 22:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hsJw39T9kLzgQ5bIf9Hg2WdIRhpd1/AAdToIOqp6/tY=; b=isFMqvBA3EQltpAY9kym6rpBK2
 WxVrHG0Qc3E536w053NbyjVLdB+AN/ZNiIwWZ/By8qzjLMSvj68jALp/M5heyGV2g6/2yTAshfKRR
 kNocSoyxNK0BDiiW1CY7gjyjfSKjiBpBrr2agJIpi6hQOM2tVgIpvjrE/eQnLrarYrPo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hsJw39T9kLzgQ5bIf9Hg2WdIRhpd1/AAdToIOqp6/tY=; b=Xi4HTNvSyvhrucLW/Ebt36cwQA
 OBWhcO2GPKdx6770Yef/gR3Jcip8xsbfjPgKHzBLE6qutDke7v2rsvc7wQ5YcO1xRPx7UJvUrvj7y
 cRkg11M9CZg3o8WvCeKIq/LGUBTfjzAZHV51gVUHuuCdETVPPaT3abxQDc1C9+9xxfnk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rFj0h-0001Ip-PC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 19 Dec 2023 22:56:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 29645CE1AB3;
 Tue, 19 Dec 2023 22:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BFC433C7;
 Tue, 19 Dec 2023 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703026571;
 bh=1KsVpI26Wy0emSPFohmEhY9TLu8feCCZJtIibblPW04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RaB2a4GW2tUetf4bOxFILnQyWYM33jV3DBMa354fhOl6Z3uVP5FGxm2oMt0P669Rx
 KhlHLCVk2012BYjCdKhL12/gdt/fFQDdNb4dUtKAlU1zTFYkfoeMen9/J7mLn/e4uy
 FSBd03r1T+IEST4c6dmc+ptQFP+bqhjRl3I3zHOnFzJIoKuXZoR2rNL2p4niND4jn9
 8A/wpofnnPdEx6z50q8pG+HQGPxmf2jevYxgkGMB15dcPQ27JUExUqiZPOfH3+jTm1
 mwPD3Yq80OQiodZMbXzAHQwfwuAq7wD6rUfIvt+l5wVw3HjrHiABX4zqUYRTRRUl20
 Nd6BtGxeO7Wtw==
Date: Tue, 19 Dec 2023 15:56:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20231219225609.GF38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-5-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-5-krisman@suse.de>
X-Headers-End: 1rFj0h-0001Ip-PC
Subject: Re: [f2fs-dev] [PATCH v2 4/8] libfs: Expose generic_ci_dentry_ops
 outside of libfs
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
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Dec 15, 2023 at 04:16:04PM -0500, Gabriel Krisman Bertazi wrote:
> In preparation to allow filesystems to set this through sb->s_d_op,
> expose the symbol directly to the filesystems.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>  fs/libfs.c         | 2 +-
>  include/linux/fs.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 52c944173e57..b8ecada3a5b2 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1765,7 +1765,7 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	return 0;
>  }
>  
> -static const struct dentry_operations generic_ci_dentry_ops = {
> +const struct dentry_operations generic_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,

This needs an EXPORT_SYMBOL_GPL(), since the filesystems that will use this can
be loadable modules.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
