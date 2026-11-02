Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B2606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jeu48iYL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kteXuRGM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Mu2YAY0N;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5+xw8Oi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9LninUkAHeVuvpCnF/XbFh39u1RwZkUq68j8VLL8V7c=; b=jeu48iYLMn0fWU
	vbsbAkXkkHQjMWSfIn5TMPc+8S1KbNaOe8F+6GyUyLGyIjUbZxOExT+ccgE/Y7eYtghyCUeBQhahY
	XfX7M4SNPXJulwHYw3pfdW0TI7i+e4JwH8LrgwWurdvEHfcOjw/Lny4EFiluTeIdbnmziOXA3XJ/q
	cfA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhWn-000000005m4-16un;
	Mon, 02 Nov 2026 02:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNhWl-000000005lx-3Zfd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8VELrUAvWIl1oNglpEzNvSK1b25VeVp7s80WKqjSVYQ=; b=kteXuRGMIZnPV2cXXZ4853FnoM
 BjSI0Mr365PCnA4b8KOSZkQPQ9EvdVZflgj8mxQWodOlqGOFrQtxCN+q28xrvMPpJBnwU/wggm08Z
 k1ZKurn+7wWeXNLkYsWn53w/yL+412n3kzk8LUmeJHRJU5wZQ2lfDIt1eVA5SD/kyBYU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8VELrUAvWIl1oNglpEzNvSK1b25VeVp7s80WKqjSVYQ=; b=Mu2YAY0NgIm1h2cRIUlnanA2bI
 CSuIgMyMi6j8QJ+Jok4RXWX/7DBPYEIcxVKSkiWIvf12YA0iX3Swa3qpzi4wm7M/taoaYJE14Jl/k
 flzPPPfprR+neI2zMXabVLZkVSG8IFZk3Z7AdUSrk6dEwSRVHVvk5ee21wFkk2DMLjU4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNhWl-000000008Jl-1YJ8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:12:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B335860098;
 Mon,  2 Nov 2026 02:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380A61F000C1;
 Mon,  2 Nov 2026 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793585517;
 bh=8VELrUAvWIl1oNglpEzNvSK1b25VeVp7s80WKqjSVYQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=P5+xw8Oi0b2hy3QKZ+KnhcQ1aB2DO5t5Up4KSmQS6j2AvqzEbd3WczI9yth4HIxaF
 oh8cztQX0YAYWBaAVLtanRY5m9Mkf3kfHckMdLkmIoz5JNWYeme5cZgkaCoUm+rq7d
 m98Wz11ZMhM/JynYoMM/ogplkImnphBYWEEC/qxaNZeYsrjVSg/aEsTPAoGk+cIr6/
 B8Tcay4ASmQTU9qdBwfr2kGC5/IOWnJdRvpefOlmCVu2/DDZIKpRwVi7f9uWZhTpKl
 HgICkYTO7H2Pqmm0oW+xaBdbtC/AkPAs4cInsLOvMHep9bqJJkynM5C9nsHmX+RR36
 /wdIZmWvteM3w==
Message-ID: <0696ac2d-58a2-42d4-9b5e-6a353f772f71@kernel.org>
Date: Mon, 2 Nov 2026 10:11:53 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hungyu Lin <dennylin0707@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261031233935.9600-1-dennylin0707@gmail.com>
Content-Language: en-US
In-Reply-To: <20261031233935.9600-1-dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNhWl-000000008Jl-1YJ8
Subject: Re: [f2fs-dev] [PATCH] f2fs: preserve 64-bit FITRIM minimum lengths
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 07:39, Hungyu Lin wrote:
> The FITRIM minimum length is a 64-bit byte count. f2fs_ioc_fitrim()
> narrows it to unsigned int while applying the device granularity, so a
> minimum of 4 GiB becomes the device granularity. fstrim can consequently
> discard free extents smaller than the requested minimum.
> 
> Use u64 when applying the device granularity. The checkpoint's
> trim_minlen already retains the 64-bit block count; also widen the
> discard policy field and its initializer argument so larger minimums
> are not truncated when passed to the issue and wait paths.
> 

Cc: stable@vger.kernel.org

> Fixes: 4b2fecc84655 ("f2fs: introduce FITRIM in f2fs_ioctl")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
