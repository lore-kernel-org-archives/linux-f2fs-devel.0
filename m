Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC45EC25B0E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Aug 2022 18:49:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oNf9U-0007tg-Bt;
	Mon, 15 Aug 2022 18:49:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oNf99-0007tM-RK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Aug 2022 18:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BqfPz9yVAh3P+rzuEMwUL3g/L2d2sjjJA0A9l4LLb4Y=; b=Qf/dRiEqbQNPMzJYzdxTWwSZWN
 QHqv5n5Ul3TgNAFF61JV6utXEvVvD4tlI+2HaAExpMkk8IUI7Xz5oUKBL17+fKLpBgtCOqPyzZH1F
 xPBn7WoumvOc/8hACJQx5/hPYp66Dw+/uK5hdVqPh0YxGED9jQRWeGNMe07gvbO5Zl0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BqfPz9yVAh3P+rzuEMwUL3g/L2d2sjjJA0A9l4LLb4Y=; b=Ya1Vjd0OG7sCuKWZBlKz8jiOJY
 KnMsoXXXFMajjq4+j9eWpgpBNXxkbZ3esvgQziX7j2c/dCNbgon5+rDDEuHVbPLUr4v9eHjasTh83
 HkrTRqQEEwjULuFrPYgO+GrQlXeWkZfCPoiHcwoLkPpuCE+vdUZKlLwLIjtARgyqHndM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oNf8M-0000zi-A2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Aug 2022 18:48:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA9536121D;
 Mon, 15 Aug 2022 18:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8523BC433C1;
 Mon, 15 Aug 2022 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660589292;
 bh=BRy9d/5usXj2GJIlMpROcnSbw1Cf0yoIwk1b/XPjMc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YJtN/l1qOiuCoUMD5w+crWUXQii15ha6YD/fIvcivrV+ZUQr8KZtQGJ2maAN3aMox
 CaKiPBxIq4pB8TELa5ZPNrT6Lu7PQxa8B1yJW6vvJ6kS1Jd93dOjzA/PlIRZ0la6Ap
 RvAyc1WY8j6Aut2Wr9gmugyDlGOJdS3nbFr6jGd3ON/e6craP2T+JkebO2NZzvboWe
 8UvsBRaVYmkLRLo0em43f+In/HixsqcRZcYxK8o63iTu8tu7nNphmARVnSJ0D3lh52
 bgf1u7MRtmyJs0HJr2FAQX+5fgAyuWah7NgX5btYgM0IAs9RLQaXL1sPf5jvqY13+c
 lZcHdUYS3nNjQ==
Date: Mon, 15 Aug 2022 11:48:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Message-ID: <YvqU6qenlAmEg6ev@sol.localdomain>
References: <20220513231605.175121-1-ebiggers@kernel.org>
 <20220513231605.175121-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220513231605.175121-6-ebiggers@kernel.org>
X-Headers-End: 1oNf8M-0000zi-A2
Subject: Re: [f2fs-dev] [PATCH v3 5/5] fscrypt: remove
 fscrypt_set_test_dummy_encryption()
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
Cc: Lukas Czerner <lczerner@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 13, 2022 at 04:16:05PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that all its callers have been converted to
> fscrypt_parse_test_dummy_encryption() and fscrypt_add_test_dummy_key()
> instead, fscrypt_set_test_dummy_encryption() can be removed.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/policy.c      | 13 -------------
>  include/linux/fscrypt.h |  2 --
>  2 files changed, 15 deletions(-)

Now that all its prerequisites are upstream, I've applied this patch to
fscrypt.git#master for 6.1.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
