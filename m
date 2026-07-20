Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D294FC44515
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4AapyOB6aK/8svF/2Rb2S3UAvUDK+GsXiaM9bHd4iDs=; b=cH5VvAzRHeqLrQiFwIvclIqHe6
	ljD348PZ1WxaYdJthc6YiUcpB0L4mZcgLlw48QVUxSFqYlq/srKjO8YFZHdMDZzFwlyupjAppEc3M
	H0/1Im3jMplsig7YD+zSAvCd+4REYw+5a3QL+mHle/GiBzhTp9l+yb958/QsCl2YufDs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wls2F-0000mA-1g;
	Mon, 20 Jul 2026 17:44:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wls2C-0000m4-Vy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RP+TS9ppCdXYY/44nHU15MLi2hbKUCvk+juRAlVs5XA=; b=K+PfgFUzjVODJpC9Ufg5vh4io8
 axgyYan31FKpfl4kqC3KG1FPxqPPJRIYU6Ftcg+hzngDM73HRvZQucJoUnZblfphAzPdnOMVivTEJ
 eMVHE6HILykiJbk1H5hB6VMVgkFe0bxC9H6DSeaz48WF1rO3XCWUqG6qUoUMTwwYqIDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RP+TS9ppCdXYY/44nHU15MLi2hbKUCvk+juRAlVs5XA=; b=KFdMGinLWdMvzhHhCP80781BI5
 QCkboP3gf3TTb9LGnTZ80oBND3sfmiNOSN2eyWWZnesvdDLXnOPYMx0e3WzqtSYGr/x0VU1GrgwQ9
 6tbKB3OipX0RzLEwRDY/mtWTAX1yzR8S0oWBML1ldVJyPqG2eYBg5k/V1nnf6fuIuOXA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wls2C-0006ir-9M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 17:44:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B449660051
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 17:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4501E1F000E9;
 Mon, 20 Jul 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784569437;
 bh=RP+TS9ppCdXYY/44nHU15MLi2hbKUCvk+juRAlVs5XA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NHdVmGWvjoGKuK/wead7GtVxZq90L6N9zGUQshGVF2UcHY8n/C6nGC5wGEB9sI4/N
 DNTqSpjB1oJVIZ8ongqH4W5GfD+5c4NBnP4Io9DtJ2Dzjyw49FpMHY09iNiWWL6/do
 BW+EFFlSQLIOrFofF15bpCuzlsqkn4d1TH392FjgrwbpOA7P+o5xTlU+wF9cwoYcS1
 rPLBP6AlES47Z8viBBSpP44E8jCQB+GT18zyWnMVc9YeJ8luqK8lTnGGl5qVYCZoPd
 xNGLbGJzlcGa9uw2JCdasT8bqucbtdASl74rVZpn2OVv4PHEP1/7us+vA/ADBp/UJm
 MbVieH7L/Di0g==
Date: Mon, 20 Jul 2026 10:43:56 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260720174356.GB1865@quark>
References: <20260718214655.63186-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260718214655.63186-1-ebiggers@kernel.org>
X-Headers-End: 1wls2C-0006ir-9M
Subject: Re: [f2fs-dev] [PATCH 0/6] More fscrypt and blk-crypto doc updates
 and code removals
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
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 18, 2026 at 02:46:49PM -0700, Eric Biggers wrote:
> This series applies on top of
> "[PATCH v3 00/17] fscrypt: Standardize on blk-crypto"
> (https://lore.kernel.org/linux-fscrypt/20260713023708.9245-1-ebiggers@kernel.org/).
> It gets more documentation up to date, and it
> removes a couple more functions that are no longer used.
> I'm planning to take both series via the fscrypt tree.
> 
> Eric Biggers (6):
>   fs: Update outdated comment for SB_INLINECRYPT
>   f2fs: Update outdated comment in f2fs_write_begin()
>   fscrypt: Remove unused function fscrypt_finalize_bounce_page()
>   fscrypt: Update docs for data path
>   blk-crypto: Remove unused function blk_crypto_config_supported()
>   blk-crypto: Update docs for blk-crypto-fallback motivation

Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
