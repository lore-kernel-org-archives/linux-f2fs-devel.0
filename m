Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C28EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 12 Aug 2023 02:17:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qUeBl-0001Rd-Rf;
	Sat, 12 Aug 2023 02:17:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qUeBk-0001RW-Q1
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Aug 2023 02:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fc5IMyvcaHYZaOauJeUQ7xar7PJmlNmIMw/O5jjGEQE=; b=WV4HlIYqbic5KMOaBveimW01cy
 BcHfFErRumk+8mesYivNjNCPnZfBJ4vvjF9PdJPd15KJu7uPe6h1S18dJwg3yI1amCG6epHdg0DfZ
 qcWLlI8gxONcBAi6hwn2d5vHPZ8cD3CSZOjYoRJW05dbU8aoaqbZmesw51Hsljdxvz8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fc5IMyvcaHYZaOauJeUQ7xar7PJmlNmIMw/O5jjGEQE=; b=jKev+KG3bUoKWp1LS4cJIN6rN/
 2/+wPt53o0TvhRkAZpe31qGd1XeffCOGHbK0b1WPrd7nh1PTXjrqLoBwWA+qWHAhuQW+FAtpsNfWQ
 mXtVM3oVjuSWL5JchRHl/eKjrDx72HKi+jK4aw3XabcagVj0CTFP14tKRh7Py6IhZ/jI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qUeBl-0030gZ-7K for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 12 Aug 2023 02:17:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2F51F63B76;
 Sat, 12 Aug 2023 02:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B424C433C8;
 Sat, 12 Aug 2023 02:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1691806622;
 bh=KkGApD2bQBxfwXufVKLzvLsVh2fjASCPPP51XodQzmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eiqzcNxrOSSQ6E1KFA9DV6ukfVf+hhsy6F7f35fibpb/sM5K4u7TIKc+zRzG+7Amz
 a46A6f6madZHz3QvqjVmICvvtecgVmsGW4cbw3jWzxtFhcGC6/1U7LRkvyL4pgtj3A
 RWrko0n9QCv/riiYjqTm3OZLGcTR8skwaMF0wPgeiJb5dcJoUTMWQaCutHGtQ9cGil
 RDRu0HY6Bdzxr3jDhVwlwgiHIWIkk0GoTbwr+2uMjDyznB3rf1BeKbnj6jY7iK+EEk
 wqJB4n2Fx/C5zx7BH/DrMtOMd/gStCfj3+cZdm0AxUKCbjToPkdvZOe3Xo8C6XqTWH
 v9qSqu6rjHJvw==
Date: Fri, 11 Aug 2023 19:17:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20230812021700.GC971@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-6-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-6-krisman@suse.de>
X-Headers-End: 1qUeBl-0030gZ-7K
Subject: Re: [f2fs-dev] [PATCH v5 05/10] fs: Add DCACHE_CASEFOLDED_NAME flag
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
Cc: brauner@kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 11, 2023 at 08:41:41PM -0400, Gabriel Krisman Bertazi wrote:
> +void d_set_casefolded_name(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags |= DCACHE_CASEFOLDED_NAME;
> +	spin_unlock(&dentry->d_lock);
> +}
> +EXPORT_SYMBOL(d_set_casefold_lookup);

s/d_set_casefold_lookup/d_set_casefolded_name/

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
