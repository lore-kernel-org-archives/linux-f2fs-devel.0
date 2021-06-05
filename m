Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA27C4743D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 02:01:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E5B611AE;
	Mon,  7 Jun 2021 02:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5B611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lq4aK-0001S7-C0; Mon, 07 Jun 2021 02:01:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lq4aI-0001Rr-Hm
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 02:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ndSn5YK7iSAunB//PEjmP5iAG3RsYXvcwmLXfWwhmwU=; b=VJvgcd0VGHZSj3IA4JM+nyBOjJ
 kVZho0pUvE1BGy53vUBIBkCHi2dxFXGFt4WHXTKwYtRwzjGOrmwm6LYXbbZm5t4s9ntIInz50oPZO
 Av6VdhnJ6jeNHj7qGr8uk1HpQJsMg7XJH2opR2Xs0YNmoYSAiYJKsV8gAj8k0FoPDty4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ndSn5YK7iSAunB//PEjmP5iAG3RsYXvcwmLXfWwhmwU=; b=UQKzvLGK4t4Kba/ymSp7vp5tv4
 mX6QHTFsbP8AqRCL2xtcozaAc71NIXSJFeFEMKQEjxzpW0Y3bd7/5sD4UjLXcrahm641ysD/AtYng
 r64PavlBAILEAaTvM21i6c3HuMpgszNP87++f1vB8wqo7iL64FauHFeXaa3LiT03uWc0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lq4a9-000653-KF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 02:01:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B9D9613BF;
 Sat,  5 Jun 2021 02:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622858577;
 bh=r4EcPxMJSzOnJumoMVDFIEmBiosX3pqnj+rFFKZBTdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FjKa4X0QV01OweMLfCz0TTewqTcl6egVJWc2mp0IcCUaSoGJzARjsVyOla9pxZjj3
 rdJtQjz0dLc+E5jqGH47SDe++quTm5n7wfLb08ol+TZFXf0HE23Bu/dux2JEZ84etk
 Cz9Oj4vqYJylSd0aBVQ5M9czWqSagDxF2lYOmLJNJc3DeZlh//33XjqwpDT5TJLbMw
 +nrUrrfFyLoopuNTObNYavgzY8CgeuY4uW2aLxSogc9IJ9q1GP6WdKoEqtk+Qo2LdA
 ne5HzTjF9IubV9BiSlks7yn4OsShh8tMKKOLBoWtHyoa7Y1+FH41CEu82VztDTt6ij
 jiLd5oX4Tk+CA==
Date: Fri, 4 Jun 2021 19:02:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YLrbUHfOa3zfwmNs@gmail.com>
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-3-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210605003210.856458-3-jaegeuk@kernel.org>
X-Headers-End: 1lq4a9-000653-KF
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 04, 2021 at 05:32:10PM -0700, Jaegeuk Kim wrote:
> +What:		/sys/fs/f2fs/feature/

features/, not feature/.

> +/*
> + * Note that there are three feature list entries:
> + * 1) /sys/fs/f2fs/features
> + *   : shows runtime features supported by in-kernel f2fs along with Kconfig
> + *     - ref. F2FS_FEATURE_RO_ATTR()
> + *
> + * 2) /sys/fs/f2fs/$s_id/features <deprecated>
> + *   : shows on-disk features enabled by mkfs.f2fs, used for old kernels
> + *
> + * 3) /sys/fs/f2fs/$s_id/feature_list
> + *   : shows on-disk features enabled by mkfs.f2fs per instance.
> + *     this list covers old feature list provided by 2) and beyond
> + *     - ref. F2FS_SB_FEATURE_RO_ATTR()
> + */

It would be helpful to make it clear which of these use the one-feature-per-file
convention and which use the comma-separated features convention.  And also
whether future features will be listed in both (2) and (3), or just in (3).

Otherwise this patch looks good -- thanks!

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
