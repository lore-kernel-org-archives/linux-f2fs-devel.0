Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713EBEB64DC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Jul 2023 05:55:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qKBm8-0001YA-0C;
	Fri, 14 Jul 2023 05:55:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qKBm1-0001Y3-US
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Jul 2023 05:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ubKHXPE3lhZ6gaGYN7NJAXMwYds7BVJ9xEUFMJjcpk0=; b=iR87VVqORWtRVVkYR5u9xdCOOY
 AGloVwVNnGI41eITxEsIFaHj7GbTuezLdUqwdMFXA559RESB8Lxa80IN3tnhM1XUL8sU57kGGH5Ux
 twUImTglfnCMNOHjQJqTgwjYw7D35/ze0k7CbiUpzoHvsjTzz19YbeaLn/Wy/80tQYpA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ubKHXPE3lhZ6gaGYN7NJAXMwYds7BVJ9xEUFMJjcpk0=; b=X/4iGv5DC0ggtWwR/jmXJMLwjN
 CMxi3XnqxmBddG6Ml7nLcD0CAB2+GfGgHLXYgsVNFk25757AO8MF+KviaQ7v93rdiNo4OFHbCRh94
 G///y7S+ENDuH/EihFLWtl23O/+PtzJGkivvaiySiUrmD3AC9UrYmBS7dzsjeVYEbmHc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qKBm1-007B5J-Ku for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Jul 2023 05:55:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 10B1261C17;
 Fri, 14 Jul 2023 05:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC76C433C7;
 Fri, 14 Jul 2023 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689314119;
 bh=IXG6OKn01yJj0TE1xVyNQVVP2cgIJ84xsyC/CW0XIaU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lNSPH9QfHOdM9FO2SngD10EMxHIkKS12TAD6XmT2erE4WSzUHeNZqG1g7ORyq9Ptc
 Wc7RRfwHvx/wbR5WolW+1AXcbpMN09Y3E/WXLvIdB34yAaMhs9YktbrqvSGTCKTKKl
 6XZuOTEeIQsVog29Cz2aPr0e50H4Qxk7DlNn/9O6OZdN2w9+USiaxuK1FjyuX7Mowp
 VOJpP2p+PuN9wgFUJhrU4aTJbs5cFsg0224yfp8ayO73ubM67xA4jKtUDGoFT824fK
 Dq6P8F3ZmDt6Rwle9l0TAQQZE7eH5nZHHj29VmmGWjvMa7nTKF8WD/A8tvxWoW927/
 zeswo3tOfNpuQ==
Date: Thu, 13 Jul 2023 22:55:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20230714055517.GG913@sol.localdomain>
References: <20230422000310.1802-1-krisman@suse.de>
 <20230422000310.1802-3-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230422000310.1802-3-krisman@suse.de>
X-Headers-End: 1qKBm1-007B5J-Ku
Subject: Re: [f2fs-dev] [PATCH v2 2/7] fs: Add DCACHE_CASEFOLD_LOOKUP flag
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
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 21, 2023 at 08:03:05PM -0400, Gabriel Krisman Bertazi wrote:
> @@ -209,6 +209,7 @@ struct dentry_operations {
>  #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
>  #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
>  #define DCACHE_OP_REAL			0x04000000
> +#define DCACHE_CASEFOLD_LOOKUP		0x08000000 /* Dentry comes from a casefold directory */
>  
>  #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
>  #define DCACHE_DENTRY_CURSOR		0x20000000

The first time I read DCACHE_CASEFOLD_LOOKUP, I got the wrong impression, since
it uses _LOOKUP in a different way from DCACHE_PAR_LOOKUP.  DCACHE_PAR_LOOKUP
uses it to mean "dentry is currently being looked up", while
DCACHE_CASEFOLD_LOOKUP uses it to mean "dentry *was* looked up".

Maybe DCACHE_CASEFOLDED_NAME would be more logical?  That would follow
DCACHE_NOKEY_NAME.  (Also CASEFOLD => CASEFOLDED would be logical, I think.)

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
